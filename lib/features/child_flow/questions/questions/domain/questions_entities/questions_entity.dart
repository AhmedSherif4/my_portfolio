part of '../../questions.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String correctSelect;
  final int point;
  final String? skill;
  final String? questionText;
  final String? questionFile;
  final String? questionType;
  final String? descriptionText;
  final String? descriptionFile;
  final String? descriptionType;
  final String? select1Text;
  final String? select1File;
  final String? select1Type;
  final String? select2Text;
  final String? select2File;
  final String? select2Type;
  final String? select3Text;
  final String? select3File;
  final String? select3Type;
  final String? select4Text;
  final String? select4File;
  final String? select4Type;
  final int stageId;
  final int classroomId;
  final int termId;
  final int subjectId;
  final int? lessonId;
  final int? groupId;
  final int? levelId;
  const QuestionEntity({
    required this.id,
    required this.correctSelect,
    required this.point,
    this.skill,
    this.questionText,
    this.questionFile,
    this.questionType,
    this.descriptionText,
    this.descriptionFile,
    this.descriptionType,
    this.select1Text,
    this.select1File,
    this.select1Type,
    this.select2Text,
    this.select2File,
    this.select2Type,
    this.select3Text,
    this.select3File,
    this.select3Type,
    this.select4Text,
    this.select4File,
    this.select4Type,
    required this.stageId,
    required this.classroomId,
    required this.termId,
    required this.subjectId,
    required this.lessonId,
    this.groupId,
    this.levelId,
  });

  factory QuestionEntity.empty() {
    return const QuestionEntity(
      id: 0,
      correctSelect: '0',
      point: 0,
      stageId: 0,
      classroomId: 0,
      termId: 0,
      subjectId: 0,
      lessonId: 0,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      correctSelect,
      point,
      skill,
      questionText,
      questionFile,
      questionType,
      descriptionText,
      descriptionFile,
      descriptionType,
      select1Text,
      select1File,
      select1Type,
      select2Text,
      select2File,
      select2Type,
      select3Text,
      select3File,
      select3Type,
      select4Text,
      select4File,
      select4Type,
      stageId,
      classroomId,
      termId,
      subjectId,
      lessonId,
      groupId,
      levelId,
    ];
  }
}
