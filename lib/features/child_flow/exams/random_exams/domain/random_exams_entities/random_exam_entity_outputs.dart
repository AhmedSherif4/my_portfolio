part of'../../random_exams.dart';

class RandomExamEntityOutputs extends Equatable {
  final int id;
  final String name;
  final String questionsNumber;
  final int subjectId;
  final int childId;
  final int degree;
  final String updatedAt;
  final String createdAt;
  final List<QuestionEntity> questions;



  const RandomExamEntityOutputs({
    required this.id,
    required this.name,
    required this.degree,
    required this.subjectId,
    required this.questions,
    required this.childId,
    required this.updatedAt,
    required this.createdAt,
    required this.questionsNumber,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      degree,
      subjectId,
      questions,
      childId,
      updatedAt,
      createdAt,
      questionsNumber
    ];
  }

  RandomExamEntityOutputs copyWith({
     int? id,
     String? name,
     String? questionsNumber,
     int? subjectId,
     int? childId,
     int? degree,
     String? updatedAt,
     String? createdAt,
     List<QuestionEntity>? questions,
  }) {
    return RandomExamEntityOutputs(
      id: id ?? this.id,
      name: name ?? this.name,
      questionsNumber: questionsNumber ?? this.questionsNumber,
      subjectId: subjectId ?? this.subjectId,
      childId: childId ?? this.childId,
      degree: degree ?? this.degree,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      questions: questions ?? this.questions,
    );
  }
}
