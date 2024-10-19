part of '../../simulated_plans.dart';

class SimulatedState extends Equatable {
  final List<SimulatedCategoriesEntity> simulatedPlans;
  final SimulatedFullExamEntity simulatedExam;
  final SimulatedModelAnswersEntity simulatedModelAnswers;

  final RequestStates getSimulatedPlansState;
  final RequestStates getSimulatedExamsState;
  final RequestStates getSimulatedModelAnswersState;
  final RequestStates submitSimulatedQuestionsAnswersState;

  final String getSimulatedPlansMessage;
  final String getSimulatedExamsMessage;
  final String getSimulatedModelAnswersPlansMessage;
  final String submitSimulatedQuestionsAnswersMessage;
  final int selectedAnswer;
  final Map<String, String> selectedAnswers;


  const SimulatedState({
    this.selectedAnswer = 0,
    this.selectedAnswers = const {},
    this.simulatedPlans = const [],
    this.simulatedExam = const SimulatedFullExamEntity(
      id: 0,
      name: '',
      simulatedExamResults: [],
      simulatedQuestionEntity: [],
      duration: 0,
      backgroundColor: "",
      textColor: "",
      piece: '',
      createdAt: '',
      questionsCount: 0,
      isSubscribe: false,
      childId: 0,
    ),
    this.simulatedModelAnswers = const SimulatedModelAnswersEntity(
        childId: 0,
        id: 0,
        answers: []),
    this.getSimulatedPlansState = RequestStates.initial,
    this.getSimulatedExamsState = RequestStates.initial,
    this.getSimulatedModelAnswersState = RequestStates.initial,
    this.submitSimulatedQuestionsAnswersState = RequestStates.initial,
    this.getSimulatedPlansMessage = '',
    this.getSimulatedExamsMessage = '',
    this.getSimulatedModelAnswersPlansMessage = '',
    this.submitSimulatedQuestionsAnswersMessage = '',
  });

  SimulatedState copyWith({
    List<SimulatedCategoriesEntity>? simulatedPlans,
    SimulatedFullExamEntity? simulatedExam,
    SimulatedModelAnswersEntity? simulatedModelAnswers,

    RequestStates? getSimulatedPlansState,
    RequestStates? getSimulatedExamsState,
    RequestStates? getSimulatedModelAnswersState,
    RequestStates? submitSimulatedQuestionsAnswersState,

    String? getSimulatedPlansMessage,
    String? getSimulatedExamsMessage,
    String? getSimulatedModelAnswersPlansMessage,
    String? submitSimulatedQuestionsAnswersMessage,

    int? selectedAnswer,

    Map<String, String>? selectedAnswers,

  }) {
    return SimulatedState(
      simulatedPlans: simulatedPlans ?? this.simulatedPlans,
      simulatedExam: simulatedExam ?? this.simulatedExam,
      simulatedModelAnswers: simulatedModelAnswers ?? this.simulatedModelAnswers,
      getSimulatedPlansState: getSimulatedPlansState ?? this.getSimulatedPlansState,
      getSimulatedExamsState: getSimulatedExamsState ?? this.getSimulatedExamsState,
      getSimulatedModelAnswersState:
          getSimulatedModelAnswersState ?? this.getSimulatedModelAnswersState,
      submitSimulatedQuestionsAnswersState:
          submitSimulatedQuestionsAnswersState ?? this.submitSimulatedQuestionsAnswersState,
      getSimulatedPlansMessage: getSimulatedPlansMessage ?? this.getSimulatedPlansMessage,
      getSimulatedExamsMessage: getSimulatedExamsMessage ?? this.getSimulatedExamsMessage,
      getSimulatedModelAnswersPlansMessage:
          getSimulatedModelAnswersPlansMessage ?? this.getSimulatedModelAnswersPlansMessage,
      submitSimulatedQuestionsAnswersMessage: submitSimulatedQuestionsAnswersMessage ??
          this.submitSimulatedQuestionsAnswersMessage,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  @override
  List<Object?> get props => [
        simulatedPlans,
        simulatedExam,
        simulatedModelAnswers,
        getSimulatedPlansState,
        getSimulatedExamsState,
        getSimulatedModelAnswersState,
        submitSimulatedQuestionsAnswersState,
        getSimulatedPlansMessage,
        getSimulatedExamsMessage,
        getSimulatedModelAnswersPlansMessage,
        submitSimulatedQuestionsAnswersMessage,
        selectedAnswer,
        selectedAnswers
      ];
}
