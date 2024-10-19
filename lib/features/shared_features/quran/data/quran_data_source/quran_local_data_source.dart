part of '../../quran.dart';

abstract class QuranLocalDataSource {
  Future<void> setQuran({
    required String id,
    required List<AyahsEntity> data,
  });

  Future<List<AyahsEntity>?> getQuran({
    required String id,
  });
}

@LazySingleton(as: QuranLocalDataSource)
class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  final BaseLocalDataSource baseLocalDataSource;

  QuranLocalDataSourceImpl({required this.baseLocalDataSource});

  @override
  Future<void> setQuran({
    required String id,
    required List<AyahsEntity> data,
  }) async {
    return await baseLocalDataSource.saveListOfDataInLocal<AyahsEntity>(
      labelKey: id,
      data: data,
      expirationDuration: const Duration(days: 365),
    );
  }

  @override
  Future<List<AyahsEntity>?> getQuran({
    required String id,
  }) async {
    await Hive.openBox<String>(AppKeys.getExpirationKey(id));

    await Hive.openBox<AyahsEntity>(id);

    return await baseLocalDataSource.getListOfDataFromLocal<AyahsEntity>(
      labelKey: id,
    );
  }
}
