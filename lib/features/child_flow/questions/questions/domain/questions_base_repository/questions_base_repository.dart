part of '../../questions.dart';

abstract class QuestionsBaseRepository {
  Future<Either<Failure, QuestionModelWithMessage>> getQuestions(
      {required ParameterGoToQuestions questionsParameters});

  Future<Either<Failure, AnswerModel>> sendTheAnswerOfQuestion(
      SendTheAnswerOfQuestionParameter parameter);

  Future<Either<Failure, String>> reportQuestion(
      ReportQuestionParameters parameter);
}
