part of '../../questions.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.correctSelect,
    required super.point,
    super.skill,
    required super.stageId,
    required super.classroomId,
    required super.termId,
    required super.subjectId,
    required super.lessonId,
    super.groupId,
    super.levelId,
    super.questionText,
    super.questionFile,
    super.questionType,
    super.descriptionText,
    super.descriptionFile,
    super.descriptionType,
    super.select1Text,
    super.select1File,
    super.select1Type,
    super.select2Text,
    super.select2File,
    super.select2Type,
    super.select3Text,
    super.select3File,
    super.select3Type,
    super.select4Text,
    super.select4File,
    super.select4Type,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      correctSelect: map['correct_select'] as String,
      point: map['point'] as int,
      skill: map['skill'] != null ? map['skill'] as String : null,
      questionText:
          map['ques_text'] != null ? map['ques_text'] as String : null,
      questionFile:
          map['ques_file'] != null ? map['ques_file'] as String : null,
      questionType:
          map['ques_type'] != null ? map['ques_type'] as String : null,
      descriptionText: map['description_text'] != null
          ? map['description_text'] as String
          : null,
      descriptionFile: map['description_file'] != null
          ? map['description_file'] as String
          : null,
      descriptionType: map['description_type'] != null
          ? map['description_type'] as String
          : null,
      select1Text:
          map['select_1_text'] != null ? map['select_1_text'] as String : null,
      select1File:
          map['select_1_file'] != null ? map['select_1_file'] as String : null,
      select1Type:
          map['select_1_type'] != null ? map['select_1_type'] as String : null,
      select2Text:
          map['select_2_text'] != null ? map['select_2_text'] as String : null,
      select2File:
          map['select_2_file'] != null ? map['select_2_file'] as String : null,
      select2Type:
          map['select_2_type'] != null ? map['select_2_type'] as String : null,
      select3Text:
          map['select_3_text'] != null ? map['select_3_text'] as String : null,
      select3File:
          map['select_3_file'] != null ? map['select_3_file'] as String : null,
      select3Type:
          map['select_3_type'] != null ? map['select_3_type'] as String : null,
      select4Text:
          map['select_4_text'] != null ? map['select_4_text'] as String : null,
      select4File:
          map['select_4_file'] != null ? map['select_4_file'] as String : null,
      select4Type:
          map['select_4_type'] != null ? map['select_4_type'] as String : null,
      stageId: map['stage_id'] as int,
      classroomId: map['classroom_id'] as int,
      termId: map['term_id'] as int,
      subjectId: map['subject_id'] as int,
      lessonId: map['lesson_id'] != null ? map['lesson_id'] as int : null,
      groupId: map['group_id'] != null ? map['group_id'] as int : null,
      levelId: map['level_id'] != null ? map['level_id'] as int : null,
    );
  }
}

class QuestionModelWithMessage extends Equatable {
  final String message;
  final List<QuestionEntity> allQuestions;

  const QuestionModelWithMessage({
    required this.message,
    required this.allQuestions,
  });

  factory QuestionModelWithMessage.fromJson(Map<String, dynamic> json) {
    return QuestionModelWithMessage(
      message: json['message'] ?? '',
      allQuestions: (json['data'] as List<dynamic>?)
              ?.map((data) => QuestionModel.fromMap(data))
              .toList() ??
          [],
    );
  }

  @override
  List<Object> get props => [message, allQuestions];
}
