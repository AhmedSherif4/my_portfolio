// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_subscriptions_studying_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChildSubscriptionsStudyingEntityAdapter
    extends TypeAdapter<ChildSubscriptionsStudyingEntity> {
  @override
  final int typeId = 10;

  @override
  ChildSubscriptionsStudyingEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChildSubscriptionsStudyingEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      termHavePathOrNot: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChildSubscriptionsStudyingEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.termHavePathOrNot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildSubscriptionsStudyingEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
