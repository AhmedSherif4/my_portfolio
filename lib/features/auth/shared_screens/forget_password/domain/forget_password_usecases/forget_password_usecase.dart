part of '../../forget_password.dart';

@LazySingleton()
class ForgetPasswordUseCase extends BaseUseCase<String, ForgetPasswordParameter> {
  final ForgetPasswordBaseRepository repository;

  ForgetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ForgetPasswordParameter parameter) async {
    return await repository.forgetPassword(
      email: parameter.email,
      userType: parameter.userType,
      sendType: parameter.sendType,
    );
  }
}

class ForgetPasswordParameter extends Equatable {
  final String email;
  final UsersType userType;
  final SendType sendType;

 const ForgetPasswordParameter({
    required this.email,
    required this.userType,
    required this.sendType,
  });

  @override
  List<Object?> get props => [
        email,
        userType,
        sendType,
      ];
}