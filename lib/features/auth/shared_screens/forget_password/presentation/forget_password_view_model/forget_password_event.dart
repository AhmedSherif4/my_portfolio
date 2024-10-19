part of '../../forget_password.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SentEmailForForgettingPassword extends ForgetPasswordEvent {
  final String email;
  final UsersType userType;
  final SendType sendType;

  const SentEmailForForgettingPassword({
    required this.email,
    required this.userType,
    required this.sendType,
  });

  @override
  List<Object> get props => [
        email,
        userType,
        sendType,
      ];
}
