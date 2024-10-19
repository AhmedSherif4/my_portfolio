import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'lessons_entity.g.dart';

@HiveType(typeId: 3)
class LessonEntity extends Equatable {
  @HiveField(0)
  final String description;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imgPath;
  @HiveField(3)
  final int lessonSkipPoints;
  @HiveField(4)
  final int lessonUserPoints;
  @HiveField(5)
  final int lessonId;

  const LessonEntity({
    required this.lessonId,
    required this.description,
    required this.name,
    required this.imgPath,
    required this.lessonSkipPoints,
    required this.lessonUserPoints,
  });

  LessonEntity copyWith({
    String? description,
    String? name,
    String? imgPath,
    int? lessonSkipPoints,
    int? lessonUserPoints,
    int? lessonId,
  }) {
    return LessonEntity(
      description: description ?? this.description,
      name: name ?? this.name,
      imgPath: imgPath ?? this.imgPath,
      lessonSkipPoints: lessonSkipPoints ?? this.lessonSkipPoints,
      lessonUserPoints: lessonUserPoints ?? this.lessonUserPoints,
      lessonId: lessonId ?? this.lessonId,
    );
  }

  @override
  List<Object?> get props => [
        description,
        name,
        imgPath,
        lessonSkipPoints,
        lessonUserPoints,
        lessonId
      ];
}
