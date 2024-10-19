part of '../../un_link.dart';

class UnLinkState extends Equatable {
  final RequestStates unLinkState;
  final String unLinkMessage;

  final RequestStates childAddNewParentStates;
  final String childAddNewParentMessage;

  final RequestStates childAddExitParentStates;
  final String childAddExitParentMessage;

  final RequestStates parentAddNewChildStates;
  final String parentAddNewChildMessage;

  final RequestStates parentAddExistChildStates;
  final String parentAddExistChildMessage;

  const UnLinkState({
    this.unLinkState = RequestStates.initial,
    this.unLinkMessage = '',
    this.childAddNewParentStates = RequestStates.initial,
    this.childAddNewParentMessage = '',
    this.childAddExitParentStates = RequestStates.initial,
    this.childAddExitParentMessage = '',
    this.parentAddNewChildStates = RequestStates.initial,
    this.parentAddNewChildMessage = "",
    this.parentAddExistChildStates = RequestStates.initial,
    this.parentAddExistChildMessage = "",
  });

  UnLinkState copyWith({
    RequestStates? unLinkState,
    String? unLinkMessage,
    RequestStates? childAddNewParentStates,
    String? childAddNewParentMessage,
    RequestStates? childAddExitParentStates,
    String? childAddExitParentMessage,
    RequestStates? parentAddNewChildStates,
    String? parentAddNewChildMessage,
    RequestStates? parentAddExistChildStates,
    String? parentAddExistChildMessage,
  }) {
    return UnLinkState(
      unLinkMessage: unLinkMessage ?? this.unLinkMessage,
      unLinkState: unLinkState ?? this.unLinkState,
      childAddNewParentMessage:
          childAddNewParentMessage ?? this.childAddNewParentMessage,
      childAddNewParentStates:
          childAddNewParentStates ?? this.childAddNewParentStates,
      childAddExitParentMessage:
          childAddExitParentMessage ?? this.childAddExitParentMessage,
      childAddExitParentStates:
          childAddExitParentStates ?? this.childAddExitParentStates,
      parentAddNewChildStates:
          parentAddNewChildStates ?? this.parentAddNewChildStates,
      parentAddNewChildMessage:
          parentAddNewChildMessage ?? this.parentAddNewChildMessage,
      parentAddExistChildStates:
          parentAddExistChildStates ?? this.parentAddExistChildStates,
      parentAddExistChildMessage:
          parentAddExistChildMessage ?? this.parentAddExistChildMessage,
    );
  }

  @override
  List<Object> get props => [
        unLinkState,
        unLinkMessage,
        childAddNewParentMessage,
        childAddNewParentStates,
        childAddExitParentMessage,
        childAddExitParentStates,
        parentAddNewChildStates,
        parentAddNewChildMessage,
        parentAddExistChildStates,
        parentAddExistChildMessage
      ];
}
