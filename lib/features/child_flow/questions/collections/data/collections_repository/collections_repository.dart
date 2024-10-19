part of '../../collections.dart';

@LazySingleton(as: CollectionsBaseRepository)
class CollectionsRepository implements CollectionsBaseRepository {
  final CollectionsRemoteDataSource remoteDataSource;
  // final CollectionsLocalDataSource collectionsLocalDataSource;
  final BaseRepository baseRepository;

  CollectionsRepository( {
    required this.remoteDataSource,
    // required this.collectionsLocalDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<LevelAndCollectionEntity>>> getCollections(
      {required ParameterGoToQuestions collectionsParameters}) async {
    ///...........get Collections from local data source.............
    // final int id = collectionsParameters.subjectId;
    // final allCollectionsLocal =
    //     await collectionsLocalDataSource.getCollectionInLocalData(levelID: id);
    // if (allCollectionsLocal != null) {
    //   return Right(allCollectionsLocal);
    // } else {
      ///...........get Collections from remote data source.............
      final jsonData = await baseRepository.checkExceptionForRemoteData(
        remoteDataSource.getCollections(
            collectionsParameter: collectionsParameters),
      );
      return jsonData.fold(
        (failure) => left(failure),
        (allCollections) async {
          // await collectionsLocalDataSource.saveCollectionInLocalData(
          //   levelID: collectionsParameters.subjectId,
          //   data: allCollections,
          // );
          return Right(allCollections);
        },
      );
    }
  // }
}
