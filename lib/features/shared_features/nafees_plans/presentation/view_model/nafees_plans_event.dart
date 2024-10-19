part of '../../nafees_plans.dart';

abstract class NafeesEvent extends Equatable{
  const NafeesEvent();
}

class GetNafeesPlansEvent extends NafeesEvent{
  final int childId;
  const GetNafeesPlansEvent({required this.childId});
  @override
  List<Object?> get props => [childId];
}

class GetNafeesExamsEvent extends NafeesEvent{
  final NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs;
  const GetNafeesExamsEvent({required this.nafeesExamQuestionsAnswersInputs});
  @override
  List<Object?> get props => [nafeesExamQuestionsAnswersInputs];
}

class GetNafeesModelAnswersEvent extends NafeesEvent{
  final int modelId;
  const GetNafeesModelAnswersEvent({required this.modelId});
  @override
  List<Object?> get props => [modelId];
}

class SubmitNafeesExamsAnswersEvent extends NafeesEvent{
  final NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs;
  const SubmitNafeesExamsAnswersEvent({required this.nafeesExamQuestionsAnswersInputs});
  @override
  List<Object?> get props => [nafeesExamQuestionsAnswersInputs];
}

class UpdateNafeesExamsQuestionsAnswersEvent extends NafeesEvent {
  final String questionId;
  final String childAnswer;
  final int selectedAnswer;

  const UpdateNafeesExamsQuestionsAnswersEvent({
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
