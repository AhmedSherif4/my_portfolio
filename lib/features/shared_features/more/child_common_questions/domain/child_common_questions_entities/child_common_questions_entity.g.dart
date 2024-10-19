// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_common_questions_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommonQuestionEntityAdapter extends TypeAdapter<CommonQuestionEntity> {
  @override
  final int typeId = 19;

  @override
  CommonQuestionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommonQuestionEntity(
      question: fields[0] as String,
      answer: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CommonQuestionEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonQuestionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
