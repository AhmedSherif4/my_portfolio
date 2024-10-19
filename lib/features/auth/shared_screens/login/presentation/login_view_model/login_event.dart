part of '../../login.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoggedIn extends LoginEvent {
  final String email;
  final String password;
  final UsersType userType;

  const LoggedIn({
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object> get props => [
    email,
    password,
    userType,
  ];
}

class SocialLoginEvent extends LoginEvent {
  final String socialId;

  const SocialLoginEvent({required this.socialId});

  @override
  List<Object?> get props => [socialId];
}

