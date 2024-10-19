part of '../../questions.dart';

abstract class QuestionsRemoteDataSource {
  Future<QuestionModelWithMessage> getQuestions({
    required ParameterGoToQuestions questionsParameters,
  });

  Future<AnswerModel> sendTheAnswerOfQuestion(
      SendTheAnswerOfQuestionParameter parameter);

  Future<String> reportQuestion(ReportQuestionParameters parameter);
}

@LazySingleton(as: QuestionsRemoteDataSource)
class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  QuestionsRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<QuestionModelWithMessage> getQuestions({
    required ParameterGoToQuestions questionsParameters,
  }) async {
    //questionsParameters.lessonId.log();
    final response = questionsParameters.isFromNafees
        ? await baseRemoteDataSource.postData(
            url: '/api/plan/lesson/questions',
            body: {'lesson_id': questionsParameters.lessonId})
        : await baseRemoteDataSource.postData(
            url: questionsParameters.isGeneralQuestion
                ? EndPoints.generalQuestions
                : EndPoints.lessonsQuestions,
            body: questionsParameters.isGeneralQuestion
                ? {

                    "group_id": questionsParameters.groupId,

                  }
                : {

                    "lesson_id": questionsParameters.lessonId,

                  },
          );
    return QuestionModelWithMessage.fromJson(response);
  }

  @override
  Future<AnswerModel> sendTheAnswerOfQuestion(
    SendTheAnswerOfQuestionParameter parameter,
  ) async {
    final response = parameter.isFromNafees
        ? await baseRemoteDataSource.postData(
            url: '/api/plan/add/lesson/answer', body: {
      "is_last": parameter.isLast ? 'yes' : 'no',
      "answer_time": parameter.answerDuration,
      "answer_num": parameter.triesTaken,
      "question_id": parameter.questionId,

    })
        : await baseRemoteDataSource.postData(
            url: parameter.isGeneralQuestion
                ? '/api/add/general/question/answer'
                : '/api/add/lesson/question/answer',
            body: parameter.isGeneralQuestion
                ? {

                    "is_last": parameter.isLast ? 'yes' : 'no',
                    "answer_time": parameter.answerDuration,
                    "answer_num": parameter.triesTaken,
                    "question_id": parameter.questionId,

                  }
                : {

                    "is_last": parameter.isLast ? 'yes' : 'no',
                    "answer_time": parameter.answerDuration.toString(),
                    "answer_num": parameter.triesTaken.toString(),
                    "question_id": parameter.questionId.toString(),

                  },
          );

    if (response['data'] == null) {
      return AnswerModel(point: -1, message: response['message']);
    } else {
      return AnswerModel.fromJson(response);
    }
  }

  @override
  Future<String> reportQuestion(ReportQuestionParameters parameter) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.reportQuestionPath,
      body: {
        'type': parameter.type,
        'question_id': parameter.questionId,
        'content': parameter.message,
      },
    );

    return response['message'];
  }
}
