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
import '../BookTile.dart';


class AudiableBooks extends StatefulWidget {
  const AudiableBooks({super.key});
  @override
  State<AudiableBooks> createState() => _AudiableBooksState();
}

class _AudiableBooksState extends State<AudiableBooks> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  var category = 'Career & Growth';
  var category2 = 'Career & Growth';
  var category3 = 'Career & Growth';
  var category4 = 'Career & Growth';
  var category5 = 'Career & Growth';
  bool added=false;

  var box;
  Future<void> OpenBox()async{
      box= await  Hive.openBox<SavedBook>(Abooks);
  }
  @override
  void initState() {
    // TODO: implement initState
    OpenBox();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xff212121),
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
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(height: 10,),
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
                          child: Text(category,style: const TextStyle(
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
                                          padding: const EdgeInsets.only(left: 10,right: 10,),
                                          height: 250,
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
                        const SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20,),
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
                          child: Text(category2,style: const TextStyle(
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
                                          padding: const EdgeInsets.only(left: 10,right: 10,),
                                          height: 200,
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
                        const SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20,),
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
                          child: Text(category3,style: const TextStyle(
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
                                          padding: const EdgeInsets.only(left: 10,right: 10,),
                                          height: 200,
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
                        const SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20,),
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
                          child: Text(category4,style: const TextStyle(
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
                                          padding: const EdgeInsets.only(left: 10,right: 10,),
                                          height: 200,
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
                        const SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20,),
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
                          child: Text(category5,style: const TextStyle(
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
                                          padding: const EdgeInsets.only(left: 10,right: 10,),
                                          height: 200,
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
