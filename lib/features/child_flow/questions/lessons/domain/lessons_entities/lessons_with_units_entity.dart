import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'lessons_entity.dart';

part 'lessons_with_units_entity.g.dart';

@HiveType(typeId: 7)
class LessonWithUnitsEntity extends Equatable {
  @HiveField(0)
  final int unitId;
  @HiveField(1)
  final String unitName;
  @HiveField(2)
  final List<LessonEntity> unitLessons;

  const LessonWithUnitsEntity({
    required this.unitId,
    required this.unitName,
    required this.unitLessons,

  });

  LessonWithUnitsEntity copyWith({
    int? unitId,
    String?unitName,
    List<LessonEntity>?unitLessons,
    int? lessonUserPoints

  }) {
    return LessonWithUnitsEntity(
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      unitLessons: unitLessons ?? this.unitLessons,
    );
  }


  @override
  List<Object?> get props => [
        unitId,
        unitName,
        unitLessons,
      ];
}
