part of '../.././sign_up.dart';

@LazySingleton()
class SendVerificationCodeUseCase
    extends BaseUseCase<String, SendVerificationCodeParameter> {
  final SignUpBaseRepository repository;

  SendVerificationCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      SendVerificationCodeParameter parameter) async {
    return await repository.sendVerificationCode(
        sendVerificationCodeParameter: parameter);
  }
}

class SendVerificationCodeParameter extends Equatable {
  final String emailOrPhone;
  final SendType sendType;
  final UsersType userType;

  const SendVerificationCodeParameter({
    required this.emailOrPhone,
    required this.sendType,
    required this.userType,
  });

  @override
  List<Object?> get props => [
        emailOrPhone,
        sendType,
        userType,
      ];
}

