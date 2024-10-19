
part of '../../random_exams.dart';

class RandomExamModel extends RandomExamEntityOutputs {
  const RandomExamModel({
    required super.id,
    required super.name,
    required super.degree,
    required super.subjectId,
    required super.questions,
    required super.childId,
    required super.updatedAt,
    required super.createdAt,
    required super.questionsNumber,
  });
  factory RandomExamModel.fromMap(Map<String, dynamic> map) {
    return RandomExamModel(
      id: map['id'] as int,
      name: map['name'] as String,
      degree: map['degree'] as int,
      subjectId: map['subject_id'] as int,
      questions: map['questions']!=null?List<QuestionEntity>.from((map['questions'] as List)
          .map((element) => QuestionModel.fromMap(element))).toList():[],
      childId: map['child_id'] as int,
      updatedAt: map['updated_at'] as String,
      createdAt: map['created_at'] as String,
      questionsNumber: map['number_questions'] as String,
    );
  }
}

