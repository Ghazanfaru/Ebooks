import 'package:hive/hive.dart';

part 'Bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late int currentPage;

  @HiveField(2)
  late String fileUrl;

  Bookmark({required this.title, required this.currentPage,required this.fileUrl});
}
