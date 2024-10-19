import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class InvitationState extends Equatable {
  final RequestStates invitationState;
  final String invitationMessage;


  const InvitationState({
    this.invitationState = RequestStates.initial,
    this.invitationMessage = '',
  });

  InvitationState copyWith({
     RequestStates? invitationState,
     String? invitationMessage,
  }) {
    return InvitationState(
      invitationState: invitationState ?? this.invitationState,
      invitationMessage: invitationMessage ?? this.invitationMessage,
    );
  }

  @override
  List<Object?> get props => [
        invitationState,
        invitationMessage,
      ];
}
