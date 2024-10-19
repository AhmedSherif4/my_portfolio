part of '../../levels.dart';

abstract class LevelsRemoteDataSource {
  Future<List<LevelAndCollectionEntity>> getLevels({
    required ParameterGoToQuestions levelsParameters,
  });
}

@LazySingleton(as: LevelsRemoteDataSource)
class LevelsRemoteDataSourceImpl implements LevelsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  const LevelsRemoteDataSourceImpl({
    required this.baseRemoteDataSource,
  });

  @override
  Future<List<LevelAndCollectionEntity>> getLevels(
      {required ParameterGoToQuestions levelsParameters}) async {

    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource.postData(url: EndPoints.levels, body: {
            'subject_id': levelsParameters.subjectId,
          })
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.levelsFromParent
                : EndPoints.institutionFromParent,
            body: {
                'subject_id': levelsParameters.subjectId,
              });
    final allLevels = List<LevelAndCollectionEntity>.from(
        (response['data'] as List)
            .map((element) => LevelModel.fromMap(element)));

    return allLevels;
  }
}
