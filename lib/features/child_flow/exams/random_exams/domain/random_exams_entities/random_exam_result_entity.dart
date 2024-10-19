part of'../../random_exams.dart';

class RandomExamResultEntity extends Equatable {
  final String correctAnswer;
  final String childAnswer;
  final String result;
  final int examId;
  final int childId;



  const RandomExamResultEntity({
    required this.correctAnswer,
    required this.childAnswer,
    required this.result,
    required this.examId,
    required this.childId,
  });

  @override
  List<Object?> get props {
    return [
      correctAnswer,
      childAnswer,
      result,
      examId,
      childId,
    ];
  }

  RandomExamResultEntity copyWith({
     String? correctAnswer,
     String? childAnswer,
     String? result,
     int? examId,
     int? childId,

  }) {
    return RandomExamResultEntity(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      childAnswer: childAnswer ?? this.childAnswer,
      result: result ?? this.result,
      examId: examId ?? this.examId,
      childId: childId ?? this.childId,
    );
  }
}
