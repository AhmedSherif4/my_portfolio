part of '../../quran.dart';

@LazySingleton(as: QuranBaseRepository)
 class QuranRepository implements QuranBaseRepository {
  final QuranRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final QuranLocalDataSource localDataSource;

  QuranRepository({
    required this.remoteDataSource,
    required this.baseRepository,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<AyahsEntity>>> getQuranAudio(
      {required QuranParameter quranParameter}) async {
    final String id =
        '${quranParameter.typeOfSelection.name}${quranParameter.selectionId}audio';
    final quranLocal = await localDataSource.getQuran(id: id);
    if (quranLocal != null) {
      return Right(quranLocal);
    } else {
      final jsonData =
          await baseRepository.checkExceptionForRemoteData<List<AyahsEntity>>(
        remoteDataSource.getQuranAudio(quranParameter: quranParameter),
      );
      return jsonData.fold(
        (failure) => left(failure),
        (data) async {
          await localDataSource.setQuran(
            id: id,
            data: data,
          );
          return Right(data);
        },
      );
    }
  }

  @override
  Future<Either<Failure, List<AyahsEntity>>> getQuranTafseer(
      {required QuranParameter quranParameter}) async {
    final String id =
        '${quranParameter.typeOfSelection.name}${quranParameter.selectionId}tafseer';
    final quranLocal = await localDataSource.getQuran(id: id);
    if (quranLocal != null) {
      return Right(quranLocal);
    } else {
      final jsonData =
          await baseRepository.checkExceptionForRemoteData<List<AyahsEntity>>(
        remoteDataSource.getQuranTafseer(quranParameter: quranParameter),
      );
      return jsonData.fold(
        (failure) => left(failure),
        (data) async {
          await localDataSource.setQuran(
            id: id,
            data: data,
          );
          return Right(data);
        },
      );
    }
  }


  @override
  Future<Either<Failure, List<AyahsEntity>>> getQuranText(
      {required QuranParameter quranParameter}) async {
    final String id =
        '${quranParameter.typeOfSelection.name}${quranParameter.selectionId}text';
    final quranLocal = await localDataSource.getQuran(id: id);
    if (quranLocal != null) {
      return Right(quranLocal);
    } else {
      final jsonData =
          await baseRepository.checkExceptionForRemoteData<List<AyahsEntity>>(
        remoteDataSource.getQuranText(quranParameter: quranParameter),
      );
      return jsonData.fold(
        (failure) => left(failure),
        (data) async {
          await localDataSource.setQuran(
            id: id,
            data: data,
          );
          return Right(data);
        },
      );
    }
  }

  @override
  Future<Either<Failure, List<AyahsEntity>>> getQuranPage(
      {required int pageNumber}) async {
    //final String id = '${pageNumber}page';
    // final quranLocal = await localDataSource.getQuran(id: id);
    // if (quranLocal != null) {
    //   return Right(quranLocal);
    // }
    // else {
      final jsonData = await baseRepository.checkExceptionForRemoteData<List<AyahsEntity>>(
        remoteDataSource.getQuranPage(pageNumber: pageNumber),
      );
      return jsonData.fold(
            (failure) => left(failure),
            (data) async {
          // await localDataSource.setQuran(
          //   id: id,
          //   data: data,
          // );
          return Right(data);
        },
      );
    //}
  }


}
