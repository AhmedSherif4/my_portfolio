part of '../../verification.dart';

abstract class VerificationBaseRepository {
  Future<Either<Failure, bool>> checkVerificationCode({
    required String code,
    required String emailOrPhone,
  });

  Future<Either<Failure, String>> resendVerificationCode({
    required SendVerificationCodeParameter sendVerificationCodeParameter,
  });

  Future<Either<Failure, AuthEntity>> signUp({
    required SignUpParameter signUpParameter,
  });
}
