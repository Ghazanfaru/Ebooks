import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebooks_up/AudioPlayer.dart';
import 'package:ebooks_up/NavPages/HomePage/PDFViewer.dart';
import 'package:ebooks_up/NavPages/TopChartsPage/Rating.dart';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

class BookTile extends StatefulWidget {
  BooksModel book;
  String type;
  BookTile({super.key,required this.book,required this.type});

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  var box;

  bool added = false;
  Future<void> OpenBox() async {
    box = await Hive.openBox<SavedBook>(Rbooks);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OpenBox();
  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 200,
      child: Column(
        children: [
          InkWell(
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
                                      widget.book.title
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
                                widget.book.desc.toString(),
                                style:
                                const TextStyle(
                                    color: Colors
                                        .white,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Rating(type:widget.type, documentID: widget.book.id.toString(), oldRating:widget.book.rating??0),
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
                                    if(widget.type=='audio') {
                                      await Navigator
                                        .pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              Audioplayer(booksModel: widget.book,offline: false,)
                                      ),
                                    );
                                    }
                                    else{
                                      await Navigator
                                          .pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  PDFViewer(title: widget.book.title.toString(),
                                                    fileUrl: widget.book.fileUrl.toString(),
                                                    offline: false, isBookmark: false, pageNo: 0,

                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: widget.type=='audio'? const Text(
                                    'Play',
                                    style: TextStyle(
                                        fontSize: 18),
                                  ):
                                  const Text(
                                    'Read',
                                    style: TextStyle(
                                        fontSize: 18),
                                  )
                                  ,
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
                                    if(widget.type=='audio') {
                                      saveToLibrary(
                                        widget.book.id
                                            .toString(),
                                        widget.book.title
                                            .toString(),
                                        'audio',
                                        widget.book.fileUrl
                                            .toString(),
                                       widget.book.imgUrl
                                            .toString());
                                    }
                                    else{
                                      saveToLibrary(
                                          widget.book.id
                                              .toString(),
                                          widget.book.title
                                              .toString(),
                                          'text',
                                          widget.book.fileUrl
                                              .toString(),
                                          widget.book.imgUrl
                                              .toString());
                                    }
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

              child: CachedNetworkImage(imageUrl: widget.book.imgUrl.toString(),width: 80,height: 60,)),
          const SizedBox(height: 10,),
          SizedBox(
              height: 30,
              width: 150,
              child: Text(widget.book.title.toString(),overflow: TextOverflow.ellipsis,style: const TextStyle(
                color: Colors.white70
              ),)),

        ],
      ),
    );
  }

  Future<void> saveToLibrary(String id, String title, String type,
      String fileUrl, String imgUrl) async {
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
}
