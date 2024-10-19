part of '../../lessons.dart';

@LazySingleton()
class GetLessonsUseCase
    extends BaseUseCase<List<LessonEntity>, ParameterGoToQuestions> {
  final LessonsBaseRepository repository;

  GetLessonsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<LessonEntity>>> call(parameter) async {
    return await repository.getLessons(getLessonsParameters: parameter);
  }
}

@LazySingleton()
class GetLessonsByUnitUseCase
    extends BaseUseCase<List<LessonWithUnitsEntity>, ParameterGoToQuestions> {
  final LessonsBaseRepository repository;

  GetLessonsByUnitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<LessonWithUnitsEntity>>> call(parameter) async {
    return await repository.getLessonsByUnits(getLessonsParameters: parameter);
  }
}
