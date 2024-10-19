part of '../../statics.dart';

class LessonsStaticsModel extends Equatable {
  final List<LessonData> lessonsData;
  final int finishLessons;
  final int totalLessons;
  final int maxTime;
  final int maxAttempts;
  final int maxPoint;

  const LessonsStaticsModel({
    required this.lessonsData,
    required this.finishLessons,
    required this.totalLessons,
    required this.maxTime,
    required this.maxAttempts,
    required this.maxPoint,
  });

  factory LessonsStaticsModel.fromJson(Map<String, dynamic> json) {
    return LessonsStaticsModel(
      lessonsData: (json['lessons'] as List<dynamic>)
          .map((lessonJson) => LessonData.fromJson(lessonJson))
          .toList(),
      finishLessons: json['Finish_Lessons'] ?? 0,
      totalLessons: json['Total_Lessons'] ?? 0,
      maxTime: json['MaxTime'] ?? 0,
      maxAttempts: json['MaxAttempts'] ?? 0,
      maxPoint: json['MaxPoint'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        finishLessons,
        totalLessons,
        maxTime,
        maxAttempts,
        maxPoint,
      ];
}

class LessonData extends Equatable {
  final int point;
  final int answerTime;
  final int attempts;
  final int lessonId;

  const LessonData(
      {required this.point,
      required this.answerTime,
      required this.attempts,
      required this.lessonId});

  factory LessonData.fromJson(Map<String, dynamic> json) {
    return LessonData(
      lessonId: json['lesson_id'] as int,
      point: json['point'] as int,
      answerTime: json['answer_time'] as int,
      attempts: json['attempts'] as int,
    );
  }

  @override
  List<Object?> get props => [
        point,
        answerTime,
        attempts,
      ];
}
