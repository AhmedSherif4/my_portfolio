part of '../../forget_password.dart';

abstract class ForgetPasswordBaseRepository {
  Future<Either<Failure, String>> forgetPassword({
    required String email,
    required UsersType userType,
    required SendType sendType,
  });
}
