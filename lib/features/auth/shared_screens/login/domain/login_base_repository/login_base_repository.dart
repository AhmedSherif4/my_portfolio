part of '../../login.dart';

abstract class LoginBaseRepository {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
    required UsersType userType,
  });

  Future<Either<Failure, AuthEntity>> socialLogin({
    required String socialId,
  });
}
