part of '../../collections.dart';

abstract class CollectionsRemoteDataSource {
  Future<List<LevelAndCollectionEntity>> getCollections({
    required ParameterGoToQuestions collectionsParameter,
  });
}

@LazySingleton(as: CollectionsRemoteDataSource)
class CollectionsRemoteDataSourceImpl implements CollectionsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  const CollectionsRemoteDataSourceImpl({
    required this.baseRemoteDataSource,
  });

  @override
  Future<List<LevelAndCollectionEntity>> getCollections(
      {required ParameterGoToQuestions collectionsParameter}) async {

    final response =
        await baseRemoteDataSource.postData(url: EndPoints.collections, body: {

      'level_id': collectionsParameter.levelId,

    });
    final allCollections = List<LevelAndCollectionEntity>.from(
        (response['data'] as List)
            .map((element) => CollectionModel.fromMap(element)));

    return allCollections;
  }
}
