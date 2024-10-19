part of '../../levels.dart';

@LazySingleton()
class LevelsUseCase extends BaseUseCase<List<LevelAndCollectionEntity>,
    ParameterGoToQuestions> {
  final LevelsBaseRepository repository;

  LevelsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LevelAndCollectionEntity>>> call(
      ParameterGoToQuestions parameter) async {
    return await repository.getLevels(levelParameters: parameter);
  }
}
