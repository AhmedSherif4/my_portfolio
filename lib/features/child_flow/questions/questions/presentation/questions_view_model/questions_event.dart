// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../questions.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class GetQuestions extends QuestionsEvent {
  final ParameterGoToQuestions questionParameters;

  const GetQuestions(this.questionParameters);

  @override
  List<Object> get props => [questionParameters];
}



class SelectAnswer extends QuestionsEvent {
  final int answerIndex;
  final int selectedIndex;

  const SelectAnswer({required this.answerIndex, required this.selectedIndex});

  @override
  List<Object> get props => [answerIndex, selectedIndex];
}

class CheckAnswer extends QuestionsEvent {
  const CheckAnswer();
}

class StartTimer extends QuestionsEvent {
  const StartTimer();
}

class SendTheAnswerOfQuestionToServer extends QuestionsEvent {
  final SendTheAnswerOfQuestionParameter parameter;

  const SendTheAnswerOfQuestionToServer(this.parameter);

  @override
  List<Object> get props => [parameter];
}

class TheSelectedAnswerIsTextField extends QuestionsEvent {
  final String answer;

  const TheSelectedAnswerIsTextField({required this.answer});

  @override
  List<Object> get props => [answer];
}

class ReportQuestionEvent extends QuestionsEvent {
  final ReportQuestionParameters parameters;

  const ReportQuestionEvent({required this.parameters});

  @override
  List<Object> get props => [parameters];
}
