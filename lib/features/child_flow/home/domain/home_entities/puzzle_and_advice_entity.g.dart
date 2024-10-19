// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle_and_advice_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuzzleAndAdviceEntityAdapter extends TypeAdapter<PuzzleAndAdviceEntity> {
  @override
  final int typeId = 9;

  @override
  PuzzleAndAdviceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PuzzleAndAdviceEntity(
      advice: fields[0] as String,
      content: fields[1] as String,
      select1: fields[2] as String?,
      select2: fields[3] as String?,
      select3: fields[4] as String?,
      select4: fields[5] as String?,
      correctSelect: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PuzzleAndAdviceEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.advice)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.select1)
      ..writeByte(3)
      ..write(obj.select2)
      ..writeByte(4)
      ..write(obj.select3)
      ..writeByte(5)
      ..write(obj.select4)
      ..writeByte(6)
      ..write(obj.correctSelect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuzzleAndAdviceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
