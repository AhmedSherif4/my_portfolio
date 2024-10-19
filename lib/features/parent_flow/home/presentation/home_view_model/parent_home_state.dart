part of 'parent_home_bloc.dart';

class ParentHomeState extends Equatable {
  final List<UserEntity> allChild;
  final RequestStates allChildState;
  final String allChildErrorMessage;

  final RequestStates subjectsStates;
  final String subjectsErrorMessage;
  final List<SubjectsEntity> subjects;

  const ParentHomeState({
    this.allChild = const [],
    this.allChildState = RequestStates.loading,
    this.allChildErrorMessage = '',
    this.subjectsStates = RequestStates.initial,
    this.subjectsErrorMessage = '',
    this.subjects = const <SubjectsEntity>[],
  });

  ParentHomeState copyWith({
    List<UserEntity>? allChild,
    RequestStates? allChildState,
    String? allChildErrorMessage,
    RequestStates? subjectsStates,
    String? subjectsErrorMessage,
    List<SubjectsEntity>? subjects,
  }) {
    return ParentHomeState(
      allChild: allChild ?? this.allChild,
      allChildState: allChildState ?? this.allChildState,
      allChildErrorMessage: allChildErrorMessage ?? this.allChildErrorMessage,
      subjectsStates: subjectsStates ?? this.subjectsStates,
      subjectsErrorMessage: subjectsErrorMessage ?? this.subjectsErrorMessage,
      subjects: subjects ?? this.subjects,
    );
  }

  @override
  List<Object?> get props => [
        allChild,
        allChildState,
        allChildErrorMessage,
        subjectsStates,
        subjectsErrorMessage,
        subjects,
      ];
}
