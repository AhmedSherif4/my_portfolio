part of '../../nafees_plans.dart';


@LazySingleton(as: NafeesBaseRepository)
class NafeesRepository implements NafeesBaseRepository {
  final BaseRepository baseRepository;
  final NafeesRemoteDataSource remoteDataSource;
  NafeesRepository(
      {required this.baseRepository, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NafeesPlansEntity>>> getNafeesPlans({required int childId}) async {
    final plans = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getNafeesPlans(childId: childId),
    );
    return plans.fold((failure) => left(failure), (data) => right(data));
  }

  @override
  Future<Either<Failure, NafeesFullExamEntity>>
      getNafeesExams({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs}) async {
    final subjects = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getNafeesExams(nafeesExamQuestionsAnswersInputs: nafeesExamQuestionsAnswersInputs),
    );
    return subjects.fold((failure) => left(failure), (data) => right(data));
  }

  @override
  Future<Either<Failure, NafeesModelAnswersEntity>>
      getNafeesModelAnswers({required int modelId}) async {
    final lessons = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getNafeesModelAnswers(modelId: modelId),
    );
    return lessons.fold((failure) => left(failure), (data) => right(data));
  }

  @override
  Future<Either<Failure, String>> submitExamAnswer({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs}) async {
    final lessons = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.submitExamAnswer(nafeesExamQuestionsAnswersInputs: nafeesExamQuestionsAnswersInputs),
    );
    return lessons.fold((failure) => left(failure), (data) => right(data));
  }
}
