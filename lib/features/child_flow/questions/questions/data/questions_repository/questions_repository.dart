part of '../../questions.dart';

@LazySingleton(as: QuestionsBaseRepository)
class QuestionsRepository implements QuestionsBaseRepository {
  final QuestionsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  QuestionsRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, QuestionModelWithMessage>> getQuestions(
      {required ParameterGoToQuestions questionsParameters}) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getQuestions(questionsParameters: questionsParameters),
    );
  }

  @override
  Future<Either<Failure, AnswerModel>> sendTheAnswerOfQuestion(
      SendTheAnswerOfQuestionParameter parameter) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.sendTheAnswerOfQuestion(parameter),
    );
  }

  @override
  Future<Either<Failure, String>> reportQuestion(
      ReportQuestionParameters parameter) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.reportQuestion(parameter),
    );
  }
}
