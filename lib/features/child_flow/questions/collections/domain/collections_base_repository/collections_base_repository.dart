part of '../../collections.dart';

abstract class CollectionsBaseRepository {
  Future<Either<Failure, List<LevelAndCollectionEntity>>> getCollections({
    required ParameterGoToQuestions collectionsParameters,
  });
}
