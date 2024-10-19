part of '../../simulated_plans.dart';


abstract class SimulatedRemoteDataSource {
  Future<List<SimulatedCategoriesEntity>> getSimulatedPlans({required int childId});
  Future<SimulatedFullExamEntity> getSimulatedExams({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs});
  Future<SimulatedModelAnswersEntity> getSimulatedModelAnswers({required int modelId});
  Future<String> submitExamAnswer({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs});
}

@LazySingleton(as: SimulatedRemoteDataSource)
class SimulatedRemoteDataSourceImpl implements SimulatedRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  SimulatedRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<String> submitExamAnswer({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs})async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.simulatedStoreExamAnswer,
      body: simulatedExamQuestionsAnswersInputs.toJson(),
    );
    return response['data'];
  }

  @override
  Future<SimulatedModelAnswersEntity> getSimulatedModelAnswers({required int modelId})async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.simulatedModelAnswers,
      body: {
        'model_id': modelId,
      }
    );
    return SimulatedModelAnswersModel.fromJson(response['data']);
  }


  @override
  Future<SimulatedFullExamEntity> getSimulatedExams({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs})async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.simulatedExams,
      body: {
        'child_id': simulatedExamQuestionsAnswersInputs.childId,
        'exam_id': simulatedExamQuestionsAnswersInputs.examId,
      }
    );
    return SimulatedFullExamModel.fromJson(response['data']);
  }

  @override
  Future<List<SimulatedCategoriesEntity>> getSimulatedPlans({required int childId}) async{
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.simulatedPlans,
      body:{'child_id':childId},
    );
    return (response['data'] as List).map((e) => SimulatedCategoriesModel.fromJson(e)).toList();
  }
}
