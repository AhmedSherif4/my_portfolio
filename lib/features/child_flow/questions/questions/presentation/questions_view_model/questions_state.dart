part of '../../questions.dart';

class QuestionsState extends Equatable {
  final RequestStates getQuestionsStates;
  final String getQuestionsMessage;

  final QuestionsStates questionsStates;

  final RequestStates sendTheAnswerOfQuestionStates;
  final String sendTheAnswerOfQuestionErrorMessage;

  final QuestionEntity? currentQuestion;
  final int currentQuestionIndex;

  final bool isLastQuestion;


  final bool isThisAnswerSelected;
  final int selectedAnswerIndex;
  final String theSelectedAnswerIfItTextField;

  final bool isHintShown;
  final bool isDialogShown;

  final AnswerModel answerModel;

  final RequestStates reportQuestionState;
  final String reportQuestionMessage;


  const QuestionsState({
    this.getQuestionsStates = RequestStates.initial,
    this.questionsStates = QuestionsStates.initialQuestion,
    this.sendTheAnswerOfQuestionStates = RequestStates.initial,
    this.getQuestionsMessage = '',
    this.sendTheAnswerOfQuestionErrorMessage = '',
    this.currentQuestion,
    this.currentQuestionIndex = 0,
    this.isLastQuestion = false,
    this.isThisAnswerSelected = false,
    this.selectedAnswerIndex = 0,
    this.theSelectedAnswerIfItTextField = '',
    this.isHintShown = false,
    this.isDialogShown = false,
    this.answerModel = const AnswerModel(point: 0, message: ''),
    this.reportQuestionState = RequestStates.initial,
    this.reportQuestionMessage = '',
  });

  QuestionsState copyWith({
    RequestStates? getQuestionsStates,
    QuestionsStates? questionsStates,
    RequestStates? sendTheAnswerOfQuestionStates,
    String? getQuestionsMessage,
    String? sendTheAnswerOfQuestionErrorMessage,
    QuestionEntity? currentQuestion,
    int? currentQuestionIndex,
    bool? isLastQuestion,
    String? timer,
    bool? isThisAnswerSelected,
    int? selectedAnswerIndex,
    String? theSelectedAnswerIfItTextField,
    bool? isHintShown,
    bool? isDialogShown,
    AnswerModel? answerModel,
    RequestStates? reportQuestionState,
    String? reportQuestionMessage,
  }) {
    return QuestionsState(
      getQuestionsStates: getQuestionsStates ?? this.getQuestionsStates,
      questionsStates: questionsStates ?? this.questionsStates,
      sendTheAnswerOfQuestionStates:
          sendTheAnswerOfQuestionStates ?? this.sendTheAnswerOfQuestionStates,
      getQuestionsMessage: getQuestionsMessage ?? this.getQuestionsMessage,
      sendTheAnswerOfQuestionErrorMessage:
          sendTheAnswerOfQuestionErrorMessage ??
              this.sendTheAnswerOfQuestionErrorMessage,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isLastQuestion: isLastQuestion ?? this.isLastQuestion,
      isThisAnswerSelected: isThisAnswerSelected ?? this.isThisAnswerSelected,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      theSelectedAnswerIfItTextField:
          theSelectedAnswerIfItTextField ?? this.theSelectedAnswerIfItTextField,
      isHintShown: isHintShown ?? this.isHintShown,
      isDialogShown: isDialogShown ?? this.isDialogShown,
      answerModel: answerModel ?? this.answerModel,
      reportQuestionMessage:
          reportQuestionMessage ?? this.reportQuestionMessage,
      reportQuestionState: reportQuestionState ?? this.reportQuestionState,
    );
  }

  @override
  List<Object?> get props => [
        getQuestionsStates,
        getQuestionsMessage,
        questionsStates,
        sendTheAnswerOfQuestionStates,
        sendTheAnswerOfQuestionErrorMessage,
        currentQuestion,
        currentQuestionIndex,
        isLastQuestion,
        isThisAnswerSelected,
        selectedAnswerIndex,
        theSelectedAnswerIfItTextField,
        isHintShown,
        answerModel,
        reportQuestionState,
        reportQuestionMessage,
      ];
}
