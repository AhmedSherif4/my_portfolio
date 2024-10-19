part of '../../levels.dart';

abstract class LevelsEvent extends Equatable {
  const LevelsEvent();

  @override
  List<Object> get props => [];
}

class GetAllLevels extends LevelsEvent {
  final ParameterGoToQuestions parameters;

  const GetAllLevels(this.parameters);

  @override
  List<Object> get props => [parameters];
}
