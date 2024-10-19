import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'ayahs_entity.g.dart';

@HiveType(typeId: 12)
class AyahsEntity extends Equatable {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String? audio;
  @HiveField(2)
  final List<String>? audioSecondary;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final int numberInSurah;
  @HiveField(5)
  final int juz;
  @HiveField(6)
  final int manzil;
  @HiveField(7)
  final int page;
  @HiveField(8)
  final int ruku;
  @HiveField(9)
  final int hizbQuarter;
  @HiveField(10)
  final bool sajda;
  @HiveField(11)
  final String suruhName;
  const AyahsEntity({
    required this.number,
    this.audio,
    this.audioSecondary,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    required this.suruhName
  });

  @override
  List<Object?> get props {
    return [
      number,
      audio,
      audioSecondary,
      text,
      numberInSurah,
      juz,
      manzil,
      page,
      ruku,
      hizbQuarter,
      sajda,
      suruhName
    ];
  }
}