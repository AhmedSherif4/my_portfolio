part of '../../rank.dart';

@LazySingleton(as: RankBaseRepository)
class RankRepository implements RankBaseRepository {
  final RankRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  RankRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, RankEntity>> getRankStage(
      RankParameters rankParameters) async {
    return baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getRankStage(rankParameters),
    );
  }

  @override
  Future<Either<Failure, RankEntity>> getRankClassroom(
      RankParameters rankParameters) async {
    return baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getRankClassroom(rankParameters),
    );
  }

  @override
  Future<Either<Failure, RankEntity>> getRankTerm(
      RankParameters rankParameters) async {
    return baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getRankTerm(rankParameters),
    );
  }

  @override
  Future<Either<Failure, RankEntity>> getRankSubject(
      RankParameters rankParameters) async {
    return baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getRankSubject(rankParameters),
    );
  }
}
