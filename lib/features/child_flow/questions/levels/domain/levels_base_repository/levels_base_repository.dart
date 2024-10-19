part of '../../levels.dart';

abstract class LevelsBaseRepository {
  Future<Either<Failure, List<LevelAndCollectionEntity>>> getLevels({
    required ParameterGoToQuestions levelParameters,
  });
}
