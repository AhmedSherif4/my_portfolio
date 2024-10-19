part of '../../../subjects_shared_features.dart';



abstract class SubjectsSharedFeaturesLocalDataSource {
  Future<void> saveSharedSubjectsInLocalData({
    required List<SubjectsEntity> data,
    required int termId,
    required int stageId,
    required int classRoomId,
    required int pathId,
  });

  Future<List<SubjectsEntity>?> getSharedSubjectsInLocalData({
    required int termId,
    required int stageId,
    required int classRoomId,
    required int pathId,

  });
}

@LazySingleton(as: SubjectsSharedFeaturesLocalDataSource)
class SubjectsSharedFeaturesLocalDataSourceImpl implements SubjectsSharedFeaturesLocalDataSource {
  final BaseLocalDataSource baseLocalDataSource;

  const SubjectsSharedFeaturesLocalDataSourceImpl({
    required this.baseLocalDataSource,
  });

  @override
  Future<List<SubjectsEntity>?> getSharedSubjectsInLocalData({
    required int termId,
    required int stageId,
    required int classRoomId,
    required int pathId,

  }) async {
    await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.subjectsKey(
        stageId: stageId, classRoomId: classRoomId, termId: termId, pathId: pathId)));

    await Hive.openBox<SubjectsEntity>(AppKeys.subjectsKey(
        stageId: stageId, classRoomId: classRoomId, termId: termId,
    pathId: pathId,
    ));
    final allSubjects =
    await baseLocalDataSource.getListOfDataFromLocal<SubjectsEntity>(
      labelKey: AppKeys.subjectsKey(
          stageId: stageId, classRoomId: classRoomId, termId: termId,
      pathId: pathId,
      ),

    );
    if (allSubjects == null) {
      return null;
    } else {
      return allSubjects;
    }
  }



  @override
  Future<void> saveSharedSubjectsInLocalData({
    required List<SubjectsEntity> data,
    required int termId,
    required int stageId,
    required int classRoomId,
    required int pathId,

  }) async {
    await baseLocalDataSource.saveListOfDataInLocal<SubjectsEntity>(
      labelKey: AppKeys.subjectsKey(
          stageId: stageId, classRoomId: classRoomId, termId: termId,pathId: pathId,),
      data: data,
    );
  }
}