part of '../../parent_preview_for_child.dart';

class ParentPreviewForChildState extends Equatable {
  final RequestStates getParentState;
  final List<ParentPreviewForChildEntity> allParent;
  final String getParentMessage;

  const ParentPreviewForChildState({
    this.getParentState = RequestStates.initial,
    this.allParent = const [],
    this.getParentMessage = '',
  });

  ParentPreviewForChildState copyWith({
    RequestStates? getParentState,
    List<ParentPreviewForChildEntity>? allParent,
    String? getParentMessage,
  }) {
    return ParentPreviewForChildState(
      allParent: allParent ?? this.allParent,
      getParentMessage: getParentMessage ?? this.getParentMessage,
      getParentState: getParentState ?? this.getParentState,
    );
  }

  @override
  List<Object> get props => [getParentState, allParent, getParentMessage];
}
