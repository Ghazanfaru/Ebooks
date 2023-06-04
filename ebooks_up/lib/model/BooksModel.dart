class BooksModel{
  int? isbn;
  int? rating=0;
  String? title,url,imgUrl,desc;
  var category;
  var author;
  String? fileUrl,id;
  
  BooksModel({this.id,this.isbn,this.rating,this.title,this.desc,this.imgUrl,this.fileUrl,this.author,this.category});
  Map<String,dynamic> bookInfo={};
}