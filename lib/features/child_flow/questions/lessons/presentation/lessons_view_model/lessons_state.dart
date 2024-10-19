part of '../../lessons.dart';

class LessonsState extends Equatable {
  final RequestStates getAllLessonsState;
  final List<LessonEntity> allLessons;
  final List<LessonWithUnitsEntity> allLessonsByUnits;
  final String errorMessage;

  final RequestStates updatePointAfterAnswerQuestionsState;
  final String updatePointAfterAnswerQuestionsErrorMessage;

  final RequestStates updatePointAfterAnswerQuestionsWithUnitState;
  final String updatePointAfterAnswerQuestionsWithUnitErrorMessage;

  const LessonsState({
    this.getAllLessonsState = RequestStates.initial,
    this.allLessons = const [],
    this.allLessonsByUnits = const [],
    this.errorMessage = 'plz Try again later',
    this.updatePointAfterAnswerQuestionsState = RequestStates.initial,
    this.updatePointAfterAnswerQuestionsErrorMessage = '',
    this.updatePointAfterAnswerQuestionsWithUnitState = RequestStates.initial,
    this.updatePointAfterAnswerQuestionsWithUnitErrorMessage = '',
  });

  LessonsState copyWith({
    RequestStates? getAllLessonsState,
    List<LessonEntity>? allLessons,
    List<LessonWithUnitsEntity>? allLessonsByUnits,
    String? errorMessage,
    RequestStates? updatePointAfterAnswerQuestionsState,
    String? updatePointAfterAnswerQuestionsErrorMessage,
    RequestStates? updatePointAfterAnswerQuestionsWithUnitState,
    String? updatePointAfterAnswerQuestionsWithUnitErrorMessage,
  }) {
    return LessonsState(
      allLessons: allLessons ?? this.allLessons,
      getAllLessonsState: getAllLessonsState ?? this.getAllLessonsState,
      errorMessage: errorMessage ?? this.errorMessage,
      allLessonsByUnits: allLessonsByUnits ?? this.allLessonsByUnits,
      updatePointAfterAnswerQuestionsState:
      updatePointAfterAnswerQuestionsState ?? RequestStates.initial,
      updatePointAfterAnswerQuestionsErrorMessage: updatePointAfterAnswerQuestionsErrorMessage ??
          this.updatePointAfterAnswerQuestionsErrorMessage,
      updatePointAfterAnswerQuestionsWithUnitState:
      updatePointAfterAnswerQuestionsWithUnitState ?? RequestStates.initial,
      updatePointAfterAnswerQuestionsWithUnitErrorMessage: updatePointAfterAnswerQuestionsWithUnitErrorMessage ??
          this.updatePointAfterAnswerQuestionsWithUnitErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        getAllLessonsState,
        allLessons,
        allLessonsByUnits,
        errorMessage,
        updatePointAfterAnswerQuestionsState,
        updatePointAfterAnswerQuestionsErrorMessage,
        updatePointAfterAnswerQuestionsWithUnitState,
        updatePointAfterAnswerQuestionsWithUnitErrorMessage
      ];
}
