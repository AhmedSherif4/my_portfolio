part of '../../../statics.dart';

class SkillStaticsState extends Equatable {
  final RequestStates failsSkillsStates;
  final String failsSkillsErrorMessage;
  final List<FailsSkillsForLessonsModel> failsSkills;
  final QuestionsStates questionsStates;

  final RequestStates sendTheAnswerOfQuestionStates;
  final String sendTheAnswerOfQuestionErrorMessage;

  final RequestStates failsSkillsQuestionsStates;
  final String failsSkillsQuestionsErrorMessage;
  final bool isHintShown;
  final bool isDialogShown;
  final bool isThisAnswerSelected;
  final int selectedAnswerIndex;
  const SkillStaticsState(
      {
        this.failsSkillsQuestionsStates=RequestStates.initial,
        this.failsSkillsQuestionsErrorMessage="",

        this.failsSkillsStates = RequestStates.initial,
        this.failsSkillsErrorMessage = '',
        this.failsSkills = const <FailsSkillsForLessonsModel>[],
        this.isThisAnswerSelected = false,
        this.selectedAnswerIndex = 0,
        this.isHintShown = false,
        this.isDialogShown = false,
        this.questionsStates = QuestionsStates.initialQuestion,
        this.sendTheAnswerOfQuestionStates = RequestStates.initial,
        this.sendTheAnswerOfQuestionErrorMessage = '',
      });

  SkillStaticsState copyWith({
    RequestStates? failsSkillsStates,
    String? failsSkillsErrorMessage,
    List<FailsSkillsForLessonsModel>? failsSkills,
    RequestStates? failsSkillsQuestionsStates,
    String? failsSkillsQuestionsErrorMessage,
    bool? isThisAnswerSelected,
    int? selectedAnswerIndex,
    bool? isHintShown,
    bool? isDialogShown,
    QuestionsStates? questionsStates,
     RequestStates? sendTheAnswerOfQuestionStates,
     String? sendTheAnswerOfQuestionErrorMessage,
  }) {
    return SkillStaticsState(
      failsSkillsStates: failsSkillsStates ?? this.failsSkillsStates,
      failsSkillsErrorMessage:
      failsSkillsErrorMessage ?? this.failsSkillsErrorMessage,
      failsSkills: failsSkills ?? this.failsSkills,
      failsSkillsQuestionsStates: failsSkillsQuestionsStates ?? this.failsSkillsQuestionsStates,
      failsSkillsQuestionsErrorMessage: failsSkillsQuestionsErrorMessage ?? this.failsSkillsQuestionsErrorMessage,
      isThisAnswerSelected: isThisAnswerSelected ?? this.isThisAnswerSelected,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      isHintShown: isHintShown ?? this.isHintShown,
      isDialogShown: isDialogShown ?? this.isDialogShown,
      questionsStates: questionsStates ?? this.questionsStates,
      sendTheAnswerOfQuestionStates: sendTheAnswerOfQuestionStates ?? this.sendTheAnswerOfQuestionStates,
      sendTheAnswerOfQuestionErrorMessage: sendTheAnswerOfQuestionErrorMessage ?? this.sendTheAnswerOfQuestionErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    failsSkillsStates,
    failsSkillsErrorMessage,
    failsSkills,
    failsSkillsQuestionsStates,
    failsSkillsQuestionsErrorMessage,
    isThisAnswerSelected,
    selectedAnswerIndex,
    isHintShown,
    isDialogShown,
    questionsStates,
    sendTheAnswerOfQuestionStates,
    sendTheAnswerOfQuestionErrorMessage
  ];
}