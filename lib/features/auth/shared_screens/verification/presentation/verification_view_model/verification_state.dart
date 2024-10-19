part of '../../verification.dart';

class VerificationState extends Equatable {
  final bool isCodeVerified;
  final RequestStates checkVerificationStates;
  final String checkVerificationErrorMessage;

  final String resendVerificationCodeMessage;
  final RequestStates resendVerificationCodeStates;

  final String signUpMessage;
  final RequestStates signUpStates;

  const VerificationState({
    this.isCodeVerified = false,
    this.checkVerificationStates = RequestStates.initial,
    this.checkVerificationErrorMessage = '',
    this.resendVerificationCodeMessage = '',
    this.resendVerificationCodeStates = RequestStates.initial,
    this.signUpMessage = '',
    this.signUpStates = RequestStates.initial,
  });

  VerificationState copyWith({
    bool? isCodeVerified,
    RequestStates? checkVerificationStates,
    String? checkVerificationErrorMessage,
    String? resendVerificationCodeMessage,
    RequestStates? resendVerificationCodeStates,
    String? signUpMessage,
    RequestStates? signUpStates,
  }) {
    return VerificationState(
      isCodeVerified: isCodeVerified ?? this.isCodeVerified,
      checkVerificationStates:
          checkVerificationStates ?? this.checkVerificationStates,
      checkVerificationErrorMessage:
          checkVerificationErrorMessage ?? this.checkVerificationErrorMessage,
      resendVerificationCodeMessage:
          resendVerificationCodeMessage ?? this.resendVerificationCodeMessage,
      resendVerificationCodeStates:
          resendVerificationCodeStates ?? this.resendVerificationCodeStates,
      signUpMessage: signUpMessage ?? this.signUpMessage,
      signUpStates: signUpStates ?? this.signUpStates,
    );
  }

  @override
  List<Object> get props => [
        isCodeVerified,
        checkVerificationStates,
        checkVerificationErrorMessage,
        resendVerificationCodeMessage,
        resendVerificationCodeStates,
        signUpMessage,
        signUpStates,
      ];
}
