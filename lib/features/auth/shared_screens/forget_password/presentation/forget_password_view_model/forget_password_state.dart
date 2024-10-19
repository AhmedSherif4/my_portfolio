part of '../../forget_password.dart';

class ForgetPasswordState extends Equatable {
  final RequestStates forgetPasswordStates;
  final String forgetPasswordMessage;

  const ForgetPasswordState({
    this.forgetPasswordStates = RequestStates.initial,
    this.forgetPasswordMessage = '',
  });

  ForgetPasswordState copyWith({
    RequestStates? forgetPasswordStates,
    String? forgetPasswordMessage,
  }) {
    return ForgetPasswordState(
      forgetPasswordStates: forgetPasswordStates ?? this.forgetPasswordStates,
      forgetPasswordMessage:
          forgetPasswordMessage ?? this.forgetPasswordMessage,
    );
  }

  @override
  List<Object> get props => [
        forgetPasswordStates,
        forgetPasswordMessage,
      ];
}
