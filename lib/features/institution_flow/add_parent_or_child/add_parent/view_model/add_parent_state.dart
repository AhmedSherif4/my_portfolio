part of 'add_parent_bloc.dart';

class AddParentState extends Equatable {
  final String addNewParentMessage;
  final RequestStates addNewParentStates;

  const AddParentState({
    this.addNewParentMessage = '',
    this.addNewParentStates = RequestStates.initial,
  });

  AddParentState copyWith({
    String? addNewParentMessage,
    RequestStates? addNewParentStates,
  }) {
    return AddParentState(
      addNewParentMessage: addNewParentMessage ?? this.addNewParentMessage,
      addNewParentStates: addNewParentStates ?? this.addNewParentStates,
    );
  }

  @override
  List<Object> get props => [addNewParentMessage, addNewParentStates];
}
