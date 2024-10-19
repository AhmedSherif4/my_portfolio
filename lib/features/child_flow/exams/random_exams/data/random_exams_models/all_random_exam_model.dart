
part of '../../random_exams.dart';

class AllRandomExamModel extends AllRandomExamEntityOutputs {
  const AllRandomExamModel({
    required super.id,
    required super.name,
    required super.degree,
    required super.subjectId,
    required super.results,
    required super.childId,
    required super.updatedAt,
    required super.createdAt,
    required super.questionsNumber,
  });
  factory AllRandomExamModel.fromMap(Map<String, dynamic> map) {
    return AllRandomExamModel(
      id: map['id'] as int,
      name: map['name'] as String,
      degree: map['degree'] as int,
      subjectId: map['subject_id'] as int,
      results: map['results']!=null?List<RandomExamResultEntity>.from((map['results'] as List)
          .map((element) => RandomExamResultModel.fromMap(element))).toList():[],
      childId: map['child_id'] as int,
      updatedAt: map['updated_at'] as String,
      createdAt: map['created_at'] as String,
      questionsNumber: map['number_questions'] as String,
    );
  }
}

