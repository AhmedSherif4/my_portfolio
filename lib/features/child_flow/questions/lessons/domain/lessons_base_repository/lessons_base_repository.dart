part of '../../lessons.dart';

abstract class LessonsBaseRepository {
  Future<Either<Failure, List<LessonEntity>>> getLessons({
    required ParameterGoToQuestions getLessonsParameters,
  });

  Future<Either<Failure, List<LessonWithUnitsEntity>>> getLessonsByUnits({
    required ParameterGoToQuestions getLessonsParameters,
  });
}
