part of '../../nafees_plans.dart';

@LazySingleton()
class GetNafeesPlansUseCase
    extends BaseUseCase<List<NafeesPlansEntity>, int> {
  final NafeesBaseRepository repository;

  GetNafeesPlansUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NafeesPlansEntity>>> call(
      int parameter) async {
    return await repository.getNafeesPlans(childId: parameter);
  }
}

@LazySingleton()
class GetNafeesExamsUseCase
    extends BaseUseCase<NafeesFullExamEntity, NafeesExamQuestionsAnswersInputs> {
  final NafeesBaseRepository repository;

  GetNafeesExamsUseCase({required this.repository});

  @override
  Future<Either<Failure, NafeesFullExamEntity>> call(
      NafeesExamQuestionsAnswersInputs parameter) async {
    return await repository.getNafeesExams(nafeesExamQuestionsAnswersInputs: parameter);
  }
}

@LazySingleton()
class GetNafeesModelAnswersUseCase
    extends BaseUseCase<NafeesModelAnswersEntity, int> {
  final NafeesBaseRepository repository;

  GetNafeesModelAnswersUseCase({required this.repository});

  @override
  Future<Either<Failure, NafeesModelAnswersEntity>> call(
      int parameter) async {
    return await repository.getNafeesModelAnswers(modelId: parameter);
  }
}

@LazySingleton()
class SubmitExamAnswerUseCase
    extends BaseUseCase<String, NafeesExamQuestionsAnswersInputs> {
  final NafeesBaseRepository repository;

  SubmitExamAnswerUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      NafeesExamQuestionsAnswersInputs parameter) async {
    return await repository.submitExamAnswer(nafeesExamQuestionsAnswersInputs: parameter);
  }
}