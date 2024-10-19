
import 'package:equatable/equatable.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../domain/entity/social_login_data_entity.dart';

class GetSocialDataState extends Equatable {
  final RequestStates getGoogleDataState;
  final RequestStates getAppleDataState;
  final SocialLoginDataEntity socialLoginDataEntity;
  final String loginMessage;


  const GetSocialDataState(
      {
      this.getGoogleDataState = RequestStates.initial,
      this.getAppleDataState = RequestStates.initial,
      this.loginMessage = '',
      this.socialLoginDataEntity = const SocialLoginDataEntity(
        email: '',
        displayName: '',
        photoUrl: '',
        socialId: '',
      )});

  GetSocialDataState copyWith({
    RequestStates? getGoogleDataState,
    RequestStates? getAppleDataState,
    SocialLoginDataEntity? socialLoginDataEntity,
    RequestStates? socialLoginStates,
    String? loginMessage
  }) {
    return GetSocialDataState(
        getGoogleDataState: getGoogleDataState ?? this.getGoogleDataState,
        getAppleDataState: getAppleDataState ?? this.getAppleDataState,
      socialLoginDataEntity:
          socialLoginDataEntity ?? this.socialLoginDataEntity,
      loginMessage: loginMessage ?? this.loginMessage
    );
  }

  @override
  List<Object> get props => [
        getGoogleDataState,
    getAppleDataState,
        socialLoginDataEntity,
        loginMessage
      ];
}
