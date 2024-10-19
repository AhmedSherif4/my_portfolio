part of '../../exams.dart';

abstract class ExamsRemoteDataSource {
  Future<List<ExamEntity>> getExamsForSpecificSubject(ExamsParameter parameter);
}

@LazySingleton(as: ExamsRemoteDataSource)
class ExamsRemoteDataSourceImpl implements ExamsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  ExamsRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<List<ExamEntity>> getExamsForSpecificSubject(
      ExamsParameter parameter) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.exams,
      body: {
        'system_id': parameter.systemId,
        'subject_id': parameter.subjectId,
        'stage_id': parameter.stageId,
        'term_id': parameter.termId,
        'classroom_id': parameter.classroomId,
        'path_id': parameter.pathId,
      },
    );
    return List<ExamEntity>.from(
      (response['data'] as List).map(
        (exam) => ExamModel.fromMap(exam),
      ),
    );
  }
}

class ExamsParameter extends Equatable {
  final int systemId;
  final int subjectId;
  final int stageId;
  final int termId;
  final int classroomId;
  final int? pathId;
  const ExamsParameter({
    required this.systemId,
    required this.subjectId,
    required this.stageId,
    required this.termId,
    required this.classroomId,
    this.pathId,
  });
  @override
  List<Object?> get props => [
    systemId,
        subjectId,
        stageId,
        termId,
        classroomId,
    pathId,
      ];
}
