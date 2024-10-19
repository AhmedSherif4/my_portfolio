part of '../../simulated_plans.dart';

abstract class SimulatedEvent extends Equatable{
  const SimulatedEvent();
}

class GetSimulatedPlansEvent extends SimulatedEvent{
  final int childId;
  const GetSimulatedPlansEvent({required this.childId});
  @override
  List<Object?> get props => [childId];
}

class GetSimulatedExamsEvent extends SimulatedEvent{
  final SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs;
  const GetSimulatedExamsEvent({required this.simulatedExamQuestionsAnswersInputs});
  @override
  List<Object?> get props => [simulatedExamQuestionsAnswersInputs];
}

class GetSimulatedModelAnswersEvent extends SimulatedEvent{
  final int modelId;
  const GetSimulatedModelAnswersEvent({required this.modelId});
  @override
  List<Object?> get props => [modelId];
}

class SubmitSimulatedExamsAnswersEvent extends SimulatedEvent{
  final SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs;
  const SubmitSimulatedExamsAnswersEvent({required this.simulatedExamQuestionsAnswersInputs});
  @override
  List<Object?> get props => [simulatedExamQuestionsAnswersInputs];
}

class UpdateSimulatedExamsQuestionsAnswersEvent extends SimulatedEvent {
  final String questionId;
  final String childAnswer;
  final int selectedAnswer;

  const UpdateSimulatedExamsQuestionsAnswersEvent({
    required this.questionId,
    required this.childAnswer,
    required this.selectedAnswer,
  });
  @override
  List<Object?> get props => [
    questionId,
    childAnswer,
    selectedAnswer,
  ];
}
