part of '../.././sign_up.dart';

class SignUpState extends Equatable {
  final String sendVerificationCodeMessage;
  final RequestStates sendVerificationCodeStates;
  final RequestStates socialSignUpStates;


  final RequestStates getGoogleIdAndUserDataByGoogleAccountState;
  final SocialLoginDataEntity socialLoginDataEntity;


  final PickImageState pickImageState;
  final String pickImageErrorMessage;

  const SignUpState({
    this.socialSignUpStates = RequestStates.initial,
    this.sendVerificationCodeStates = RequestStates.initial,
    this.sendVerificationCodeMessage = '',
    this.getGoogleIdAndUserDataByGoogleAccountState = RequestStates.initial,
    this.socialLoginDataEntity = const SocialLoginDataEntity(
      email: '',
      displayName: '',
      photoUrl: '',
      socialId: '',
    ),
    this.pickImageState = PickImageState.init,
    this.pickImageErrorMessage = '',

  });

  SignUpState copyWith({
    RequestStates? sendVerificationCodeStates,
    RequestStates? socialSignUpStates,
    String? sendVerificationCodeMessage,
    RequestStates? getGoogleIdAndUserDataByGoogleAccountState,
    SocialLoginDataEntity? socialLoginDataEntity,
    PickImageState? pickImageState,
    String? pickImageErrorMessage,

  }) {
    return SignUpState(
      socialSignUpStates: socialSignUpStates ?? this.socialSignUpStates,
      sendVerificationCodeStates:
          sendVerificationCodeStates ?? RequestStates.initial,
      sendVerificationCodeMessage:
          sendVerificationCodeMessage ?? this.sendVerificationCodeMessage,
      getGoogleIdAndUserDataByGoogleAccountState:
          getGoogleIdAndUserDataByGoogleAccountState ??
              this.getGoogleIdAndUserDataByGoogleAccountState,
      socialLoginDataEntity:
          socialLoginDataEntity ?? this.socialLoginDataEntity,
      pickImageErrorMessage:
          pickImageErrorMessage ?? this.pickImageErrorMessage,
      pickImageState: pickImageState ?? this.pickImageState,

    );
  }

  @override
  List<Object> get props => [
        sendVerificationCodeMessage,
        sendVerificationCodeStates,
        getGoogleIdAndUserDataByGoogleAccountState,
        socialLoginDataEntity,
        pickImageState,
        pickImageErrorMessage,
        socialSignUpStates
      ];
}
