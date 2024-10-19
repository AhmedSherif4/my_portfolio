part of '../../nafees_plans.dart';

class NafeesState extends Equatable {
  final List<NafeesPlansEntity> nafeesPlans;
  final NafeesFullExamEntity nafeesExam;
  final NafeesModelAnswersEntity nafeesModelAnswers;

  final RequestStates getNafeesPlansState;
  final RequestStates getNafeesExamsState;
  final RequestStates getNafeesModelAnswersState;
  final RequestStates submitNafeesQuestionsAnswersState;

  final String getNafeesPlansMessage;
  final String getNafeesExamsMessage;
  final String getNafeesModelAnswersPlansMessage;
  final String submitNafeesQuestionsAnswersMessage;
  final int selectedAnswer;
  final Map<String, String> selectedAnswers;


  const NafeesState({
    this.selectedAnswer = 0,
    this.selectedAnswers = const {},
    this.nafeesPlans = const [],
    this.nafeesExam = const NafeesFullExamEntity(
      id: 0,
      name: '',
      nafeesExamResults: [],
      nafeesQuestionEntity: [],
      duration: 0,
      backgroundColor: "",
      textColor: "",
      piece: '',
      createdAt: '',
      questionsCount: 0,
      isSubscribe: false,
      childId: 0,
    ),
    this.nafeesModelAnswers = const NafeesModelAnswersEntity(
        childId: 0,
        id: 0,
        answers: []),
    this.getNafeesPlansState = RequestStates.initial,
    this.getNafeesExamsState = RequestStates.initial,
    this.getNafeesModelAnswersState = RequestStates.initial,
    this.submitNafeesQuestionsAnswersState = RequestStates.initial,
    this.getNafeesPlansMessage = '',
    this.getNafeesExamsMessage = '',
    this.getNafeesModelAnswersPlansMessage = '',
    this.submitNafeesQuestionsAnswersMessage = '',
  });

  NafeesState copyWith({
    List<NafeesPlansEntity>? nafeesPlans,
    NafeesFullExamEntity? nafeesExam,
    NafeesModelAnswersEntity? nafeesModelAnswers,

    RequestStates? getNafeesPlansState,
    RequestStates? getNafeesExamsState,
    RequestStates? getNafeesModelAnswersState,
    RequestStates? submitNafeesQuestionsAnswersState,

    String? getNafeesPlansMessage,
    String? getNafeesExamsMessage,
    String? getNafeesModelAnswersPlansMessage,
    String? submitNafeesQuestionsAnswersMessage,

    int? selectedAnswer,

    Map<String, String>? selectedAnswers,

  }) {
    return NafeesState(
      nafeesPlans: nafeesPlans ?? this.nafeesPlans,
      nafeesExam: nafeesExam ?? this.nafeesExam,
      nafeesModelAnswers: nafeesModelAnswers ?? this.nafeesModelAnswers,
      getNafeesPlansState: getNafeesPlansState ?? this.getNafeesPlansState,
      getNafeesExamsState: getNafeesExamsState ?? this.getNafeesExamsState,
      getNafeesModelAnswersState:
          getNafeesModelAnswersState ?? this.getNafeesModelAnswersState,
      submitNafeesQuestionsAnswersState:
          submitNafeesQuestionsAnswersState ?? this.submitNafeesQuestionsAnswersState,
      getNafeesPlansMessage: getNafeesPlansMessage ?? this.getNafeesPlansMessage,
      getNafeesExamsMessage: getNafeesExamsMessage ?? this.getNafeesExamsMessage,
      getNafeesModelAnswersPlansMessage:
          getNafeesModelAnswersPlansMessage ?? this.getNafeesModelAnswersPlansMessage,
      submitNafeesQuestionsAnswersMessage: submitNafeesQuestionsAnswersMessage ??
          this.submitNafeesQuestionsAnswersMessage,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  @override
  List<Object?> get props => [
        nafeesPlans,
        nafeesExam,
        nafeesModelAnswers,
        getNafeesPlansState,
        getNafeesExamsState,
        getNafeesModelAnswersState,
        submitNafeesQuestionsAnswersState,
        getNafeesPlansMessage,
        getNafeesExamsMessage,
        getNafeesModelAnswersPlansMessage,
        submitNafeesQuestionsAnswersMessage,
        selectedAnswer,
        selectedAnswers
      ];
}
