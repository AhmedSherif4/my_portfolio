part of '../../levels.dart';

@LazySingleton(as: LevelsBaseRepository)
class LevelsRepository implements LevelsBaseRepository {
  final LevelsRemoteDataSource remoteDataSource;
  // final LevelsLocalDataSource levelsLocalDataSource;
  final BaseRepository baseRepository;

  const LevelsRepository({
    // required this.levelsLocalDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<LevelAndCollectionEntity>>> getLevels(
      {required ParameterGoToQuestions levelParameters}) async {
    ///...........get levels from local data source.............
    // final int id = levelParameters.subjectId;
    // final allLevelsLocal = await levelsLocalDataSource.getLevelsInLocalData(subjectID: id);
    // if (allLevelsLocal != null) {
    //   return Right(allLevelsLocal);
    // }else{
      ///...........get levels from remote data source.............
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getLevels(levelsParameters: levelParameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (allLevels) async {
        // await levelsLocalDataSource.saveLevelsInLocalData(
        //   subjectID: levelParameters.subjectId,
        //   data: allLevels,
        // );
        return Right(allLevels);
      },
    );
  // }
  }
}
