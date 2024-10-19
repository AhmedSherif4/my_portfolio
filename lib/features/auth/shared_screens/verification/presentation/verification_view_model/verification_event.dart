part of '../../verification.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationCodeChecked extends VerificationEvent {
  final String code;
  final String email;
  final SignUpParameter signUpParameter;

  const VerificationCodeChecked(
      {required this.signUpParameter, required this.code, required this.email});

  @override
  List<Object> get props => [code, email];
}

class VerificationCodeResent extends VerificationEvent {
  final SendVerificationCodeParameter sendVerificationCodeParams;

  const VerificationCodeResent({required this.sendVerificationCodeParams});

  @override
  List<Object> get props => [sendVerificationCodeParams];
}

class SignedUp extends VerificationEvent {
  final SignUpParameter signUpParameter;

  const SignedUp({
    required this.signUpParameter,
  });

  @override
  List<Object> get props => [signUpParameter];
}
