import 'package:hive/hive.dart';
part 'SavedBook.g.dart';
@HiveType(typeId: 0)
class SavedBook extends HiveObject {
  @HiveField(0)
  String bookId;

  @HiveField(1)
  String title;

  @HiveField(2)
  String fileUrl;

  @HiveField(3)
  String imgUrl;

  @HiveField(4)
  String bookType;

  @HiveField(5)
  bool added;

  SavedBook(this.bookId, this.title, this.fileUrl, this.imgUrl, this.bookType,this.added);
}
