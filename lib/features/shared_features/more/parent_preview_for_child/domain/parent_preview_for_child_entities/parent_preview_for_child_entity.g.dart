// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_preview_for_child_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParentPreviewForChildEntityAdapter
    extends TypeAdapter<ParentPreviewForChildEntity> {
  @override
  final int typeId = 20;

  @override
  ParentPreviewForChildEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParentPreviewForChildEntity(
      parentId: fields[0] as int,
      name: fields[1] as String,
      phone: fields[2] as String,
      email: fields[3] as String,
      type: fields[4] as String,
      gender: fields[5] as String,
      imgPath: fields[6] as String,
      username: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ParentPreviewForChildEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.parentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.imgPath)
      ..writeByte(7)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParentPreviewForChildEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
