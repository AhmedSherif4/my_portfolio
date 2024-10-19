part of '../../collections.dart';

@LazySingleton()
class CollectionsUseCase extends BaseUseCase<List<LevelAndCollectionEntity>,
    ParameterGoToQuestions> {
  final CollectionsBaseRepository repository;

  CollectionsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LevelAndCollectionEntity>>> call(
      ParameterGoToQuestions parameter) async {
    return await repository.getCollections(
      collectionsParameters: parameter,
    );
  }
}
