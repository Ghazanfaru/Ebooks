import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/NavPages/HomePage/BookTile.dart';
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ebooks_up/model/SavedBook.dart';


class ReadableBooks extends StatefulWidget {
  const ReadableBooks({super.key});

  @override
  State<ReadableBooks> createState() => _ReadableBooksState();
}

class _ReadableBooksState extends State<ReadableBooks> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  var category = 'Career & Growth';
  var category2 = 'Career & Growth';
  var category3 = 'Career & Growth';
  var category4 = 'Career & Growth';
  var category5 = 'Career & Growth';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212121),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: store
                .collection('text')
                .where('category', isEqualTo: category)
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
                                        child: BookTile(book: book, type: 'text')),
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
                                        child: BookTile(book: book, type: 'text')),
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
                                        child: BookTile(book: book, type: 'text')),
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
                                        child: BookTile(book: book, type: 'text')),
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
                                        child: BookTile(book: book, type: 'text')),
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


}
