import 'package:ebooks_up/model/BooksModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
Future<void> AddToLibrary (String? title,String? category,String? type, String? author,String? imgPath,String? FilePath) async {
    final prefs=await SharedPreferences.getInstance();
    prefs.setString('type', type.toString());
    prefs.setString('bookTitle', title.toString());
    prefs.setString('category', category.toString());
    prefs.setString('author', author.toString());
    prefs.setString('imgPath', imgPath.toString());
    prefs.setString('filePath', FilePath.toString());

}

Future<String?> getImagepath(String imgUrl,String? title)async{
    final Reference storageRef=FirebaseStorage.instance.refFromURL(imgUrl);
    final String filename=title.toString();
    final Directory appDir=await getApplicationDocumentsDirectory();
    final File file=File('${appDir.path}/$filename');
    if(!await file.exists()){
      await storageRef.writeToFile(file);
    }
    return file.path;
  }
Future<String?> getFilepath(String FileUrl,String? title)async{
  final Reference storageRef=FirebaseStorage.instance.refFromURL(FileUrl);
  final String filename=title.toString();
  final Directory appDir=await getApplicationDocumentsDirectory();
  final File file=File('${appDir.path}/$filename');
  if(!await file.exists()){
    await storageRef.writeToFile(file);
  }
  return file.path;
}

}