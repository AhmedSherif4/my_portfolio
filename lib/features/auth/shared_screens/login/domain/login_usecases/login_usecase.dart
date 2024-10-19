// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../login.dart';

@LazySingleton()
class LoginUseCase extends BaseUseCase<AuthEntity, LoginParameter> {
  final LoginBaseRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call(LoginParameter parameter) async {
    return await repository.login(
      email: parameter.email,
      password: parameter.password,
      userType: parameter.userType,
    );
  }
}

class LoginParameter extends Equatable {
  final String email;
  final String password;
  final UsersType userType;

  const LoginParameter({
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        userType,
      ];
}
