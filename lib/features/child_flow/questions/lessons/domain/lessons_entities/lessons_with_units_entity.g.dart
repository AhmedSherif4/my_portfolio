// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_with_units_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonWithUnitsEntityAdapter extends TypeAdapter<LessonWithUnitsEntity> {
  @override
  final int typeId = 7;

  @override
  LessonWithUnitsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonWithUnitsEntity(
      unitId: fields[0] as int,
      unitName: fields[1] as String,
      unitLessons: (fields[2] as List).cast<LessonEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, LessonWithUnitsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.unitId)
      ..writeByte(1)
      ..write(obj.unitName)
      ..writeByte(2)
      ..write(obj.unitLessons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonWithUnitsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
