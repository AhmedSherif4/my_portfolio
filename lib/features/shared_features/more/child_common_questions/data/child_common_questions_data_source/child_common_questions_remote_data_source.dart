part of '../../child_common_questions.dart';

abstract class ChildCommonQuestionsRemoteDataSource {
  Future<List<CommonQuestionEntity>> getAllCommonQuestions();
}

@LazySingleton(as: ChildCommonQuestionsRemoteDataSource)
class ChildCommonQuestionsRemoteDataSourceImpl
    implements ChildCommonQuestionsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  ChildCommonQuestionsRemoteDataSourceImpl(
      {required this.baseRemoteDataSource});

  @override
  Future<List<CommonQuestionEntity>> getAllCommonQuestions() async {
    final response = await baseRemoteDataSource
        .postData(url: EndPoints.commonQuestions, body: {});
    final allQuestions = List<CommonQuestionEntity>.from(
        (response['data'] as List)
            .map((element) => CommonQuestionModel.fromJson(element)));

    return allQuestions;
  }
}
