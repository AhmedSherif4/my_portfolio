part of '../../home.dart';

abstract class HomeRemoteDataSource {
  Future<List<SubjectsEntity>> getSubjects(
      {required ParameterGoToQuestions subjectsParameters});

  Future<PuzzleAndAdviceEntity> getPuzzleAndAdvice();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  const HomeRemoteDataSourceImpl({
    required this.baseRemoteDataSource,
  });

  @override
  Future<List<SubjectsEntity>> getSubjects({
    required ParameterGoToQuestions subjectsParameters,
  }) async {
    final response =
        await baseRemoteDataSource.postData(url: EndPoints.subjects, body: {
      'term_id': subjectsParameters.termId,
      'path_id':
          subjectsParameters.pathId != 0 ? subjectsParameters.pathId : null,
    });

    final requiredSubjects = List<SubjectsEntity>.from(
        (response['data']['required'] as List)
            .map((element) => SubjectModel.fromMap(element, true))).toList();

    final optionalSubjects = List<SubjectsEntity>.from(
        (response['data']['optional'] as List)
            .map((element) => SubjectModel.fromMap(element, true))).toList();

    late List<SubjectsEntity> subject;
    if (response['data']['optional'].isEmpty) {
      subject = requiredSubjects;
    } else {
      subject = requiredSubjects + optionalSubjects;
    }
    // subject.log();

    return subject;
  }

  @override
  Future<PuzzleAndAdviceEntity> getPuzzleAndAdvice() async {
    final response = await baseRemoteDataSource
        .postData(url: EndPoints.puzzleAndAdvice, body: {});
    return PuzzleAndAdviceModel.fromMap(response['data']);
  }
}
