part of '../../parent_preview_for_child.dart';

@LazySingleton(as: ParentPreviewForChildBaseRepository)
class ParentPreviewForChildRepository
    implements ParentPreviewForChildBaseRepository {
  final ParentPreviewForChildRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final ParentPreviewForChildLocalDataSource parentLocalDataSource;

  ParentPreviewForChildRepository({
    required this.parentLocalDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<ParentPreviewForChildEntity>>>
      getAllParents() async {
    final allParents = await parentLocalDataSource.getAllParents();
    if (allParents != null) {
      return Right(allParents);
    }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getAllParents(),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        await parentLocalDataSource.saveAllParents(allParents: data);
        return Right(data);
      },
    );
  }
}
