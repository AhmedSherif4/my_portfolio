part of'../../random_exams.dart';


class RandomExamsState extends Equatable {
  final RequestStates getRandomExamsRequestState;
  final String getRandomExamsErrorMessage;
  final List<AllRandomExamEntityOutputs> randomExams;
  final int selectedSubject;

  final RequestStates createRandomExamsRequestState;
  final String createRandomExamsErrorMessage;

  final RequestStates repeatedRandomExamsRequestState;
  final String repeatedRandomExamsErrorMessage;

  final RequestStates addRandomExamsQuestionsAndAnswersRequestState;
  final String addRandomExamsQuestionsAndAnswersErrorMessage;
  final Map<String, String> selectedAnswers;
  final String result;
  final int selectedAnswer;

  final RandomExamEntityOutputs createdRandomExam;

  const RandomExamsState({
    this.getRandomExamsErrorMessage = '',
    this.getRandomExamsRequestState = RequestStates.initial,
    this.randomExams = const [],
    this.selectedSubject = 0,

    this.createRandomExamsErrorMessage = '',
    this.createRandomExamsRequestState = RequestStates.initial,
    this.createdRandomExam = const RandomExamEntityOutputs(
        id: 0,
        subjectId: 0,
      createdAt: "",
      updatedAt: "",
      questions: [],
      childId: 0,
      degree: 0,
       name: "",
      questionsNumber: "",
        ),


    this.repeatedRandomExamsErrorMessage = '',
    this.repeatedRandomExamsRequestState = RequestStates.initial,

    this.addRandomExamsQuestionsAndAnswersErrorMessage = '',
    this.addRandomExamsQuestionsAndAnswersRequestState = RequestStates.initial,
    this.selectedAnswers = const {},
    this.result = '',
    this.selectedAnswer = 0,
  });

  RandomExamsState copyWith({
    RequestStates? getRandomExamsRequestState,
    String? getRandomExamsErrorMessage,
    List<AllRandomExamEntityOutputs>? randomExams,
    int? selectedSubject,

    RequestStates? createRandomExamsRequestState,
    String? createRandomExamsErrorMessage,
    RandomExamEntityOutputs? createdRandomExam,
    RequestStates? repeatedRandomExamsRequestState,
    String? repeatedRandomExamsErrorMessage,

    RequestStates? addRandomExamsQuestionsAndAnswersRequestState,
    String? addRandomExamsQuestionsAndAnswersErrorMessage,
    Map<String, String>? selectedAnswers,
    String? result,
    int? selectedAnswer,
  }) {
    return RandomExamsState(
      getRandomExamsRequestState:
          getRandomExamsRequestState ?? this.getRandomExamsRequestState,
      getRandomExamsErrorMessage:
          getRandomExamsErrorMessage ?? this.getRandomExamsErrorMessage,
      randomExams: randomExams ?? this.randomExams,
      selectedSubject: selectedSubject ?? this.selectedSubject,


      createRandomExamsRequestState:
          createRandomExamsRequestState ?? this.createRandomExamsRequestState,
      createRandomExamsErrorMessage:
          createRandomExamsErrorMessage ?? this.createRandomExamsErrorMessage,
      createdRandomExam: createdRandomExam ?? this.createdRandomExam,


      repeatedRandomExamsRequestState:
          repeatedRandomExamsRequestState ?? this.repeatedRandomExamsRequestState,
      repeatedRandomExamsErrorMessage:
          repeatedRandomExamsErrorMessage ?? this.repeatedRandomExamsErrorMessage,


      addRandomExamsQuestionsAndAnswersRequestState: addRandomExamsQuestionsAndAnswersRequestState ??
          this.addRandomExamsQuestionsAndAnswersRequestState,
      addRandomExamsQuestionsAndAnswersErrorMessage: addRandomExamsQuestionsAndAnswersErrorMessage ??
          this.addRandomExamsQuestionsAndAnswersErrorMessage,


      selectedAnswers: selectedAnswers ?? this.selectedAnswers,

      result: result ?? this.result,

      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  @override
  List<Object> get props => [
        getRandomExamsRequestState,
        getRandomExamsErrorMessage,
        randomExams,
        selectedSubject,

        createRandomExamsRequestState,
        createRandomExamsErrorMessage,
        createdRandomExam,

        repeatedRandomExamsRequestState,
        repeatedRandomExamsErrorMessage,

        addRandomExamsQuestionsAndAnswersRequestState,
        addRandomExamsQuestionsAndAnswersErrorMessage,

        selectedAnswers,
        result,
        selectedAnswer,

      ];
}
