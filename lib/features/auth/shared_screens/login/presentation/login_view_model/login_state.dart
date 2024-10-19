part of '../../login.dart';

class LoginState extends Equatable {
  final RequestStates loginStates;
  final String loginMessage;

  final SocialLoginDataEntity socialLoginDataEntity;
  final RequestStates socialLoginStates;

  const LoginState(
      {this.loginStates = RequestStates.initial,
      this.socialLoginStates = RequestStates.initial,
      this.loginMessage = '',
        this.socialLoginDataEntity = const SocialLoginDataEntity(
        email: '',
        displayName: '',
        photoUrl: '',
        socialId: '',
      )});

  LoginState copyWith({
    RequestStates? loginStates,
    String? loginMessage,
    SocialLoginDataEntity? socialLoginDataEntity,
    RequestStates? socialLoginStates,
  }) {
    return LoginState(
      loginStates: loginStates ?? this.loginStates,
      loginMessage: loginMessage ?? this.loginMessage,
      socialLoginDataEntity: socialLoginDataEntity ?? this.socialLoginDataEntity,
      socialLoginStates: socialLoginStates ?? this.socialLoginStates,
    );
  }

  @override
  List<Object> get props => [
        loginStates,
        loginMessage,
        socialLoginDataEntity,
        socialLoginStates,
      ];
}
