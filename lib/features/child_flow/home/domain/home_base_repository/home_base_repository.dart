part of '../../home.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, List<SubjectsEntity>>> getSubjects({
    required ParameterGoToQuestions subjectsParameters,
  });

  Future<Either<Failure, PuzzleAndAdviceEntity>> getPuzzleAndAdvice();
}
