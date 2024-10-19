// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'levels_group_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelAndCollectionEntityAdapter
    extends TypeAdapter<LevelAndCollectionEntity> {
  @override
  final int typeId = 4;

  @override
  LevelAndCollectionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LevelAndCollectionEntity(
      description: fields[5] as String,
      itemColor: fields[6] as String,
      id: fields[0] as int,
      skipPoints: fields[3] as int,
      userPoints: fields[4] as int,
      name: fields[1] as String,
      imgPath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LevelAndCollectionEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imgPath)
      ..writeByte(3)
      ..write(obj.skipPoints)
      ..writeByte(4)
      ..write(obj.userPoints)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.itemColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelAndCollectionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
