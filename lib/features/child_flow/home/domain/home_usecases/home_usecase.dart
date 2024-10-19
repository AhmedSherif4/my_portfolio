part of '../../home.dart';

@LazySingleton()
class GetSubjectsUseCase
    extends BaseUseCase<List<SubjectsEntity>, ParameterGoToQuestions> {
  final HomeBaseRepository repository;

  GetSubjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SubjectsEntity>>> call(
      ParameterGoToQuestions parameter) async {
    return await repository.getSubjects(subjectsParameters: parameter);
  }
}

@LazySingleton()
class GetPuzzleAndAdviceUseCase
    extends BaseUseCase<PuzzleAndAdviceEntity, NoParameter> {
  final HomeBaseRepository repository;

  GetPuzzleAndAdviceUseCase({required this.repository});

  @override
  Future<Either<Failure, PuzzleAndAdviceEntity>> call(
      NoParameter parameter) async {
    return await repository.getPuzzleAndAdvice();
  }
}
