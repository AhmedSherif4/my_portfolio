part of '../../exams.dart';

class ExamsState extends Equatable {
  final RequestStates getExamsRequestState;
  final String getExamsErrorMessage;
  final List<ExamEntity> exams;
  final int selectedSubject;

  const ExamsState({
    this.getExamsErrorMessage = '',
    this.getExamsRequestState = RequestStates.initial,
    this.exams = const [],
    this.selectedSubject = 0,
  });

  ExamsState copyWith({
    RequestStates? getExamsRequestState,
    String? getExamsErrorMessage,
    List<ExamEntity>? exams,
    int? selectedSubject,
  }) {
    return ExamsState(
      getExamsRequestState: getExamsRequestState ?? this.getExamsRequestState,
      getExamsErrorMessage: getExamsErrorMessage ?? this.getExamsErrorMessage,
      exams: exams ?? this.exams,
      selectedSubject: selectedSubject ?? this.selectedSubject,
    );
  }

  @override
  List<Object> get props => [
        getExamsRequestState,
        getExamsErrorMessage,
        exams,
        selectedSubject,
      ];
}
