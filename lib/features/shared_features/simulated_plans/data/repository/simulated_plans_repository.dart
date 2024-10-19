part of '../../simulated_plans.dart';


@LazySingleton(as: SimulatedBaseRepository)
class SimulatedRepository implements SimulatedBaseRepository {
  final BaseRepository baseRepository;
  final SimulatedRemoteDataSource remoteDataSource;
  SimulatedRepository(
      {required this.baseRepository, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SimulatedCategoriesEntity>>> getSimulatedPlans({required int childId}) async {
    final plans = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getSimulatedPlans(childId: childId),
    );
    return plans.fold((failure) => left(failure), (data) => right(data));
  }

  @override
  Future<Either<Failure, SimulatedFullExamEntity>>
      getSimulatedExams({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs}) async {
    final subjects = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getSimulatedExams(simulatedExamQuestionsAnswersInputs: simulatedExamQuestionsAnswersInputs),
    );
    return subjects.fold((failure) => left(failure), (data) => right(data));
  }

  @override
  Future<Either<Failure, SimulatedModelAnswersEntity>>
      getSimulatedModelAnswers({required int modelId}) async {
    final lessons = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getSimulatedModelAnswers(modelId: modelId),
    );
    return lessons.fold((failure) => left(failure), (data) => right(data));
  }

  @override
  Future<Either<Failure, String>> submitExamAnswer({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs}) async {
    final lessons = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.submitExamAnswer(simulatedExamQuestionsAnswersInputs: simulatedExamQuestionsAnswersInputs),
    );
    return lessons.fold((failure) => left(failure), (data) => right(data));
  }
}
