import 'package:my_portfolio/features/child_flow/questions/lessons/domain/lessons_entities/lessons_entity.dart';

class LessonsModel extends LessonEntity {
  const LessonsModel({
    required super.description,
    required super.name,
    required super.imgPath,
    required super.lessonSkipPoints,
    required super.lessonUserPoints,
    required super.lessonId,
  });

  factory LessonsModel.fromMap(Map<String, dynamic> json) {
    return LessonsModel(
      lessonId: json['id'] as int,
      name: json['name'] as String,
      lessonSkipPoints: json['skip_point']  as int,
      lessonUserPoints: json['child_answers_point'] ?? 0,
      imgPath: json['img'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
