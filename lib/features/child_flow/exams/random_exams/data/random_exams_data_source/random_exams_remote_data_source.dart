
part of '../../random_exams.dart';

abstract class RandomExamsRemoteDataSource {
  Future<RandomExamEntityOutputs> createExamsForSpecificSubject(CreateRandomExamInputs parameter);
  Future<RandomExamEntityOutputs> repeatExamsForSpecificSubject(int examID);
  Future<List<AllRandomExamEntityOutputs>> getAllRandomExamsForSpecificSubject(AllRandomExamInputs allRandomExamInputs);
  Future<String> getRandomExamsAnswersForSpecificSubject(RandomExamQuestionsAnswersInputs randomExamQuestionsAnswersInputs);
}

@LazySingleton(as: RandomExamsRemoteDataSource)
class RandomExamsRemoteDataSourceImpl implements RandomExamsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  RandomExamsRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<RandomExamEntityOutputs> createExamsForSpecificSubject(
      CreateRandomExamInputs parameter) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.createRandomExamsPath,
      body: {
        'subject_id': parameter.subjectId,
        'number_questions': parameter.questionsNum,
      },
    );
    return RandomExamModel.fromMap(response['data']);

  }

  @override
  Future<RandomExamEntityOutputs> repeatExamsForSpecificSubject(
      int examID) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.repeatRandomExamsPath,
      body: {
        'exam_id': examID,
      },
    );
    return RandomExamModel.fromMap(response['data']);
  }

  @override
  Future<String> getRandomExamsAnswersForSpecificSubject(
      RandomExamQuestionsAnswersInputs randomExamQuestionsAnswersInputs) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.addRandomQuestionAnswerPath,
      body: randomExamQuestionsAnswersInputs.toJson(),
    );
    return response['data'];
  }

  @override
  Future <List<AllRandomExamEntityOutputs>> getAllRandomExamsForSpecificSubject(AllRandomExamInputs allRandomExamInputs) async {
    allRandomExamInputs.childId.log();
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()?
      EndPoints.allRandomExamsPath:
      EndPoints.parentAllRandomExamsPath,
      body: AppReference.userIsChild()?{
        "subject_id": allRandomExamInputs.subjectId,
      }:{
        "subject_id": allRandomExamInputs.subjectId,
        "child_id":allRandomExamInputs.childId
      },
    );
    return List<AllRandomExamEntityOutputs>.from(
      (response['data'] as List).map(
            (exam) => AllRandomExamModel.fromMap(exam),
      ),
    );
  }
}

