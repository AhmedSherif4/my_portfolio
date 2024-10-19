part of '../../verification.dart';

@LazySingleton()
class CheckVerificationCodeUseCase
    extends BaseUseCase<bool, CheckVerificationCodeParameter> {
  final VerificationBaseRepository repository;

  CheckVerificationCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CheckVerificationCodeParameter parameter) {
    return repository.checkVerificationCode(
      code: parameter.code,
      emailOrPhone: parameter.emailOrPhone,
    );
  }
}

class CheckVerificationCodeParameter extends Equatable {
  final String code;
  final String emailOrPhone;

  const CheckVerificationCodeParameter({
    required this.code,
    required this.emailOrPhone,
  });

  @override
  List<Object?> get props => [code, emailOrPhone];
}

@LazySingleton()
class ResendVerificationCodeUseCase
    extends BaseUseCase<String, SendVerificationCodeParameter> {
  final VerificationBaseRepository repository;

  ResendVerificationCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      SendVerificationCodeParameter parameter) {
    return repository.resendVerificationCode(
        sendVerificationCodeParameter: parameter);
  }
}

@LazySingleton()
class SignUpUseCase extends BaseUseCase<AuthEntity, SignUpParameter> {
  final VerificationBaseRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call(SignUpParameter parameter) {
    return repository.signUp(signUpParameter: parameter);
  }
}

class SignUpParameter extends Equatable {
  final String name;
  final String emailOrPhone;
  final UsersType type;
  final SendType sendType;
  final String gendar;
  final String img;
  final String password;

  const SignUpParameter({
    required this.sendType,
    required this.password,
    required this.name,
    required this.emailOrPhone,
    required this.type,
    required this.gendar,
    this.img = '',
  });

  @override
  List<Object?> get props => [
        name,
        emailOrPhone,
        type,
        sendType,
        gendar,
        img,
        password,
      ];
}
