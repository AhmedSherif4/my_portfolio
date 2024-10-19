part of '../../../statics.dart';

abstract class SkillStaticsEvent extends Equatable {
  const SkillStaticsEvent();
}

class GetFailsSkillsEvent extends SkillStaticsEvent {
  final GetFailsSkillsWithQuestionsParameters failsSkillsParm;

  const GetFailsSkillsEvent({required this.failsSkillsParm});

  @override
  List<Object?> get props => [failsSkillsParm];
}


class SelectAnswerForSkills extends SkillStaticsEvent {
  final int answerIndex;
  final int selectedIndex;
  final QuestionEntity? currentQuestion;

  const SelectAnswerForSkills( {required this.answerIndex, required this.selectedIndex,this.currentQuestion,});

  @override
  List<Object> get props => [answerIndex, selectedIndex];
}

class CheckAnswerForSkills extends SkillStaticsEvent {
  final QuestionEntity currentQuestion;
  const CheckAnswerForSkills(this.currentQuestion);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SendTheAnswerOfQuestionToServerFromSkills extends SkillStaticsEvent {
  final QuestionEntity currentQuestion;
  final SendTheAnswerOfQuestionParameter parameter;

  const SendTheAnswerOfQuestionToServerFromSkills(this.parameter, this.currentQuestion);

  @override
  List<Object> get props => [parameter];
}
