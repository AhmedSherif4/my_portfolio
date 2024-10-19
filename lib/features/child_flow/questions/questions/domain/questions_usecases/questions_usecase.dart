part of '../../questions.dart';

@LazySingleton()
class GetQuestionsUseCase
    extends BaseUseCase<QuestionModelWithMessage, ParameterGoToQuestions> {
  final QuestionsBaseRepository repository;

  GetQuestionsUseCase({required this.repository});

  @override
  Future<Either<Failure, QuestionModelWithMessage>> call(
    ParameterGoToQuestions parameter,
  ) async {
    return await repository.getQuestions(
      questionsParameters: parameter,
    );
  }
}

@LazySingleton()
class SendTheAnswerOfQuestionUseCase
    extends BaseUseCase<AnswerModel, SendTheAnswerOfQuestionParameter> {
  final QuestionsBaseRepository repository;

  SendTheAnswerOfQuestionUseCase({required this.repository});

  @override
  Future<Either<Failure, AnswerModel>> call(
      SendTheAnswerOfQuestionParameter parameter) async {
    return await repository.sendTheAnswerOfQuestion(parameter);
  }
}

class SendTheAnswerOfQuestionParameter extends Equatable {
  final int questionId;
  final int answerDuration;
  final int triesTaken;
  final int stageId;
  final int classroomId;
  final int termId;
  final int subjectId;
  final int levelId;
  final int groupId;
  final int lessonId;
  final bool isLast;
  final bool isGeneralQuestion;
  final int systemId;
  final int pathId;
  final bool isFromNafees;

  const SendTheAnswerOfQuestionParameter({
    required this.stageId,
    required this.classroomId,
    required this.termId,
    required this.subjectId,
    required this.levelId,
    required this.groupId,
    required this.isLast,
    required this.questionId,
    required this.answerDuration,
    required this.triesTaken,
    required this.isGeneralQuestion,
    required this.lessonId,
    required this.systemId,
    required this.pathId,
    required this.isFromNafees,
  });

  @override
  List<Object> get props => [
        questionId,
        answerDuration,
        triesTaken,
        stageId,
        classroomId,
        termId,
        subjectId,
        levelId,
        groupId,
        lessonId,
        isLast,
        isGeneralQuestion,
    systemId,
    pathId,
    isFromNafees,
      ];
}

@LazySingleton()
class ReportQuestionUseCase
    extends BaseUseCase<String, ReportQuestionParameters> {
  final QuestionsBaseRepository repository;

  ReportQuestionUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      ReportQuestionParameters parameter) async {
    return await repository.reportQuestion(parameter);
  }
}

class ReportQuestionParameters extends Equatable {
  final int questionId;
  final String message;
  final String type;

  const ReportQuestionParameters(
      {required this.questionId, required this.message, required this.type});

  @override
  List<Object> get props => [questionId, message, type];
}
