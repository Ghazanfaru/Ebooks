import 'package:ebooks_up/model/BooksModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
class BooksController{
CollectionReference textBook=FirebaseFirestore.instance.collection('text');
CollectionReference audioBook=FirebaseFirestore.instance.collection('audio');

  Future<BooksModel> GetTextBook()async{
    BooksModel book=BooksModel();
  QuerySnapshot snapshots=await textBook.get();
  snapshots.docs.forEach((doc) {
book.bookInfo.addAll({
  'title': doc['title'],
  'isbn': doc['isbn'],
  'id':doc['id'],
  'description':doc['description'],
  'imgurl':doc['imgUrl'],
  'fileUrl':doc['fileUrl']
}
);
  });
return book;
  }


Future<File> _downloadFile(String url, String filename) async {
  var httpClient = http.Client();
  var request = await httpClient.get(Uri.parse(url));
  var bytes = request.bodyBytes;
  var dir = await getApplicationDocumentsDirectory();
  File file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes);
  return file;
}

void saveBook(String bookUrl,String fileName) async {

  File bookFile = await _downloadFile(bookUrl, fileName);
  // Save the bookFile path to a database or shared preferences so that you can load it when offline.
}

void loadBook() async {
  String fileName = 'mybook.pdf';
  var dir = await getApplicationDocumentsDirectory();
  String filePath = '${dir.path}/$fileName';
  if (File(filePath).existsSync()) {
    // Load the book from the local storage.
  } else {
    // Show an error message that the book is not available offline.
  }
}
}