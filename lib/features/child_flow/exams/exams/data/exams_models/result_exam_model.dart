part of '../../exams.dart';

class ResultExamModel extends ResultExamEntity {
  const ResultExamModel({
    required super.id,
    required super.file,
    required super.degree,
    required super.isMark,
    super.childLevel,
    required super.examId,
    required super.childId,
    super.description,
    required super.reupload,
  });

  factory ResultExamModel.fromMap(Map<String, dynamic> map) {
    return ResultExamModel(
      id: map['id'] as int,
      file: map['file'] as String,
      degree: map['degree'] as int,
      isMark: map['is_mark'] as String,
      childLevel:
          map['child_level'] != null ? map['child_level'] as String : null,
      examId: map['exam_id'] as int,
      childId: map['child_id'] as int,
      reupload: map['reupload'] as bool,
      description: map['description'] != null ?   List<String>.from(map['description'] as List) : null,
    );
  }

  factory ResultExamModel.empty() {
    return const ResultExamModel(
      id: 0,
      file: '',
      degree: 0,
      isMark: 'no',
      childLevel: null,
      examId: 0,
      childId: 0,
      reupload: true,
      description: null,
    );
  }
}
