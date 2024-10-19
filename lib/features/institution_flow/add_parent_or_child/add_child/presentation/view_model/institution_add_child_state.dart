part of '../../add_child.dart';

class InstitutionAddChildState extends Equatable {
  final String institutionAddNewChildMessage;
  final RequestStates institutionAddNewChildStates;

  const InstitutionAddChildState({
    this.institutionAddNewChildMessage = '',
    this.institutionAddNewChildStates = RequestStates.initial,
  });

  InstitutionAddChildState copyWith({
    String? institutionAddNewChildMessage,
    RequestStates? institutionAddNewChildStates,
  }) {
    return InstitutionAddChildState(
      institutionAddNewChildMessage:
          institutionAddNewChildMessage ?? this.institutionAddNewChildMessage,
      institutionAddNewChildStates:
          institutionAddNewChildStates ?? this.institutionAddNewChildStates,
    );
  }

  @override
  List<Object> get props =>
      [institutionAddNewChildMessage, institutionAddNewChildStates];
}
