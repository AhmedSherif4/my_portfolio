part of '../.././sign_up.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class VerificationCodeSentEvent extends SignUpEvent {
  final SendVerificationCodeParameter sendVerificationCodeParams;

  const VerificationCodeSentEvent({
    required this.sendVerificationCodeParams,
  });

  @override
  List<Object> get props => [
        sendVerificationCodeParams,
      ];
}

class SocialSignUpEvent extends SignUpEvent {
  final String socialId;

  const SocialSignUpEvent({required this.socialId});

  @override
  List<Object> get props => [socialId];
}

// class GetGoogleIdAndUserDataByGoogleAccountEvent extends SignUpEvent {}


// class ImagePickEvent extends SignUpEvent {
//   const ImagePickEvent();
//
//   @override
//   List<Object> get props => [];
// }
