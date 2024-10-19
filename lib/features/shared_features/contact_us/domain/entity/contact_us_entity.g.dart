// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactUsEntityAdapter extends TypeAdapter<ContactUsEntity> {
  @override
  final int typeId = 13;

  @override
  ContactUsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactUsEntity(
      email: fields[0] as String,
      facebook: fields[1] as String,
      instagram: fields[2] as String?,
      twitter: fields[3] as String?,
      linkedIn: fields[4] as String?,
      snapchat: fields[5] as String?,
      pinterest: fields[6] as String?,
      tiktok: fields[7] as String?,
      threads: fields[8] as String?,
      youtube: fields[9] as String?,
      telegram: fields[10] as String?,
      whatsapp: fields[11] as String,
      messageForParentAfterAddFirstChild: fields[12] as String,
      messageForParentAfterAddSecondChild: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactUsEntity obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.facebook)
      ..writeByte(2)
      ..write(obj.instagram)
      ..writeByte(3)
      ..write(obj.twitter)
      ..writeByte(4)
      ..write(obj.linkedIn)
      ..writeByte(5)
      ..write(obj.snapchat)
      ..writeByte(6)
      ..write(obj.pinterest)
      ..writeByte(7)
      ..write(obj.tiktok)
      ..writeByte(8)
      ..write(obj.threads)
      ..writeByte(9)
      ..write(obj.youtube)
      ..writeByte(10)
      ..write(obj.telegram)
      ..writeByte(11)
      ..write(obj.whatsapp)
      ..writeByte(12)
      ..write(obj.messageForParentAfterAddFirstChild)
      ..writeByte(13)
      ..write(obj.messageForParentAfterAddSecondChild);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactUsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
