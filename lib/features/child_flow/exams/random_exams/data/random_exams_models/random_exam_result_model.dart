part of '../../random_exams.dart';

class RandomExamResultModel extends RandomExamResultEntity {
  const RandomExamResultModel({
    required super.childId,
    required super.childAnswer,
    required super.correctAnswer,
    required super.result,
    required super.examId,
  });

  factory RandomExamResultModel.fromMap(Map<String, dynamic> map) {
    return RandomExamResultModel(
      childId: map['child_id'],
      childAnswer: map['child_answer'],
      correctAnswer: map['correct_answer'],
      result: map['result'],
      examId: map['exam_id'],);
  }
}

