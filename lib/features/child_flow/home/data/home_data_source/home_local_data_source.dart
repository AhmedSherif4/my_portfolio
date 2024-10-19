import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/storages/keys.dart';
import 'package:my_portfolio/features/child_flow/home/domain/home_entities/puzzle_and_advice_entity.dart';
import '../../../../../config/base_local_data_source/base_local_data_source.dart';

abstract class HomeLocalDataSource {
  Future<void> savePuzzleAndAdvice({required PuzzleAndAdviceEntity data});
  Future<PuzzleAndAdviceEntity?> getPuzzleAndAdvice();

  Future<void> saveSelectedAnswerOfPuzzle({required String value});

  Future<String> getSelectedAnswerOfPuzzle();

  Future<void> saveShowBanner({required bool value});

  Future<bool> getShowBanner();
}

@LazySingleton(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final BaseLocalDataSource baseLocalDataSource;
  HomeLocalDataSourceImpl(this.baseLocalDataSource);
  @override
  Future<PuzzleAndAdviceEntity?> getPuzzleAndAdvice() async {
    await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.puzzleAndAdviceKey));
    await Hive.openBox<PuzzleAndAdviceEntity>(AppKeys.puzzleAndAdviceKey);
    final puzzleAndAdvice = await baseLocalDataSource.getDataFromLocal<PuzzleAndAdviceEntity>(labelKey: AppKeys.puzzleAndAdviceKey);
    if (puzzleAndAdvice == null) {
      return null;
    } else {
      return puzzleAndAdvice;
    }
  }

  @override
  Future<void> savePuzzleAndAdvice({required data}) async {
    await baseLocalDataSource.saveDataInLocal<PuzzleAndAdviceEntity>(
      labelKey: AppKeys.puzzleAndAdviceKey,
      data: data,
      expirationDuration: const Duration(hours: 1),
    );
  }

  @override
  Future<String> getSelectedAnswerOfPuzzle() async {
    await Hive.openBox<String>(
        AppKeys.getExpirationKey(AppKeys.correctAnswerViewed));
    await Hive.openBox<String>(AppKeys.correctAnswerViewed);
    final isAnswered = await baseLocalDataSource.getDataFromLocal<String>(
      labelKey: AppKeys.correctAnswerViewed,
    );
    if (isAnswered == null) {
      return "";
    } else {
      return isAnswered;
    }
  }

  @override
  Future<void> saveSelectedAnswerOfPuzzle({required String value}) async {
    await baseLocalDataSource.saveDataInLocal<String>(
      labelKey: AppKeys.correctAnswerViewed,
      data: value,
      expirationDuration: const Duration(hours: 6),
    );
  }


  @override
  Future<bool> getShowBanner() async {
    await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.bannerViewed));
    await Hive.openBox<bool>(AppKeys.bannerViewed);
    final isShow = await baseLocalDataSource.getDataFromLocal<bool>(
      labelKey: AppKeys.bannerViewed,
    );
    if (isShow == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> saveShowBanner({required bool value}) async {
    await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.bannerViewed));
    await Hive.openBox<bool>(AppKeys.bannerViewed);
    await baseLocalDataSource.saveDataInLocal<bool>(
      labelKey: AppKeys.bannerViewed,
      data: value,
      expirationDuration: const Duration(hours: 6),
    );
  }
}
