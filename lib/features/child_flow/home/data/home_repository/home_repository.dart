part of '../../home.dart';

@LazySingleton(as: HomeBaseRepository)
class HomeRepository implements HomeBaseRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final BaseRepository baseRepository;

  HomeRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<SubjectsEntity>>> getSubjects({
    required ParameterGoToQuestions subjectsParameters,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getSubjects(subjectsParameters: subjectsParameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, PuzzleAndAdviceEntity>> getPuzzleAndAdvice() async {
    final puzzleAndAdvice = await localDataSource.getPuzzleAndAdvice();
    if (puzzleAndAdvice != null) {
      return Right(puzzleAndAdvice);
    }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getPuzzleAndAdvice(),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        await localDataSource.savePuzzleAndAdvice(data: data);
        return Right(data);
      },
    );
  }
}
