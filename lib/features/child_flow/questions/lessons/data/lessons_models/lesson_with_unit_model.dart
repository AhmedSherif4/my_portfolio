import 'package:my_portfolio/features/child_flow/questions/lessons/data/lessons_models/lesson_model.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/domain/lessons_entities/lessons_entity.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/domain/lessons_entities/lessons_with_units_entity.dart';

class LessonWithUnitsModel extends LessonWithUnitsEntity {
  const LessonWithUnitsModel({
    required super.unitId,
    required super.unitName,
    required super.unitLessons,
  });

  factory LessonWithUnitsModel.fromMap(Map<String, dynamic> json) {
    return LessonWithUnitsModel(
      unitId: json['id'] as int,
      unitName: json['name'] as String,
      unitLessons: List<LessonEntity>.from(
          json['lessons'].map((x) => LessonsModel.fromMap(x))),
    );
  }
}
