// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonEntityAdapter extends TypeAdapter<LessonEntity> {
  @override
  final int typeId = 3;

  @override
  LessonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonEntity(
      lessonId: fields[5] as int,
      description: fields[0] as String,
      name: fields[1] as String,
      imgPath: fields[2] as String,
      lessonSkipPoints: fields[3] as int,
      lessonUserPoints: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LessonEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imgPath)
      ..writeByte(3)
      ..write(obj.lessonSkipPoints)
      ..writeByte(4)
      ..write(obj.lessonUserPoints)
      ..writeByte(5)
      ..write(obj.lessonId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
