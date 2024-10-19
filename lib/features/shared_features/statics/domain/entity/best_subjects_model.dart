part of '../../statics.dart';

class BestSubjectsModel extends Equatable {
  final String subjectName;
  final int lessonQuestionSumPoint;
  final int answersSumPoint;

  const BestSubjectsModel({
    required this.lessonQuestionSumPoint,
    required this.answersSumPoint,
    required this.subjectName,
  });

  factory BestSubjectsModel.fromJson(Map<String, dynamic> json) {
    return BestSubjectsModel(
      lessonQuestionSumPoint:
          int.tryParse('${json['questions_sum_point']}') ?? 0,
      answersSumPoint: int.tryParse('${json['answers_sum_point']}') ?? 0,
      subjectName: json['name'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        subjectName,
        lessonQuestionSumPoint,
        answersSumPoint,
      ];
}
