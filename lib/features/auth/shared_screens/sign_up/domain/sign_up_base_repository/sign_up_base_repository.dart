part of '../.././sign_up.dart';

abstract class SignUpBaseRepository {
  Future<Either<Failure, String>> sendVerificationCode(
      {required SendVerificationCodeParameter sendVerificationCodeParameter});

}
