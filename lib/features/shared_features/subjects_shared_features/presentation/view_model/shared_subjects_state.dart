
part of '../../subjects_shared_features.dart';

class SharedSubjectsState extends Equatable {
  final List<SubjectsEntity> subjects;
  final RequestStates getSubjectsState;
  final String getSubjectsStateMessage;

  final RequestStates getSubjectIdState;
  final int selectedSubject;
  final int selectedSubjectId;

  const SharedSubjectsState({
    this.subjects = const [],
    this.getSubjectsState = RequestStates.initial,
    this.getSubjectsStateMessage = '',
    this.selectedSubject = 0,
    this.selectedSubjectId = 0,
    this.getSubjectIdState = RequestStates.initial,
  });

  SharedSubjectsState copyWith({
    List<SubjectsEntity>? subjects,
    RequestStates? getSubjectsState,
    RequestStates? getSubjectIdState,
    String? getSubjectsStateMessage,
    int? selectedSubject,
    int? selectedSubjectId,
  }) {
    return SharedSubjectsState(
      subjects: subjects ?? this.subjects,
      getSubjectsState: getSubjectsState ?? this.getSubjectsState,
      getSubjectsStateMessage:
          getSubjectsStateMessage ?? this.getSubjectsStateMessage,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      getSubjectIdState: getSubjectIdState ?? this.getSubjectIdState,

    );
  }

  @override
  List<Object> get props => [
        subjects,
        getSubjectsState,
        getSubjectsStateMessage,
        selectedSubject,
        getSubjectIdState,
    selectedSubjectId
      ];
}
