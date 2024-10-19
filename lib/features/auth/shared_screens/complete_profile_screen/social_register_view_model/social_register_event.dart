import 'package:equatable/equatable.dart';

import '../domain/social_register_usecases/social_register_usecase.dart';

abstract class SocialRegisterEvent extends Equatable {
  const SocialRegisterEvent();

  @override
  List<Object> get props => [];
}

class SignedUpEvent extends SocialRegisterEvent {
  final SocialRegisterData signUpParameter;

  const SignedUpEvent({
    required this.signUpParameter,
  });

  @override
  List<Object> get props => [signUpParameter];
}
