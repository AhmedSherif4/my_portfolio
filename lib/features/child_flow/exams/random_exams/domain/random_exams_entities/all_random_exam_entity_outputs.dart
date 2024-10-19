part of'../../random_exams.dart';


class AllRandomExamEntityOutputs extends Equatable {
  final int id;
  final String name;
  final String questionsNumber;
  final int subjectId;
  final int childId;
  final int degree;
  final String updatedAt;
  final String createdAt;
  final List<RandomExamResultEntity> results;



  const AllRandomExamEntityOutputs({
    required this.id,
    required this.name,
    required this.degree,
    required this.subjectId,
    required this.results,
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
      results,
      childId,
      updatedAt,
      createdAt,
      questionsNumber
    ];
  }

  AllRandomExamEntityOutputs copyWith({
     int? id,
     String? name,
     String? questionsNumber,
     int? subjectId,
     int? childId,
     int? degree,
     String? updatedAt,
     String? createdAt,
     List<RandomExamResultEntity>? results,
  }) {
    return AllRandomExamEntityOutputs(
      id: id ?? this.id,
      name: name ?? this.name,
      questionsNumber: questionsNumber ?? this.questionsNumber,
      subjectId: subjectId ?? this.subjectId,
      childId: childId ?? this.childId,
      degree: degree ?? this.degree,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      results: results ?? this.results,
    );
  }
}
