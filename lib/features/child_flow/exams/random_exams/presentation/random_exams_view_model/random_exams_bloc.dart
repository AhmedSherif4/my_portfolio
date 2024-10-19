part of'../../random_exams.dart';

@Injectable()
class RandomExamsBloc extends Bloc<RandomExamsEvent, RandomExamsState> {
  final AllRandomExamsUseCase allRandomExamsUseCase;
  final CreateRandomExamsUseCase createRandomExamsUseCase;
  final RepeatRandomExamsUseCase repeatRandomExamsUseCase;
  final RandomExamsQuestionsAnswersUseCase randomExamsQuestionsAnswersUseCase;

  RandomExamsBloc(
    this.allRandomExamsUseCase,
    this.createRandomExamsUseCase,
    this.repeatRandomExamsUseCase,
    this.randomExamsQuestionsAnswersUseCase,
  ) : super(const RandomExamsState()) {
    on<GetAllRandomExamsOfThatSubject>(_getAllRandomExamsOfThatSubject);
    on<CreateRandomExamsOfThatSubject>(_createRandomExamsOfThatSubject);
    on<RepeatRandomExamsOfThatSubject>(_repeatRandomExamsOfThatSubject);
    on<AddRandomExamsQuestionsAndAnswers>(_addRandomExamsQuestionsAndAnswers);
    on<UpdateRandomExamsQuestionsAnswersEvent>(
        _updateRandomExamsQuestionsAnswersEvent);
  }

  Future<void> _getAllRandomExamsOfThatSubject(
      GetAllRandomExamsOfThatSubject event,
      Emitter<RandomExamsState> emit) async {
    emit(state.copyWith(
      getRandomExamsRequestState: RequestStates.loading,
      selectedSubject: event.selectedIndex,
    ));
    final result = await allRandomExamsUseCase(event.allRandomExamInputs,);
    result.fold(
      (l) => emit(
        state.copyWith(
          getRandomExamsRequestState: RequestStates.error,
          getRandomExamsErrorMessage: l.message,
        ),
      ),
      (exams) => emit(
        state.copyWith(
          getRandomExamsRequestState: RequestStates.loaded,
          randomExams: exams,
        ),
      ),
    );
  }

  FutureOr<void> _createRandomExamsOfThatSubject(
      CreateRandomExamsOfThatSubject event,
      Emitter<RandomExamsState> emit) async {
    emit(state.copyWith(
      createRandomExamsRequestState: RequestStates.loading,
      repeatedRandomExamsRequestState: RequestStates.initial,
    ));
    final result = await createRandomExamsUseCase(event.createRandomExamInputs);
    result.fold(
      (l) => emit(
        state.copyWith(
          createRandomExamsRequestState: RequestStates.error,
          createRandomExamsErrorMessage: l.message,
        ),
      ),
      (exams) => emit(
        state.copyWith(
          createRandomExamsRequestState: RequestStates.loaded,
          createdRandomExam: exams,
        ),
      ),
    );
  }

  Future<void> _repeatRandomExamsOfThatSubject(
      RepeatRandomExamsOfThatSubject event,
      Emitter<RandomExamsState> emit) async {
    emit(state.copyWith(
      repeatedRandomExamsRequestState: RequestStates.loading,
      createRandomExamsRequestState: RequestStates.initial,
      // selectedSubject: event.selectedIndex,
    ));
    final result = await repeatRandomExamsUseCase(event.examId);
    result.fold(
      (l) => emit(
        state.copyWith(
          repeatedRandomExamsRequestState: RequestStates.error,
          repeatedRandomExamsErrorMessage: l.message,
        ),
      ),
      (exams) => emit(
        state.copyWith(
          repeatedRandomExamsRequestState: RequestStates.loaded,
          createdRandomExam: exams,
        ),
      ),
    );
  }

  Future<void> _addRandomExamsQuestionsAndAnswers(
      AddRandomExamsQuestionsAndAnswers event,
      Emitter<RandomExamsState> emit) async {
    emit(state.copyWith(
      addRandomExamsQuestionsAndAnswersRequestState: RequestStates.loading,
      // selectedSubject: event.selectedIndex,
    ));
    final result = await randomExamsQuestionsAnswersUseCase(
        event.randomExamQuestionsAnswersInputs);
    result.fold(
      (l) => emit(
        state.copyWith(
          addRandomExamsQuestionsAndAnswersRequestState: RequestStates.error,
          addRandomExamsQuestionsAndAnswersErrorMessage: l.message,
        ),
      ),
      (exams) => emit(
        state.copyWith(
          addRandomExamsQuestionsAndAnswersRequestState: RequestStates.loaded,
          result: exams,
        ),
      ),
    );
  }

  Future<void> _updateRandomExamsQuestionsAnswersEvent(
      UpdateRandomExamsQuestionsAnswersEvent event,
      Emitter<RandomExamsState> emit) async {
    Map<String, String> updatedMap = Map.from(state.selectedAnswers);
    updatedMap.update(
      event.questionId,
      (value) => event.childAnswer,
      ifAbsent: () => event.childAnswer,
    );
    emit(state.copyWith(
      selectedAnswers: updatedMap,
      selectedAnswer: event.selectedAnswer,
    ));
  }
}
