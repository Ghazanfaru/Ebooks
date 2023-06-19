import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/NavPages/HomePage/BookTile.dart';
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ReadableBooks extends StatefulWidget {
  const ReadableBooks({super.key});

  @override
  State<ReadableBooks> createState() => _ReadableBooksState();
}

class _ReadableBooksState extends State<ReadableBooks> {
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
  var category2 = 'Career & Growth';
  var category3 = 'Career & Growth';
  var category4 = 'Career & Growth';
  var category5 = 'Career & Growth';
  var box;

  bool added = false;
  Future<void> OpenBox() async {
    box = await Hive.openBox<SavedBook>(Rbooks);
  }

  @override
  void initState() {
    // TODO: implement initState
    OpenBox();
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
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.green,
                ));
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return Flex(
                    direction: Axis.vertical,
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
                      const Divider(
                        height: 2,

                        color: Color(0xff212121),
                      ),
                      Expanded(
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
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    border: const Border(
                                    left: BorderSide(
                                      width: 1,
                                      color: Colors.black87
                                    )
                                    )
                                  ),
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                    height: 200,
                                    width: 100,

                                    child: BookTile(book: book, type: 'text'));
                                // return Container(
                                //   padding: const EdgeInsets.only(top: 30,bottom: 10),
                                //     decoration: const BoxDecoration(
                                //       border: Border(
                                //         bottom: BorderSide(
                                //           width: 1.0,
                                //           color: Colors.blueGrey
                                //         )
                                //       )
                                //     ),
                                //     child: CupertinoListTile(
                                //       subtitle: InkWell(
                                //           child: Rating(
                                //               type: 'text',
                                //               documentID: book.id.toString(),
                                //               oldRating: book.rating ?? 0)),
                                //
                                //       trailing: SizedBox(
                                //         height: 80,
                                //         width: 100,
                                //         child: CachedNetworkImage(
                                //             errorWidget: (context, url, error) => const Icon(Icons.error),
                                //
                                //             imageUrl: book.imgUrl.toString()),
                                //       ),
                                //       title: InkWell(
                                //         onTap: () {
                                //           showModalBottomSheet<dynamic>(
                                //               isDismissible: true,
                                //               backgroundColor:
                                //                   const Color(0xff212121),
                                //               shape: const RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                 top: Radius.circular(30),
                                //               )),
                                //               context: context,
                                //               builder: (context) => Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(50),
                                //                     ),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.only(top: 10),
                                //                       child: SingleChildScrollView(
                                //                         child: Column(
                                //                           mainAxisSize:
                                //                               MainAxisSize.max,
                                //                           children: [
                                //                             Row(
                                //                               mainAxisAlignment:
                                //                                   MainAxisAlignment
                                //                                       .spaceBetween,
                                //                               children: [
                                //                                 Text(
                                //                                   book.title
                                //                                       .toString(),
                                //                                   style: const TextStyle(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .bold,
                                //                                       fontSize:
                                //                                           22,
                                //                                       color: Colors
                                //                                           .white),
                                //                                 ),
                                //                                 IconButton(
                                //                                   onPressed: () {
                                //                                     Navigator.pop(
                                //                                         context);
                                //                                   },
                                //                                   icon:
                                //                                       const Icon(
                                //                                     Icons.close,
                                //                                     color: Colors
                                //                                         .white,
                                //                                     size: 22,
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 20,
                                //                             ),
                                //                             Container(
                                //                               decoration: BoxDecoration(
                                //                                 color: Colors.blueGrey.withOpacity(0.1),
                                //                                 boxShadow: [
                                //                                   BoxShadow(
                                //                                     color: Colors.blueGrey.withOpacity(0.5),
                                //                                     spreadRadius: 5,
                                //                                     blurRadius: 10,
                                //                                     offset: const Offset(0, 3)
                                //                                   )
                                //                                 ]
                                //                               ),
                                //                               width: 400,
                                //                               height: 180,
                                //                               child: CachedNetworkImage(
                                //                                 imageUrl: book.imgUrl.toString(),
                                //                                 fit: BoxFit.contain
                                //                               ),
                                //                             ),
                                //                             const SizedBox(height: 20,),
                                //
                                //                             Container(
                                //                               padding: const EdgeInsets.only(left: 140),
                                //                               child: Rating(
                                //                                   type: 'text',
                                //                                   documentID: book.id.toString(),
                                //                                   oldRating: book.rating ?? 0),
                                //                             ),
                                //                             const SizedBox(height: 10,),
                                //                             Text(
                                //                               book.desc.toString(),
                                //                               style:
                                //                                   const TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed:
                                //                                     () async {
                                //                                   await Navigator
                                //                                       .pushReplacement(
                                //                                     context,
                                //                                     MaterialPageRoute(
                                //                                       builder:
                                //                                           (context) =>
                                //                                               PDFViewer(title: book.title.toString(),
                                //                                                 fileUrl: book.fileUrl.toString(),
                                //                                                 offline: false, isBookmark: false, pageNo: 0,
                                //
                                //                                       ),
                                //                                     ),
                                //                                   );
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Read Now',
                                //                                   style: TextStyle(
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed: () {
                                //                                   saveToLibrary(
                                //                                       book.id
                                //                                           .toString(),
                                //                                       book.title
                                //                                           .toString(),
                                //                                       'text',
                                //                                       book.fileUrl
                                //                                           .toString(),
                                //                                       book.imgUrl
                                //                                           .toString());
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Add to Library',
                                //                                   style: TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ));
                                //         },
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               book.title.toString(),
                                //               style: const TextStyle(
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                   FontWeight.w900,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 5,),
                                //             Text(
                                //               "By ${book.author.toString()}",
                                //               style: const TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight:
                                //                   FontWeight.w300,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 10,)
                                //           ],
                                //         ),
                                //       ),
                                //     ));
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      ),
                      Text(category2,style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                      const Divider(
                        height: 2,
                        color: Color(0xff212121),
                      ),
                      Expanded(
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
                                return Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.white70,
                                    child: BookTile(book: book, type: 'text'));
                                // return Container(
                                //   padding: const EdgeInsets.only(top: 30,bottom: 10),
                                //     decoration: const BoxDecoration(
                                //       border: Border(
                                //         bottom: BorderSide(
                                //           width: 1.0,
                                //           color: Colors.blueGrey
                                //         )
                                //       )
                                //     ),
                                //     child: CupertinoListTile(
                                //       subtitle: InkWell(
                                //           child: Rating(
                                //               type: 'text',
                                //               documentID: book.id.toString(),
                                //               oldRating: book.rating ?? 0)),
                                //
                                //       trailing: SizedBox(
                                //         height: 80,
                                //         width: 100,
                                //         child: CachedNetworkImage(
                                //             errorWidget: (context, url, error) => const Icon(Icons.error),
                                //
                                //             imageUrl: book.imgUrl.toString()),
                                //       ),
                                //       title: InkWell(
                                //         onTap: () {
                                //           showModalBottomSheet<dynamic>(
                                //               isDismissible: true,
                                //               backgroundColor:
                                //                   const Color(0xff212121),
                                //               shape: const RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                 top: Radius.circular(30),
                                //               )),
                                //               context: context,
                                //               builder: (context) => Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(50),
                                //                     ),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.only(top: 10),
                                //                       child: SingleChildScrollView(
                                //                         child: Column(
                                //                           mainAxisSize:
                                //                               MainAxisSize.max,
                                //                           children: [
                                //                             Row(
                                //                               mainAxisAlignment:
                                //                                   MainAxisAlignment
                                //                                       .spaceBetween,
                                //                               children: [
                                //                                 Text(
                                //                                   book.title
                                //                                       .toString(),
                                //                                   style: const TextStyle(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .bold,
                                //                                       fontSize:
                                //                                           22,
                                //                                       color: Colors
                                //                                           .white),
                                //                                 ),
                                //                                 IconButton(
                                //                                   onPressed: () {
                                //                                     Navigator.pop(
                                //                                         context);
                                //                                   },
                                //                                   icon:
                                //                                       const Icon(
                                //                                     Icons.close,
                                //                                     color: Colors
                                //                                         .white,
                                //                                     size: 22,
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 20,
                                //                             ),
                                //                             Container(
                                //                               decoration: BoxDecoration(
                                //                                 color: Colors.blueGrey.withOpacity(0.1),
                                //                                 boxShadow: [
                                //                                   BoxShadow(
                                //                                     color: Colors.blueGrey.withOpacity(0.5),
                                //                                     spreadRadius: 5,
                                //                                     blurRadius: 10,
                                //                                     offset: const Offset(0, 3)
                                //                                   )
                                //                                 ]
                                //                               ),
                                //                               width: 400,
                                //                               height: 180,
                                //                               child: CachedNetworkImage(
                                //                                 imageUrl: book.imgUrl.toString(),
                                //                                 fit: BoxFit.contain
                                //                               ),
                                //                             ),
                                //                             const SizedBox(height: 20,),
                                //
                                //                             Container(
                                //                               padding: const EdgeInsets.only(left: 140),
                                //                               child: Rating(
                                //                                   type: 'text',
                                //                                   documentID: book.id.toString(),
                                //                                   oldRating: book.rating ?? 0),
                                //                             ),
                                //                             const SizedBox(height: 10,),
                                //                             Text(
                                //                               book.desc.toString(),
                                //                               style:
                                //                                   const TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed:
                                //                                     () async {
                                //                                   await Navigator
                                //                                       .pushReplacement(
                                //                                     context,
                                //                                     MaterialPageRoute(
                                //                                       builder:
                                //                                           (context) =>
                                //                                               PDFViewer(title: book.title.toString(),
                                //                                                 fileUrl: book.fileUrl.toString(),
                                //                                                 offline: false, isBookmark: false, pageNo: 0,
                                //
                                //                                       ),
                                //                                     ),
                                //                                   );
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Read Now',
                                //                                   style: TextStyle(
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed: () {
                                //                                   saveToLibrary(
                                //                                       book.id
                                //                                           .toString(),
                                //                                       book.title
                                //                                           .toString(),
                                //                                       'text',
                                //                                       book.fileUrl
                                //                                           .toString(),
                                //                                       book.imgUrl
                                //                                           .toString());
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Add to Library',
                                //                                   style: TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ));
                                //         },
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               book.title.toString(),
                                //               style: const TextStyle(
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                   FontWeight.w900,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 5,),
                                //             Text(
                                //               "By ${book.author.toString()}",
                                //               style: const TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight:
                                //                   FontWeight.w300,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 10,)
                                //           ],
                                //         ),
                                //       ),
                                //     ));
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      ),
                      Text(category3,style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                      const Divider(
                        height: 2,
                        color: Color(0xff212121),
                      ),
                      Expanded(
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
                                return Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.white70,
                                    child: BookTile(book: book, type: 'text'));
                                // return Container(
                                //   padding: const EdgeInsets.only(top: 30,bottom: 10),
                                //     decoration: const BoxDecoration(
                                //       border: Border(
                                //         bottom: BorderSide(
                                //           width: 1.0,
                                //           color: Colors.blueGrey
                                //         )
                                //       )
                                //     ),
                                //     child: CupertinoListTile(
                                //       subtitle: InkWell(
                                //           child: Rating(
                                //               type: 'text',
                                //               documentID: book.id.toString(),
                                //               oldRating: book.rating ?? 0)),
                                //
                                //       trailing: SizedBox(
                                //         height: 80,
                                //         width: 100,
                                //         child: CachedNetworkImage(
                                //             errorWidget: (context, url, error) => const Icon(Icons.error),
                                //
                                //             imageUrl: book.imgUrl.toString()),
                                //       ),
                                //       title: InkWell(
                                //         onTap: () {
                                //           showModalBottomSheet<dynamic>(
                                //               isDismissible: true,
                                //               backgroundColor:
                                //                   const Color(0xff212121),
                                //               shape: const RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                 top: Radius.circular(30),
                                //               )),
                                //               context: context,
                                //               builder: (context) => Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(50),
                                //                     ),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.only(top: 10),
                                //                       child: SingleChildScrollView(
                                //                         child: Column(
                                //                           mainAxisSize:
                                //                               MainAxisSize.max,
                                //                           children: [
                                //                             Row(
                                //                               mainAxisAlignment:
                                //                                   MainAxisAlignment
                                //                                       .spaceBetween,
                                //                               children: [
                                //                                 Text(
                                //                                   book.title
                                //                                       .toString(),
                                //                                   style: const TextStyle(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .bold,
                                //                                       fontSize:
                                //                                           22,
                                //                                       color: Colors
                                //                                           .white),
                                //                                 ),
                                //                                 IconButton(
                                //                                   onPressed: () {
                                //                                     Navigator.pop(
                                //                                         context);
                                //                                   },
                                //                                   icon:
                                //                                       const Icon(
                                //                                     Icons.close,
                                //                                     color: Colors
                                //                                         .white,
                                //                                     size: 22,
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 20,
                                //                             ),
                                //                             Container(
                                //                               decoration: BoxDecoration(
                                //                                 color: Colors.blueGrey.withOpacity(0.1),
                                //                                 boxShadow: [
                                //                                   BoxShadow(
                                //                                     color: Colors.blueGrey.withOpacity(0.5),
                                //                                     spreadRadius: 5,
                                //                                     blurRadius: 10,
                                //                                     offset: const Offset(0, 3)
                                //                                   )
                                //                                 ]
                                //                               ),
                                //                               width: 400,
                                //                               height: 180,
                                //                               child: CachedNetworkImage(
                                //                                 imageUrl: book.imgUrl.toString(),
                                //                                 fit: BoxFit.contain
                                //                               ),
                                //                             ),
                                //                             const SizedBox(height: 20,),
                                //
                                //                             Container(
                                //                               padding: const EdgeInsets.only(left: 140),
                                //                               child: Rating(
                                //                                   type: 'text',
                                //                                   documentID: book.id.toString(),
                                //                                   oldRating: book.rating ?? 0),
                                //                             ),
                                //                             const SizedBox(height: 10,),
                                //                             Text(
                                //                               book.desc.toString(),
                                //                               style:
                                //                                   const TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed:
                                //                                     () async {
                                //                                   await Navigator
                                //                                       .pushReplacement(
                                //                                     context,
                                //                                     MaterialPageRoute(
                                //                                       builder:
                                //                                           (context) =>
                                //                                               PDFViewer(title: book.title.toString(),
                                //                                                 fileUrl: book.fileUrl.toString(),
                                //                                                 offline: false, isBookmark: false, pageNo: 0,
                                //
                                //                                       ),
                                //                                     ),
                                //                                   );
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Read Now',
                                //                                   style: TextStyle(
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed: () {
                                //                                   saveToLibrary(
                                //                                       book.id
                                //                                           .toString(),
                                //                                       book.title
                                //                                           .toString(),
                                //                                       'text',
                                //                                       book.fileUrl
                                //                                           .toString(),
                                //                                       book.imgUrl
                                //                                           .toString());
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Add to Library',
                                //                                   style: TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ));
                                //         },
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               book.title.toString(),
                                //               style: const TextStyle(
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                   FontWeight.w900,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 5,),
                                //             Text(
                                //               "By ${book.author.toString()}",
                                //               style: const TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight:
                                //                   FontWeight.w300,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 10,)
                                //           ],
                                //         ),
                                //       ),
                                //     ));
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      ),
                      Text(category4,style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                      const Divider(
                        height: 2,
                        color: Color(0xff212121),
                      ),
                      Expanded(
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
                                return Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.white70,
                                    child: BookTile(book: book, type: 'text'));
                                // return Container(
                                //   padding: const EdgeInsets.only(top: 30,bottom: 10),
                                //     decoration: const BoxDecoration(
                                //       border: Border(
                                //         bottom: BorderSide(
                                //           width: 1.0,
                                //           color: Colors.blueGrey
                                //         )
                                //       )
                                //     ),
                                //     child: CupertinoListTile(
                                //       subtitle: InkWell(
                                //           child: Rating(
                                //               type: 'text',
                                //               documentID: book.id.toString(),
                                //               oldRating: book.rating ?? 0)),
                                //
                                //       trailing: SizedBox(
                                //         height: 80,
                                //         width: 100,
                                //         child: CachedNetworkImage(
                                //             errorWidget: (context, url, error) => const Icon(Icons.error),
                                //
                                //             imageUrl: book.imgUrl.toString()),
                                //       ),
                                //       title: InkWell(
                                //         onTap: () {
                                //           showModalBottomSheet<dynamic>(
                                //               isDismissible: true,
                                //               backgroundColor:
                                //                   const Color(0xff212121),
                                //               shape: const RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                 top: Radius.circular(30),
                                //               )),
                                //               context: context,
                                //               builder: (context) => Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(50),
                                //                     ),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.only(top: 10),
                                //                       child: SingleChildScrollView(
                                //                         child: Column(
                                //                           mainAxisSize:
                                //                               MainAxisSize.max,
                                //                           children: [
                                //                             Row(
                                //                               mainAxisAlignment:
                                //                                   MainAxisAlignment
                                //                                       .spaceBetween,
                                //                               children: [
                                //                                 Text(
                                //                                   book.title
                                //                                       .toString(),
                                //                                   style: const TextStyle(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .bold,
                                //                                       fontSize:
                                //                                           22,
                                //                                       color: Colors
                                //                                           .white),
                                //                                 ),
                                //                                 IconButton(
                                //                                   onPressed: () {
                                //                                     Navigator.pop(
                                //                                         context);
                                //                                   },
                                //                                   icon:
                                //                                       const Icon(
                                //                                     Icons.close,
                                //                                     color: Colors
                                //                                         .white,
                                //                                     size: 22,
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 20,
                                //                             ),
                                //                             Container(
                                //                               decoration: BoxDecoration(
                                //                                 color: Colors.blueGrey.withOpacity(0.1),
                                //                                 boxShadow: [
                                //                                   BoxShadow(
                                //                                     color: Colors.blueGrey.withOpacity(0.5),
                                //                                     spreadRadius: 5,
                                //                                     blurRadius: 10,
                                //                                     offset: const Offset(0, 3)
                                //                                   )
                                //                                 ]
                                //                               ),
                                //                               width: 400,
                                //                               height: 180,
                                //                               child: CachedNetworkImage(
                                //                                 imageUrl: book.imgUrl.toString(),
                                //                                 fit: BoxFit.contain
                                //                               ),
                                //                             ),
                                //                             const SizedBox(height: 20,),
                                //
                                //                             Container(
                                //                               padding: const EdgeInsets.only(left: 140),
                                //                               child: Rating(
                                //                                   type: 'text',
                                //                                   documentID: book.id.toString(),
                                //                                   oldRating: book.rating ?? 0),
                                //                             ),
                                //                             const SizedBox(height: 10,),
                                //                             Text(
                                //                               book.desc.toString(),
                                //                               style:
                                //                                   const TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed:
                                //                                     () async {
                                //                                   await Navigator
                                //                                       .pushReplacement(
                                //                                     context,
                                //                                     MaterialPageRoute(
                                //                                       builder:
                                //                                           (context) =>
                                //                                               PDFViewer(title: book.title.toString(),
                                //                                                 fileUrl: book.fileUrl.toString(),
                                //                                                 offline: false, isBookmark: false, pageNo: 0,
                                //
                                //                                       ),
                                //                                     ),
                                //                                   );
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Read Now',
                                //                                   style: TextStyle(
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed: () {
                                //                                   saveToLibrary(
                                //                                       book.id
                                //                                           .toString(),
                                //                                       book.title
                                //                                           .toString(),
                                //                                       'text',
                                //                                       book.fileUrl
                                //                                           .toString(),
                                //                                       book.imgUrl
                                //                                           .toString());
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Add to Library',
                                //                                   style: TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ));
                                //         },
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               book.title.toString(),
                                //               style: const TextStyle(
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                   FontWeight.w900,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 5,),
                                //             Text(
                                //               "By ${book.author.toString()}",
                                //               style: const TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight:
                                //                   FontWeight.w300,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 10,)
                                //           ],
                                //         ),
                                //       ),
                                //     ));
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      ),
                      Text(category5,style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                      const Divider(
                        height: 2,
                        color: Color(0xff212121),
                      ),
                      Expanded(
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
                                return Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.white70,
                                    child: BookTile(book: book, type: 'text'));
                                // return Container(
                                //   padding: const EdgeInsets.only(top: 30,bottom: 10),
                                //     decoration: const BoxDecoration(
                                //       border: Border(
                                //         bottom: BorderSide(
                                //           width: 1.0,
                                //           color: Colors.blueGrey
                                //         )
                                //       )
                                //     ),
                                //     child: CupertinoListTile(
                                //       subtitle: InkWell(
                                //           child: Rating(
                                //               type: 'text',
                                //               documentID: book.id.toString(),
                                //               oldRating: book.rating ?? 0)),
                                //
                                //       trailing: SizedBox(
                                //         height: 80,
                                //         width: 100,
                                //         child: CachedNetworkImage(
                                //             errorWidget: (context, url, error) => const Icon(Icons.error),
                                //
                                //             imageUrl: book.imgUrl.toString()),
                                //       ),
                                //       title: InkWell(
                                //         onTap: () {
                                //           showModalBottomSheet<dynamic>(
                                //               isDismissible: true,
                                //               backgroundColor:
                                //                   const Color(0xff212121),
                                //               shape: const RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                 top: Radius.circular(30),
                                //               )),
                                //               context: context,
                                //               builder: (context) => Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(50),
                                //                     ),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.only(top: 10),
                                //                       child: SingleChildScrollView(
                                //                         child: Column(
                                //                           mainAxisSize:
                                //                               MainAxisSize.max,
                                //                           children: [
                                //                             Row(
                                //                               mainAxisAlignment:
                                //                                   MainAxisAlignment
                                //                                       .spaceBetween,
                                //                               children: [
                                //                                 Text(
                                //                                   book.title
                                //                                       .toString(),
                                //                                   style: const TextStyle(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .bold,
                                //                                       fontSize:
                                //                                           22,
                                //                                       color: Colors
                                //                                           .white),
                                //                                 ),
                                //                                 IconButton(
                                //                                   onPressed: () {
                                //                                     Navigator.pop(
                                //                                         context);
                                //                                   },
                                //                                   icon:
                                //                                       const Icon(
                                //                                     Icons.close,
                                //                                     color: Colors
                                //                                         .white,
                                //                                     size: 22,
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 20,
                                //                             ),
                                //                             Container(
                                //                               decoration: BoxDecoration(
                                //                                 color: Colors.blueGrey.withOpacity(0.1),
                                //                                 boxShadow: [
                                //                                   BoxShadow(
                                //                                     color: Colors.blueGrey.withOpacity(0.5),
                                //                                     spreadRadius: 5,
                                //                                     blurRadius: 10,
                                //                                     offset: const Offset(0, 3)
                                //                                   )
                                //                                 ]
                                //                               ),
                                //                               width: 400,
                                //                               height: 180,
                                //                               child: CachedNetworkImage(
                                //                                 imageUrl: book.imgUrl.toString(),
                                //                                 fit: BoxFit.contain
                                //                               ),
                                //                             ),
                                //                             const SizedBox(height: 20,),
                                //
                                //                             Container(
                                //                               padding: const EdgeInsets.only(left: 140),
                                //                               child: Rating(
                                //                                   type: 'text',
                                //                                   documentID: book.id.toString(),
                                //                                   oldRating: book.rating ?? 0),
                                //                             ),
                                //                             const SizedBox(height: 10,),
                                //                             Text(
                                //                               book.desc.toString(),
                                //                               style:
                                //                                   const TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed:
                                //                                     () async {
                                //                                   await Navigator
                                //                                       .pushReplacement(
                                //                                     context,
                                //                                     MaterialPageRoute(
                                //                                       builder:
                                //                                           (context) =>
                                //                                               PDFViewer(title: book.title.toString(),
                                //                                                 fileUrl: book.fileUrl.toString(),
                                //                                                 offline: false, isBookmark: false, pageNo: 0,
                                //
                                //                                       ),
                                //                                     ),
                                //                                   );
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Read Now',
                                //                                   style: TextStyle(
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                             const SizedBox(
                                //                               height: 10,
                                //                             ),
                                //                             SizedBox(
                                //                               width: 300,
                                //                               child: ElevatedButton(
                                //                                 style: ElevatedButton
                                //                                     .styleFrom(
                                //                                         backgroundColor:
                                //                                             Colors
                                //                                                 .blueGrey),
                                //                                 onPressed: () {
                                //                                   saveToLibrary(
                                //                                       book.id
                                //                                           .toString(),
                                //                                       book.title
                                //                                           .toString(),
                                //                                       'text',
                                //                                       book.fileUrl
                                //                                           .toString(),
                                //                                       book.imgUrl
                                //                                           .toString());
                                //                                 },
                                //                                 child: const Text(
                                //                                   'Add to Library',
                                //                                   style: TextStyle(
                                //                                       color: Colors
                                //                                           .white,
                                //                                       fontSize: 18),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ));
                                //         },
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               book.title.toString(),
                                //               style: const TextStyle(
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                   FontWeight.w900,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 5,),
                                //             Text(
                                //               "By ${book.author.toString()}",
                                //               style: const TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight:
                                //                   FontWeight.w300,
                                //                   color: Colors.white),
                                //             ),
                                //             const SizedBox(height: 10,)
                                //           ],
                                //         ),
                                //       ),
                                //     ));
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
    await Fluttertoast.showToast(msg: "Adding to Library",);
    String imgPath = await downloadAndSaveFile(imgUrl, title);
    String filePath = await downloadAndSaveFile(fileUrl, title);
    if (await doesContainValueWithId(id)) {
      await Fluttertoast.showToast(msg: "Already Added");
    } else {
      var rBook = await SavedBook(id, title, filePath, imgPath, type);
      await box.add(rBook).whenComplete(() {
        Fluttertoast.showToast(msg: "Added to Library");
        setState(() {
          added = true;
        });
      }).onError((error, r) async {
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
    if (box != null) {
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
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
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
