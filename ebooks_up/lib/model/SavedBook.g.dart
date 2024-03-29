// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SavedBook.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedBookAdapter extends TypeAdapter<SavedBook> {
  @override
  final int typeId = 0;

  @override
  SavedBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedBook(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as bool
    );
  }

  @override
  void write(BinaryWriter writer, SavedBook obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.fileUrl)
      ..writeByte(3)
      ..write(obj.imgUrl)
      ..writeByte(4)
      ..write(obj.bookType)
      ..writeByte(5)
      ..write(obj.added);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
