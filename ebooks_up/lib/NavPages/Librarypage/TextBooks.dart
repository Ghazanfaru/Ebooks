import 'package:ebooks_up/model/Bookmark.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/NavPages/HomePage/PDFViewer.dart';
import 'package:ebooks_up/NavPages/HomePage/ReadableBooks/ListsNames.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../../main.dart';

class TextBooks extends StatefulWidget {
  const TextBooks({Key? key}) : super(key: key);
  @override
  State<TextBooks> createState() => _TextBooksState();
}

class _TextBooksState extends State<TextBooks> {
  double Value = 5;
  var selected = "Saved Books";
  var books;
  var bookBox;
  var _bookmark;

   int totalCount=0;
  @override
  void initState() {
    super.initState();
    OpenBox();
  }

  Future<void> OpenBox() async {
    var box= await Hive.openBox<SavedBook>(Rbooks);
    var box2=await Hive.openBox<Bookmark>(RBM);
   setState(() {
     bookBox=box;
     _bookmark=box2;
     if (selected=='Saved Books') {
       totalCount=bookBox.length;
     }
     else {
       totalCount=_bookmark.length;
     }
   });
  }
  Future<void> deleteBookmark(int index) async {

    setState(() {
      _bookmark.deleteAt(index);
    });
  }
  Future<void> deleteBookData(int index) async {

    setState(() {
      bookBox.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body:SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {

                  if(selected=='Saved Books'){
                    setState(() {
                      selected='Bookmarks';
                    });

                  }
                  else if(selected=='Bookmarks') {
                    setState(() {
                      selected='Saved Books';
                    });
                  }


              },
              child: TextButtons(text: selected, btntxt: "Select"),
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 16.0);
                },
                itemCount: totalCount,
                itemBuilder: (context, index) {
                  var book;
                  if(selected=='Saved Books'){
                 book=bookBox.getAt(index) as SavedBook;
                  }
                  else if(selected=='Bookmarks'){
                    if(_bookmark.isNotEmpty && index>=0){
                    book=_bookmark.getAt(index) as Bookmark;
                    }
                    else{
                      Fluttertoast.showToast(msg: "No Bookmarks to show",toastLength: Toast.LENGTH_LONG);
                        selected='Saved Books';
                      book=bookBox.getAt(index) as SavedBook;
                    }
                  }
                 if(totalCount>0) {
                   return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white70, width: 1.0),
                        )),
                    child: selected=='Bookmarks'?
                    ListTile(
                      title: Text(book.title),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    "Do you want to remove ${book.title} from Bookmarks?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () async {
                                        await deleteBookmark(index)
                                            .whenComplete(() =>
                                            Fluttertoast.showToast(
                                                msg: "Removed!"))
                                            .onError((error, stackTrace) =>
                                            Fluttertoast.showToast(
                                                msg:
                                                "Error removing. Please try  again!"))
                                            .then((value) =>
                                            Navigator.pop(context));
                                      },
                                      child: const Text("Confirm"))
                                ],
                              );
                            });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PDFViewer(
                                    title: book.title,
                                    fileUrl: book.fileUrl,
                                    offline: true,
                                  isBookmark: true,
                                  pageNo: book.currentPage,

                                ),
                          ),
                        );
                      },
                    )
                        :ListTile(
                      title: Text(book.title),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    "Do you want to remove ${book.title} from library?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () async {
                                        await deleteBookData(index)
                                            .whenComplete(() =>
                                            Fluttertoast.showToast(
                                                msg: "Removed!"))
                                            .onError((error, stackTrace) =>
                                            Fluttertoast.showToast(
                                                msg:
                                                "Error removing. Please try  again!"))
                                            .then((value) =>
                                            Navigator.pop(context));
                                      },
                                      child: const Text("Confirm"))
                                ],
                              );
                            });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PDFViewer(
                                    title: book.title,
                                    fileUrl: book.fileUrl,
                                    offline: true, isBookmark: false, pageNo: 0,),
                          ),
                        );
                      },
                    ),
                  );
                 }
                }
                ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
