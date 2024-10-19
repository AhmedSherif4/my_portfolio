part of '../../simulated_plans.dart';

@LazySingleton()
class GetSimulatedPlansUseCase
    extends BaseUseCase<List<SimulatedCategoriesEntity>, int> {
  final SimulatedBaseRepository repository;

  GetSimulatedPlansUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SimulatedCategoriesEntity>>> call(
      int parameter) async {
    return await repository.getSimulatedPlans(childId: parameter);
  }
}

@LazySingleton()
class GetSimulatedExamsUseCase
    extends BaseUseCase<SimulatedFullExamEntity, SimulatedExamQuestionsAnswersInputs> {
  final SimulatedBaseRepository repository;

  GetSimulatedExamsUseCase({required this.repository});

  @override
  Future<Either<Failure, SimulatedFullExamEntity>> call(
      SimulatedExamQuestionsAnswersInputs parameter) async {
    return await repository.getSimulatedExams(simulatedExamQuestionsAnswersInputs: parameter);
  }
}

@LazySingleton()
class GetSimulatedModelAnswersUseCase
    extends BaseUseCase<SimulatedModelAnswersEntity, int> {
  final SimulatedBaseRepository repository;

  GetSimulatedModelAnswersUseCase({required this.repository});

  @override
  Future<Either<Failure, SimulatedModelAnswersEntity>> call(
      int parameter) async {
    return await repository.getSimulatedModelAnswers(modelId: parameter);
  }
}

@LazySingleton()
class SubmitExamAnswerUseCase
    extends BaseUseCase<String, SimulatedExamQuestionsAnswersInputs> {
  final SimulatedBaseRepository repository;

  SubmitExamAnswerUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      SimulatedExamQuestionsAnswersInputs parameter) async {
    return await repository.submitExamAnswer(simulatedExamQuestionsAnswersInputs: parameter);
  }
}