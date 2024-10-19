part of '../../lessons.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonEntity>> getLessons({
    required ParameterGoToQuestions lessonParameters,
  });

  Future<List<LessonWithUnitsEntity>> getLessonsByUnits({
    required ParameterGoToQuestions lessonParameters,
  });
}

@LazySingleton(as: LessonsRemoteDataSource)
class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  const LessonsRemoteDataSourceImpl({
    required this.baseRemoteDataSource,
  });

  @override
  Future<List<LessonEntity>> getLessons(
      {required ParameterGoToQuestions lessonParameters}) async {
    final response =
        await baseRemoteDataSource.postData(url: EndPoints.lessons, body: {
      'subject_id': lessonParameters.subjectId,
      // 'term_id': lessonParameters.termId,
      // 'classroom_id': lessonParameters.classRoomId,
      // 'stage_id': lessonParameters.stageId,
      //     'system_id': lessonParameters.systemId,
      //     'path_id': lessonParameters.pathId != 0 ? lessonParameters.pathId : null,
    });

    final allLessons = List<LessonEntity>.from((response['data'] as List)
        .map((element) => LessonsModel.fromMap(element)));

    return allLessons;
  }

  @override
  Future<List<LessonWithUnitsEntity>> getLessonsByUnits(
      {required ParameterGoToQuestions lessonParameters}) async {
    final response =
        await baseRemoteDataSource.postData(url: EndPoints.lessons, body: {
      'subject_id': lessonParameters.subjectId,
    });

    final allLessonsWithUnits = List<LessonWithUnitsEntity>.from(
      (response['data'] as List)
          .map((element) {
            return LessonWithUnitsModel.fromMap(element);
          }),
    );
    return allLessonsWithUnits;
  }
}
