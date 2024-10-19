part of '../../quran.dart';

abstract class QuranBaseRepository {
  Future<Either<Failure, List<AyahsEntity>>> getQuranPage(
      {required int pageNumber});
  Future<Either<Failure, List<AyahsEntity>>> getQuranTafseer(
      {required QuranParameter quranParameter});

  Future<Either<Failure, List<AyahsEntity>>> getQuranText(
      {required QuranParameter quranParameter});
  Future<Either<Failure, List<AyahsEntity>>> getQuranAudio(
      {required QuranParameter quranParameter});
}