part of 'institution_home_bloc.dart';

class InstitutionHomeState extends Equatable {
  final List<UserEntity> allParents;
  final RequestStates allParentsState;
  final String allParentsErrorMessage;

  const InstitutionHomeState({
    this.allParents = const [],
    this.allParentsState = RequestStates.loading,
    this.allParentsErrorMessage = '',
  });

  InstitutionHomeState copyWith({
    List<UserEntity>? allParents,
    RequestStates? allParentsState,
    String? allParentsErrorMessage,
  }) {
    return InstitutionHomeState(
      allParents: allParents ?? this.allParents,
      allParentsState: allParentsState ?? this.allParentsState,
      allParentsErrorMessage:
          allParentsErrorMessage ?? this.allParentsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        allParents,
        allParentsState,
        allParentsErrorMessage,
      ];
}
