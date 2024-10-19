// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_and_conditions_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TermsAndConditionsEntityAdapter
    extends TypeAdapter<TermsAndConditionsEntity> {
  @override
  final int typeId = 11;

  @override
  TermsAndConditionsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TermsAndConditionsEntity(
      title: fields[0] as String,
      content: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TermsAndConditionsEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TermsAndConditionsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
