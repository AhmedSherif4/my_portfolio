import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class SocialRegisterState extends Equatable {
  final RequestStates signUpStates;
  final String signUpMessage;

  const SocialRegisterState({
    this.signUpStates = RequestStates.initial,
    this.signUpMessage = '',
  });

  SocialRegisterState copyWith({
    RequestStates? signUpStates,
    String? signUpMessage,
  }) {
    return SocialRegisterState(
      signUpStates: signUpStates ?? this.signUpStates,
      signUpMessage: signUpMessage ?? this.signUpMessage,
    );
  }

  @override
  List<Object> get props => [
        signUpStates,
        signUpMessage,
      ];
}
