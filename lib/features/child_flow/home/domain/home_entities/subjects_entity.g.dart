// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsEntityAdapter extends TypeAdapter<SubjectsEntity> {
  @override
  final int typeId = 2;

  @override
  SubjectsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectsEntity(
      isHaveUnit: fields[8] as bool,
      itemColor: fields[3] as String,
      subjectName: fields[1] as String,
      subjectImg: fields[2] as String,
      subjectId: fields[0] as int,
      price: fields[4] as int,
      classroomId: fields[5] as int,
      termId: fields[6] as int,
      stageId: fields[7] as int,
      oldPrice: fields[9] as int,
      pathId: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectsEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.subjectImg)
      ..writeByte(3)
      ..write(obj.itemColor)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.classroomId)
      ..writeByte(6)
      ..write(obj.termId)
      ..writeByte(7)
      ..write(obj.stageId)
      ..writeByte(8)
      ..write(obj.isHaveUnit)
      ..writeByte(9)
      ..write(obj.oldPrice)
      ..writeByte(10)
      ..write(obj.pathId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
