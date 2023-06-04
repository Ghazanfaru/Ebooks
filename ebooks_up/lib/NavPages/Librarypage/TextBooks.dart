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
  var bookmarks;
  var bookBox;

  @override
  void initState() {
    super.initState();
    OpenBox();
  }

  Future<void> OpenBox() async {
    var box= await Hive.openBox<SavedBook>(Rbooks);
   setState(() {
     bookBox=box;
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
              onTap: () {},
              child: TextButtons(text: selected, btntxt: "Select"),
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 16.0);
                },
                itemCount: bookBox.length,
                itemBuilder: (context, index) {
                  final book = bookBox.getAt(index) as SavedBook;
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white70, width: 1.0),
                        )),
                    child: ListTile(
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
                                    offline: true),
                          ),
                        );
                      },
                    ),
                  );
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
