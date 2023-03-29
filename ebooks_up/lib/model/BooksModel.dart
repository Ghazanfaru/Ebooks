class BooksModel{
  int? id,isbn,rating;
  String? title,url,imgUrl,desc;
  var category;
  var author;
  var fileUrl;
  BooksModel({this.id,this.isbn,this.rating,this.title,this.desc,this.imgUrl,this.fileUrl,this.author,this.category});
  Map<String,dynamic> bookInfo={};
}