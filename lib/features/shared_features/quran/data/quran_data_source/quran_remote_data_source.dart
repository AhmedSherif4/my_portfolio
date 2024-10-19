part of '../../quran.dart';

enum TypeOfSelection { surah, juz, hizbQuarter, page }

abstract class QuranRemoteDataSource {
  Future<List<AyahsEntity>> getQuranPage({required int pageNumber});

  Future<List<AyahsEntity>> getQuranTafseer(
      {required QuranParameter quranParameter});

  Future<List<AyahsEntity>> getQuranText(
      {required QuranParameter quranParameter});

  Future<List<AyahsEntity>> getQuranAudio(
      {required QuranParameter quranParameter});
}

@LazySingleton(as: QuranRemoteDataSource)
class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  QuranRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<List<AyahsEntity>> getQuranAudio(
      {required QuranParameter quranParameter}) async {
    return await _baseGetData(
      quranParameter: quranParameter,
      type: 'ar.husary',
    );
  }

  @override
  Future<List<AyahsEntity>> getQuranTafseer(
      {required QuranParameter quranParameter}) async {
    return await _baseGetData(
      quranParameter: quranParameter,
      type: 'ar.muyassar',
    );
  }

  @override
  Future<List<AyahsEntity>> getQuranText(
      {required QuranParameter quranParameter}) async {
    return await _baseGetData(
      quranParameter: quranParameter,
      type: 'quran-uthmani',
    );
  }

  @override
  Future<List<AyahsEntity>> getQuranPage({required int pageNumber}) async {
    final response = await baseRemoteDataSource.get(
      url: 'https://api.alquran.cloud/v1/page/$pageNumber/ar.husary',
    );
    return List<AyahsEntity>.from(
      (response['data']['ayahs'] as List).map(
            (ayah) => AyahsModel.fromMap(ayah),
      ),
    );
  }

  Future<List<AyahsEntity>> _baseGetData(
      {required QuranParameter quranParameter, required String type}) async {
    final response = await baseRemoteDataSource.get(
      url:
      'https://api.alquran.cloud/v1/${quranParameter.typeOfSelection.name}/${quranParameter.selectionId}/$type',
    );

    return List<AyahsEntity>.from(
      (response['data']['ayahs'] as List).map(
            (ayah) => AyahsModel.fromMap(ayah),
      ),
    );
  }
}

class QuranParameter extends Equatable {
  final TypeOfSelection typeOfSelection;
  final int selectionId;
  final String selectionText;
  final String? pageNumber;
  final String? ayaInSuruhNumber;

  const QuranParameter(
      {required this.typeOfSelection,
        required this.selectionId,
        required this.selectionText,
        this.pageNumber,
        this.ayaInSuruhNumber});
  QuranParameter copyWith(
      {required TypeOfSelection typeOfSelection,
        required int selectionId,
        required String selectionText,
        String? pageNumber,
        String? ayaInSuruhNumber}) {
    return QuranParameter(
      typeOfSelection: typeOfSelection,
      selectionId: selectionId,
      selectionText: selectionText,
      pageNumber: pageNumber ?? this.pageNumber,
      ayaInSuruhNumber: ayaInSuruhNumber ?? this.ayaInSuruhNumber,
    );
  }

  @override
  List<Object?> get props => [
    typeOfSelection,
    selectionId,
    selectionText,
    pageNumber,
    ayaInSuruhNumber
  ];
}