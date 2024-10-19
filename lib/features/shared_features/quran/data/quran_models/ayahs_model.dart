part of '../../quran.dart';

class AyahsModel extends AyahsEntity {
  const AyahsModel({
    required super.number,
    super.audio,
    super.audioSecondary,
    required super.text,
    required super.numberInSurah,
    required super.juz,
    required super.manzil,
    required super.page,
    required super.ruku,
    required super.hizbQuarter,
    required super.sajda,
    required super.suruhName
  });

  factory AyahsModel.fromMap(Map<String, dynamic> map) {
    return AyahsModel(
        number: map['number'] as int,
        audio: map['audio'] != null ? map['audio'] as String : null,
        audioSecondary: map['audioSecondary'] != null
            ? List<String>.from((map['audioSecondary'] as List<dynamic>))
            : null,
        text: map['text'] as String,
        numberInSurah: map['numberInSurah'] as int,
        juz: map['juz'] as int,
        manzil: map['manzil'] as int,
        page: map['page'] as int,
        ruku: map['ruku'] as int,
        hizbQuarter: map['hizbQuarter'] as int,
        sajda: map['sajda'] == false
            ? map['sajda'] as bool
            : map['sajda']['recommended'] as bool,
        suruhName:map['surah']==null?"":map['surah']['name']??""
    );
  }
}