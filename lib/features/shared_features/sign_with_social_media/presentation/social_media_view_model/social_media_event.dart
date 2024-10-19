
import 'package:equatable/equatable.dart';

abstract class SignWithSocialMediaEvent extends Equatable {
  const SignWithSocialMediaEvent();
}

class GetGoogleIdAndUserDataByGoogleAccountEvent extends SignWithSocialMediaEvent {
  @override
  List<Object?> get props => [];
}

class SocialLoginEvent extends SignWithSocialMediaEvent {
  final String socialId;

  const SocialLoginEvent({required this.socialId});

  @override
  List<Object?> get props => [socialId];
}
