part of '../../exams.dart';

class ExamModel extends ExamEntity {
  const ExamModel({
    required super.id,
    required super.name,
    required super.file,
    required super.degree,
    required super.stageId,
    required super.classroomId,
    required super.termId,
    required super.subjectId,
    required super.result,
    required super.systemId,
    super.pathId,
  });
  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      //systemId: map['pivot']['system_id'] as int,
      systemId: map['system_id'] as int,
      pathId: map['path_id'] as int?,
      id: map['id'] as int,
      name: map['name'] as String,
      file: map['file'] as String,
      degree: map['degree'] as int,
      stageId: map['stage_id'] as int,
      classroomId: map['classroom_id'] as int,
      termId: map['term_id'] as int,
      subjectId: map['subject_id'] as int,
      result: map['result'] != null
          ? ResultExamModel.fromMap(map['result'] as Map<String, dynamic>)
          : ResultExamModel.empty(),
    );
  }
}
