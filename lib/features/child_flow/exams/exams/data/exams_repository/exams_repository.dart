part of '../../exams.dart';

@LazySingleton(as: ExamsBaseRepository)
class ExamsRepository implements ExamsBaseRepository {
  final ExamsRemoteDataSource remoteDataSource;
  // final ExamsLocalDataSource localDataSource;
  final BaseRepository baseRepository;

  ExamsRepository({
    required this.remoteDataSource,
    required this.baseRepository,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ExamEntity>>> getExamsForSpecificSubject(
      ExamsParameter parameter) async {
    // final examsLocal = await localDataSource.getExamsForSpecificSubject(
    //     subjectId: parameter.subjectId);
    // if (examsLocal != null) {
    //   return Right(examsLocal);
    // } else {
      final jsonData =
      await baseRepository.checkExceptionForRemoteData<List<ExamEntity>>(
        remoteDataSource.getExamsForSpecificSubject(parameter),
      );
      return jsonData.fold(
            (failure) => left(failure),
            (data)  {
          // await localDataSource.setExamsForSpecificSubject(
          //   subjectId: parameter.subjectId,
          //   data: data,
          // );
          return Right(data);
        },
      );
    }
  }

