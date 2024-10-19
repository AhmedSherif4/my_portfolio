part of '../../lessons.dart';

@LazySingleton(as: LessonsBaseRepository)
class LessonsRepository implements LessonsBaseRepository {
  final LessonsRemoteDataSource remoteDataSource;
  // final LessonsLocalDataSource lessonsLocalDataSource;
  final BaseRepository baseRepository;

  const LessonsRepository({
    // required this.lessonsLocalDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<LessonEntity>>> getLessons({
    required ParameterGoToQuestions getLessonsParameters,
  }) async {
    ///...........get lessons from local data source.............
    // getLessonsParameters.subjectId.log();
    // final int id = getLessonsParameters.subjectId;
    // final allLessonsLocal = await lessonsLocalDataSource.getLessonsInLocalData(subjectId: id);
    // if (allLessonsLocal != null) {
    //   return Right(allLessonsLocal);
    // }else{
    ///...........get lessons from remote data source.............
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getLessons(lessonParameters: getLessonsParameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (allLessons) async {
        // await lessonsLocalDataSource.saveLessonsInLocalData(
        //   subjectId: getLessonsParameters.subjectId,
        //   data: allLessons,
        // );
        return Right(allLessons);
      },
    );
  }

  @override
  Future<Either<Failure, List<LessonWithUnitsEntity>>> getLessonsByUnits(
      {required ParameterGoToQuestions getLessonsParameters}) async {
    ///...........get lessonsByUnits from local data source.............
    // final int id = getLessonsParameters.subjectId;
    // final allLessonsByUnitsLocal = await lessonsLocalDataSource.getLessonsWithUnitsInLocalData(subjectId: id);
    // if (allLessonsByUnitsLocal != null) {
    //   return Right(allLessonsByUnitsLocal);
    // }else{

    ///...........get lessonsByUnits from remote data source.............
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getLessonsByUnits(
          lessonParameters: getLessonsParameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (allLessons) async {
        // await lessonsLocalDataSource.saveLessonsWithUnitsInLocalData(
        //   subjectId: getLessonsParameters.subjectId,
        //   data: allLessons,
        // );
        return Right(allLessons);
      },
    );
  }
}
