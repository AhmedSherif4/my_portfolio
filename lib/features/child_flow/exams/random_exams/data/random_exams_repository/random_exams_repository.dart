part of '../../random_exams.dart';

@LazySingleton(as: RandomExamsBaseRepository)
class RandomExamsRepository implements RandomExamsBaseRepository {
  final RandomExamsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  RandomExamsRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, RandomExamEntityOutputs>> createRandomExamsForSpecificSubject(
      CreateRandomExamInputs parameter) async {

      final jsonData =
      await baseRepository.checkExceptionForRemoteData<RandomExamEntityOutputs>(
        remoteDataSource.createExamsForSpecificSubject(parameter),
      );
      return jsonData.fold(
            (failure) => left(failure),
            (data) async {
          return Right(data);
        },
      );
    }

  @override
  Future<Either<Failure, RandomExamEntityOutputs>> repeatRandomExamsForSpecificSubject(int examID) async {

    final jsonData =
    await baseRepository.checkExceptionForRemoteData<RandomExamEntityOutputs>(
      remoteDataSource.repeatExamsForSpecificSubject(examID),
    );
    return jsonData.fold(
            (failure) => left(failure),
    (data) async {
      return Right(data);
    },
    );
  }

  @override
  Future<Either<Failure, List<AllRandomExamEntityOutputs>>> getRandomExamsForSpecificSubject(AllRandomExamInputs allRandomExamInputs)async {

    final jsonData =
    await baseRepository.checkExceptionForRemoteData<List<AllRandomExamEntityOutputs>>(
      remoteDataSource.getAllRandomExamsForSpecificSubject(allRandomExamInputs),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, String>> getRandomExamsAnswersForSpecificSubject(RandomExamQuestionsAnswersInputs randomExamQuestionsAnswersInputs)async {

    final jsonData =
    await baseRepository.checkExceptionForRemoteData<String>(
      remoteDataSource.getRandomExamsAnswersForSpecificSubject(randomExamQuestionsAnswersInputs),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) async {
        return Right(data);
      },
    );
  }


  }

