part of '../../nafees_plans.dart';


abstract class NafeesRemoteDataSource {
  Future<List<NafeesPlansEntity>> getNafeesPlans({required int childId});
  Future<NafeesFullExamEntity> getNafeesExams({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs});
  Future<NafeesModelAnswersEntity> getNafeesModelAnswers({required int modelId});
  Future<String> submitExamAnswer({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs});
}

@LazySingleton(as: NafeesRemoteDataSource)
class NafeesRemoteDataSourceImpl implements NafeesRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  NafeesRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<String> submitExamAnswer({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs})async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.nafeesStoreExamAnswer,
      body: nafeesExamQuestionsAnswersInputs.toJson(),
    );
    return response['data'];
  }

  @override
  Future<NafeesModelAnswersEntity> getNafeesModelAnswers({required int modelId})async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.nafeesModelAnswers,
      body: {
        'model_id': modelId,
      }
    );
    return NafeesModelAnswersModel.fromJson(response['data']);
  }


  @override
  Future<NafeesFullExamEntity> getNafeesExams({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs})async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.nafeesExams,
      body: {
        'child_id': nafeesExamQuestionsAnswersInputs.childId,
        'exam_id': nafeesExamQuestionsAnswersInputs.examId,
      }
    );
    return NafeesFullExamModel.fromJson(response['data']);
  }

  @override
  Future<List<NafeesPlansEntity>> getNafeesPlans({required int childId}) async{
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.nafeesPlans,
      body:{'child_id':childId},
    );
    return (response['data'] as List).map((e) => NafeesPlansModel.fromJson(e)).toList();
  }
}
