part of '../../rank.dart';

abstract class RankBaseRepository {
  Future<Either<Failure, RankEntity>> getRankStage(
      RankParameters rankParameters);

  Future<Either<Failure, RankEntity>> getRankClassroom(
      RankParameters rankParameters);

  Future<Either<Failure, RankEntity>> getRankTerm(
      RankParameters rankParameters);

  Future<Either<Failure, RankEntity>> getRankSubject(
      RankParameters rankParameters);
}
