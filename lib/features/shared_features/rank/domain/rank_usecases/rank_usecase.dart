part of '../../rank.dart';

@LazySingleton()
class GetStageRankUseCase extends BaseUseCase<RankEntity, RankParameters> {
  final RankBaseRepository repository;

  GetStageRankUseCase({required this.repository});

  @override
  Future<Either<Failure, RankEntity>> call(RankParameters parameter) {
    return repository.getRankStage(parameter);
  }
}

@LazySingleton()
class GetClassroomRankUseCase extends BaseUseCase<RankEntity, RankParameters> {
  final RankBaseRepository repository;

  GetClassroomRankUseCase({required this.repository});

  @override
  Future<Either<Failure, RankEntity>> call(RankParameters parameter) {
    return repository.getRankClassroom(parameter);
  }
}

@LazySingleton()
class GetTermRankUseCase extends BaseUseCase<RankEntity, RankParameters> {
  final RankBaseRepository repository;

  GetTermRankUseCase({required this.repository});

  @override
  Future<Either<Failure, RankEntity>> call(RankParameters parameter) {
    return repository.getRankTerm(parameter);
  }
}

@LazySingleton()
class GetSubjectRankUseCase extends BaseUseCase<RankEntity, RankParameters> {
  final RankBaseRepository repository;

  GetSubjectRankUseCase({required this.repository});

  @override
  Future<Either<Failure, RankEntity>> call(RankParameters parameter) {
    return repository.getRankSubject(parameter);
  }
}
