part of '../../un_link.dart';

abstract class UnLinkRepository {
  Future<Either<Failure, String>> userUnLink({required int userId});
  Future<Either<Failure, String>> childAddNewParent({required String emailOrPhone});
  Future<Either<Failure, String>> childAddExistParent({required String username});
  Future<Either<Failure, String>> parentAddNewChild({required String mailOrPhone});
  Future<Either<Failure, String>> parentAddExistChild({required String username});
}