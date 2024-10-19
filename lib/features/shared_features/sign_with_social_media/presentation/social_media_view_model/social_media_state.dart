
import 'package:equatable/equatable.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../get_social_data/domain/entity/social_login_data_entity.dart';

class SignWithSocialMediaState extends Equatable {
  final RequestStates getGoogleIdAndUserDataByGoogleAccountState;
  final SocialLoginDataEntity socialLoginDataEntity;
  final RequestStates socialLoginStates;
  final String loginMessage;


  const SignWithSocialMediaState(
      {this.socialLoginStates = RequestStates.initial,
      this.getGoogleIdAndUserDataByGoogleAccountState = RequestStates.initial,
      this.loginMessage = '',
      this.socialLoginDataEntity = const SocialLoginDataEntity(
        email: '',
        displayName: '',
        photoUrl: '',
        socialId: '',
      )});

  SignWithSocialMediaState copyWith({
    RequestStates? getGoogleIdAndUserDataByGoogleAccountState,
    SocialLoginDataEntity? socialLoginDataEntity,
    RequestStates? socialLoginStates,
    String? loginMessage
  }) {
    return SignWithSocialMediaState(
      getGoogleIdAndUserDataByGoogleAccountState:
          getGoogleIdAndUserDataByGoogleAccountState ??
              this.getGoogleIdAndUserDataByGoogleAccountState,
      socialLoginDataEntity:
          socialLoginDataEntity ?? this.socialLoginDataEntity,
      socialLoginStates: socialLoginStates ?? this.socialLoginStates,
      loginMessage: loginMessage ?? this.loginMessage
    );
  }

  @override
  List<Object> get props => [
        getGoogleIdAndUserDataByGoogleAccountState,
        socialLoginDataEntity,
        socialLoginStates,
        loginMessage
      ];
}
