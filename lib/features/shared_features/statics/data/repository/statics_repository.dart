part of '../../statics.dart';


@LazySingleton(as: BaseStaticsRepository)
class StaticsRepository extends BaseStaticsRepository {
  final BaseRepository registry;
  final BaseStaticsRemoteDataSource remoteDataSource;

  StaticsRepository({required this.registry, required this.remoteDataSource});

  @override
  Future<Either<Failure, TimeInAppModel>> getTimeInApp(TimeInAppInputs timeInAppInputs) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getTimeInApp(timeInAppInputs),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<SubjectsEntity>>> getSubjects(
      {required GetStaticsParam subjectsParameters}) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getSubjects(subjectsParameters: subjectsParameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, LessonsStaticsModel>> getLessonsStatics(
      {required GetStaticsParam parameters}) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getLessonsStatics(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<BestSubjectsModel>>> getBestSubjects(
      {required GetStaticsParam parameters}) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getLBestSubjects(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, LevelStaticsModel>> getLevelStatics(
      {required GetStaticsParam parameters}) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getLevelStatics(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }



  @override
  Future<Either<Failure, List<FailsSkillsForLessonsModel>>> getFailsSkills(
      {required GetFailsSkillsWithQuestionsParameters parameters}) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getFailsSkills(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, QuestionEntity>> getFailsSkillsQuestions({required int id}) async{
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getFailsSkillsQuestions(id: id),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }
}
