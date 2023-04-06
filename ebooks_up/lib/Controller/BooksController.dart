import 'package:ebooks_up/model/BooksModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

}