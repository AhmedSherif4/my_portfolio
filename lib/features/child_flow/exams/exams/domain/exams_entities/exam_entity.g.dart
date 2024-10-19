// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamEntityAdapter extends TypeAdapter<ExamEntity> {
  @override
  final int typeId = 5;

  @override
  ExamEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      file: fields[2] as String,
      degree: fields[3] as int,
      stageId: fields[4] as int,
      classroomId: fields[5] as int,
      termId: fields[6] as int,
      subjectId: fields[7] as int,
      result: fields[8] as ResultExamEntity,
      systemId: fields[9] as int,
      pathId: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ExamEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.file)
      ..writeByte(3)
      ..write(obj.degree)
      ..writeByte(4)
      ..write(obj.stageId)
      ..writeByte(5)
      ..write(obj.classroomId)
      ..writeByte(6)
      ..write(obj.termId)
      ..writeByte(7)
      ..write(obj.subjectId)
      ..writeByte(8)
      ..write(obj.result)
      ..writeByte(9)
      ..write(obj.systemId)
      ..writeByte(10)
      ..write(obj.pathId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
