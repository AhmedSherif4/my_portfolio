part of '../../statics.dart';


@LazySingleton()
class GetFailSkillsQuestionsUseCase
    extends BaseUseCase<QuestionEntity, int> {
  final BaseStaticsRepository repository;

  GetFailSkillsQuestionsUseCase({required this.repository});

  @override
  Future<Either<Failure, QuestionEntity>> call(
      int parameter) async {
    return await repository.getFailsSkillsQuestions(id: parameter);
  }
}


