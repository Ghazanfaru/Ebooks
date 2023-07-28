import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/BooksModel.dart';
import '../../../model/LikingCategory.dart';
import '../BookTile.dart';


class AudiableBooks extends StatefulWidget {
  const AudiableBooks({super.key});
  @override
  State<AudiableBooks> createState() => _AudiableBooksState();
}

class _AudiableBooksState extends State<AudiableBooks> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  List<String> _selectedCategories = [];
  var category = 'Career & Growth';
  bool added=false;
  List<String> imageUrls = [
    'https://www.ibsbuku.com/img/books-banner-140.jpg',
    'https://elective.collegeboard.org/media/2021-02/public-ivy-books-banner.jpg',
  ];
  var box;

  var _likingBox;
  Future<void> OpenBox()async{
    Hive.openBox<LikingCategory>(liking).then((value) {
      setState(() {
        _likingBox=value;
      });
    });
  }
  void _initializeHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<LikingCategory>(liking);
  }
  void getSelectedCategories() {
    final box = Hive.box<LikingCategory>(liking);
    final categories =  box.values
        .where((category) => category.isSelected)
        .map((category) => category.name)
        .toList();
    setState(() {
      _selectedCategories.addAll(categories);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OpenBox();
    getSelectedCategories();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xff212121),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: store
                .collection('audio')
                .where('category', whereIn: _selectedCategories)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text("Please Connect to Internet"),
                );
              } else if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Column(
                  children: [
                    Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        )),
                    Center(
                      child: Text("Loading..."),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      const SizedBox(height: 50,),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Upcoming Books',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                        ),
                        items: imageUrls.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 50,),
                      Container(
                        decoration:const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 2
                                )
                            )
                        ),
                        padding: const EdgeInsets.only(right: 200),
                        child: const Text("Explore Books",style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w800
                        ),),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              BooksModel book = BooksModel();
                              var document = snapshot.data?.docs[index];
                              if (document.exists) {
                                book.id = snapshot.data?.docs[index].id;
                                book.title =
                                snapshot.data?.docs[index]['book_name'];
                                book.category =
                                snapshot.data?.docs[index]['category'];
                                book.imgUrl = snapshot.data?.docs[index]['imgUrl'];
                                book.desc =
                                snapshot.data?.docs[index]['description'];
                                book.author = snapshot.data?.docs[index]['author'];
                                book.fileUrl =
                                snapshot.data?.docs[index]['Fileurl'];
                                return Row(
                                  children: [
                                    const SizedBox(width: 20,),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            border: const Border(
                                                left: BorderSide(
                                                    width: 1,
                                                    color: Colors.black87
                                                )
                                            )
                                        ),
                                        padding: const EdgeInsets.only(right: 10,),

                                        width: 100,
                                        child: BookTile(book: book, type: 'audio')),
                                    const SizedBox(width: 10,)
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      ),
                    ],
                  );
                }
              }
              return const Center(
                child: Text("Please Connect to Internet"),
              );
            }));
  }

  Future<void> saveToLibrary(String id, String title, String type,
      String fileUrl, String imgUrl) async {
    String imgPath = await downloadAndSaveFile(imgUrl, title);
    String filePath = await downloadAndSaveFile(fileUrl, title);
    if    (await doesContainValueWithId(id)) {
      await Fluttertoast.showToast(msg: "Already Added");
    } else {
      var ABooks=SavedBook(id, title, filePath, imgPath, type,true);
      await box.add(ABooks).whenComplete(() {
        Fluttertoast.showToast(msg: "Added to Library");
        setState(() {
          added = true;
        });
      });

    }
  }

  Future<String> downloadAndSaveFile(String fileUrl, String fileName) async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final File file = File('${appDirectory.path}/$fileName');

    await firebase_storage.FirebaseStorage.instance
        .refFromURL(fileUrl)
        .writeToFile(file);

    return file.path;
  }

  Future<bool> doesContainValueWithId(dynamic id) async {
    if(box!=null){
      for (var item in box.values) {
        if (item.bookId == id) {
          return true;
        }
      }
    }

    return false;
  }


}
