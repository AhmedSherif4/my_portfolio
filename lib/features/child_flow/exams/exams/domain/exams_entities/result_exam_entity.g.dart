// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_exam_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultExamEntityAdapter extends TypeAdapter<ResultExamEntity> {
  @override
  final int typeId = 6;

  @override
  ResultExamEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultExamEntity(
      id: fields[0] as int,
      file: fields[1] as String,
      degree: fields[2] as int,
      isMark: fields[3] as String,
      childLevel: fields[4] as String?,
      examId: fields[5] as int,
      childId: fields[6] as int,
      reupload: fields[7] as bool,
      description: (fields[8] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResultExamEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.degree)
      ..writeByte(3)
      ..write(obj.isMark)
      ..writeByte(4)
      ..write(obj.childLevel)
      ..writeByte(5)
      ..write(obj.examId)
      ..writeByte(6)
      ..write(obj.childId)
      ..writeByte(7)
      ..write(obj.reupload)
      ..writeByte(8)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultExamEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
