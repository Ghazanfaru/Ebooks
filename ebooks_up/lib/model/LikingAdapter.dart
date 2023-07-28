import 'package:hive/hive.dart';

import 'LikingCategory.dart';

class LikingCategoryAdapter extends TypeAdapter<LikingCategory> {
  @override
  final int typeId = 2;

  @override
  LikingCategory read(BinaryReader reader) {
    return LikingCategory(
      name: reader.readString(),
      isSelected: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, LikingCategory obj) {
    writer.writeString(obj.name);
    writer.writeBool(obj.isSelected);
  }
}
