part of '../../quran.dart';

@LazySingleton()
class GetQuranTextUseCase
    extends BaseUseCase<List<AyahsEntity>, QuranParameter> {
  final QuranBaseRepository repository;

  GetQuranTextUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AyahsEntity>>> call(
      QuranParameter parameter) async {
    return await repository.getQuranText(quranParameter: parameter);
  }
}

@LazySingleton()
class GetQuranAudioUseCase
    extends BaseUseCase<List<AyahsEntity>, QuranParameter> {
  final QuranBaseRepository repository;

  GetQuranAudioUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AyahsEntity>>> call(
      QuranParameter parameter) async {
    return await repository.getQuranAudio(quranParameter: parameter);
  }
}

@LazySingleton()
class GetQuranTafseerUseCase
    extends BaseUseCase<List<AyahsEntity>, QuranParameter> {
  final QuranBaseRepository repository;

  GetQuranTafseerUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AyahsEntity>>> call(
      QuranParameter parameter) async {
    return await repository.getQuranTafseer(quranParameter: parameter);
  }
}

@LazySingleton()
class GetQuranPageUseCase
    extends BaseUseCase<List<AyahsEntity>, int> {
  final QuranBaseRepository repository;

  GetQuranPageUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AyahsEntity>>> call(
      int parameter) async {
    return await repository.getQuranPage(pageNumber: parameter);
  }
}