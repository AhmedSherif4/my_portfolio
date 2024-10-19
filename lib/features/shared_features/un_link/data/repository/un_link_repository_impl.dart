part of '../../un_link.dart';

@LazySingleton(
  as: UnLinkRepository,
)
class UnLinkRepositoryImpl implements UnLinkRepository {
  final UnLinkRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  UnLinkRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> userUnLink({required int userId}) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.userUnLink(userId: userId),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, String>> childAddNewParent({
    required String emailOrPhone,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.childAddNewParent(
        emailOrPhone: emailOrPhone,
      ),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, String>> childAddExistParent(
      {required String username}) async {
    final json = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.childAddExistParent(username: username),
    );
    return json.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, String>> parentAddNewChild({
    required String mailOrPhone,
  }) async {
    final data = remoteDataSource.parentAddNewChild(
      mailOrPhone: mailOrPhone,
    );
    final jsonData =
    await baseRepository.checkExceptionForRemoteData<String>(data);
    return jsonData.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, String>> parentAddExistChild(
      {required String username}) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.parentAddExistChild(username: username),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }
}
