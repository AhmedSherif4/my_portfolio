part of '../../home.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GotPuzzleAndAdviceEvent extends HomeEvent {
  const GotPuzzleAndAdviceEvent();
}

class GotSubjectsEvent extends HomeEvent {
  final ParameterGoToQuestions subjectsParameters;

  const GotSubjectsEvent(this.subjectsParameters);

  @override
  List<Object> get props => [subjectsParameters];
}


class CheckPuzzleEvent extends HomeEvent {
  const CheckPuzzleEvent();
}
