part of '../../child_common_questions.dart';

@LazySingleton()
class GetAllCommonQuestionUseCase
    extends BaseUseCase<List<CommonQuestionEntity>, NoParameter> {
  final ChildCommonQuestionsBaseRepository repository;

  GetAllCommonQuestionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CommonQuestionEntity>>> call(parameter) async {
    return await repository.getAllCommonQuestions();
  }
}
