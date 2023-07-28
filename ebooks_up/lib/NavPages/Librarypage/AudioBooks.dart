import 'package:ebooks_up/AudioPlayer.dart';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import '../../main.dart';
import '../../model/SavedBook.dart';

class AudioBooks extends StatefulWidget {
  const AudioBooks({Key? key}) : super(key: key);

  @override
  State<AudioBooks> createState() => _AudioBooksState();
}

class _AudioBooksState extends State<AudioBooks> {
  var bookBox;
  Future<void> OpenBox() async {
    await Hive.openBox<SavedBook>(Abooks).then((value) {
      setState(() {
        bookBox = value;
      });
    });

  }

  Future<void> deleteBookData(int index) async {
    setState(() {
      bookBox.deleteAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OpenBox();

  }
  BooksModel bookmodel=BooksModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 250,top: 10),
              child: const Text(
                "Saved Books",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xffb3b3b3)),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                  itemBuilder: (context,index){
                    var book;
                    if(bookBox.length>0){
                      final checkbook=bookBox.getAt(index) as SavedBook;
                      if(checkbook.bookType=='audio'){
                        book=checkbook;
                    }
                    }
                  if(bookBox.length>0){
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white70,width: 1.0),
                        )
                      ),
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
                                  Audioplayer(
                                    title: book.title,
                                    imgUrl: book.imgUrl,
                                    fileUrl: book.fileUrl,
                                    offline: true,
                                   ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return  const Divider(height: 16.0);
                  },
                  itemCount: bookBox.length),
            )
          ],
        ),
      ),
    );
  }
}
