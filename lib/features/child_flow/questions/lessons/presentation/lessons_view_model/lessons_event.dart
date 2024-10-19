part of '../../lessons.dart';

abstract class LessonsEvent extends Equatable {
  const LessonsEvent();

  @override
  List<Object> get props => [];
}

class GetAllLessonsEvent extends LessonsEvent {
  final ParameterGoToQuestions lessonParameters;

  const GetAllLessonsEvent(this.lessonParameters);

  @override
  List<Object> get props => [lessonParameters];
}

class GetAllLessonsByUnitsEvent extends LessonsEvent {
  final ParameterGoToQuestions lessonParameters;

  const GetAllLessonsByUnitsEvent(this.lessonParameters);

  @override
  List<Object> get props => [lessonParameters];
}

class UpdatePointAfterAnswerQuestionsEvent extends LessonsEvent {
  final ParameterUpdatePoints lessonParameters;

  const UpdatePointAfterAnswerQuestionsEvent({required this.lessonParameters});

  @override
  List<Object> get props => [lessonParameters];
}

class UpdatePointAfterAnswerQuestionsEventWithUnit extends LessonsEvent {
  final ParameterUpdatePoints lessonParameters;

  const UpdatePointAfterAnswerQuestionsEventWithUnit({required this.lessonParameters});

  @override
  List<Object> get props => [lessonParameters];
}