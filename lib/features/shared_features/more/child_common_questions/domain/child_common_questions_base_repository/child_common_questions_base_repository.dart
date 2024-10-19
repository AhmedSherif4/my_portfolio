part of '../../child_common_questions.dart';

abstract class ChildCommonQuestionsBaseRepository {
  Future<Either<Failure, List<CommonQuestionEntity>>> getAllCommonQuestions();
}
