import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/AudioPlayer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/BooksModel.dart';
import '../../TopChartsPage/Rating.dart';


class AudiableBooks extends StatefulWidget {
  const AudiableBooks({super.key});
  @override
  State<AudiableBooks> createState() => _AudiableBooksState();
}

class _AudiableBooksState extends State<AudiableBooks> {
  FirebaseFirestore store = FirebaseFirestore.instance;

  List<String> categories = [
    'Career & Growth',
    'Business',
    'Finance ',
    'Money Management',
    'Politics',
    'Philosophy',
    'Foreign Language Studies',
    'Law',
    'Art',
    'Self Improvement',
    'Wellness',
    'Science & Mathematics',
    'Computers',
    'History',
    'Technology',
    'Engineering',
    'Religion',
    'Horror fiction',
    'Humor',
    'Mystery',
    'Poetry',
    'Crime',
    'Children'
  ];

  var category = 'Career & Growth';

  late bool added;

  var box;
  Future<void> OpenBox()async{
    box= await  Hive.openBox<SavedBook>(Abooks);
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    OpenBox();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xff212121),
        floatingActionButton: FloatingActionButton(onPressed: (){
          ShowCategory();
        },
          backgroundColor: Colors.green,
          splashColor: Colors.white,
          child: const Icon(Icons.category),
        ),
        body: Center(
          child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: store
                  .collection('audio')
                  .where('category', isEqualTo: category)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text("Please Connect to Internet"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ));
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          BooksModel book = BooksModel();
                          var document = snapshot.data?.docs[index];
                          if(document.exists){
                            book.id = snapshot.data?.docs[index].id;
                            book.title =
                            snapshot.data?.docs[index]['book_name'];
                            book.category =
                            snapshot.data?.docs[index]['category'];
                            book.imgUrl =
                            snapshot.data?.docs[index]['imgUrl'];
                            book.desc =
                            snapshot.data?.docs[index]['description'];
                            book.author =
                            snapshot.data?.docs[index]['author'];
                            book.fileUrl =
                            snapshot.data?.docs[index]['Fileurl'];
                            return Container(
                                padding: const EdgeInsets.only(top: 30,bottom: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Colors.blueGrey
                                        )
                                    )
                                ),
                                child: CupertinoListTile(
                                  subtitle: InkWell(
                                      child: Rating(
                                          type: 'audio',
                                          documentID: book.id.toString(),
                                          oldRating: book.rating ?? 0)),
                                  trailing: SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: CachedNetworkImage(
                                        errorWidget: (context, url, error) => const Icon(Icons.error),

                                        imageUrl: book.imgUrl.toString()),
                                  ),
                                  title: InkWell(
                                    onTap: () {
                                      showModalBottomSheet<dynamic>(
                                          isDismissible: true,
                                          backgroundColor:
                                          const Color(0xff212121),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                top: Radius.circular(30),
                                              )),
                                          context: context,
                                          builder: (context) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 30,
                                                  horizontal: 30),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 100,
                                                          width: 200,
                                                          child: Text(
                                                            book.title
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                22,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 50,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon:
                                                            const Icon(
                                                              Icons.close,
                                                              color: Colors
                                                                  .white,
                                                              size: 22,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      book.desc.toString(),
                                                      style:
                                                      const TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontSize: 18),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            backgroundColor:
                                                            Colors
                                                                .blueGrey),
                                                        onPressed:
                                                            () async {
                                                          await Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                  Audioplayer(booksModel: book, offline: false,)
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Play',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            backgroundColor:
                                                            Colors
                                                                .blueGrey),
                                                        onPressed: () {
                                                          saveToLibrary(
                                                              book.id
                                                                  .toString(),
                                                              book.title
                                                                  .toString(),
                                                              'audio',
                                                              book.fileUrl
                                                                  .toString(),
                                                              book.imgUrl
                                                                  .toString());
                                                        },
                                                        child: const Text(
                                                          'Add to Library',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          book.title.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          "By ${book.author.toString()}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 10,)
                                      ],
                                    ),
                                  ),
                                ));
                          }
                          else {
                            return const SizedBox.shrink();
                          }}
                    );
                  }
                }
                return const Center(
                  child: Text("Please Connect to Internet"),
                );
              }),
        ));
  }

  Future<void> saveToLibrary(String id, String title, String type,
      String fileUrl, String imgUrl) async {
    String imgPath = await downloadAndSaveFile(imgUrl, title);
    String filePath = await downloadAndSaveFile(fileUrl, title);
    if    (await doesContainValueWithId(id)) {
      await Fluttertoast.showToast(msg: "Already Added");
    } else {
      var ABooks=SavedBook(id, title, filePath, imgPath, type);
      await box.add(ABooks).whenComplete(() {
        Fluttertoast.showToast(msg: "Added to Library");
        setState(() {
          added = true;
        });
      }).onError( (error,r)async{
        await Fluttertoast.showToast(msg: error.toString());
        throw error.toString();
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

  void ShowCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  setState(() {
                    category = categories[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
