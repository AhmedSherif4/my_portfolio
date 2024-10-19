part of '../../simulated_plans.dart';


@Injectable()
class SimulatedBloc extends Bloc<SimulatedEvent, SimulatedState> {
  final GetSimulatedPlansUseCase getSimulatedPlansUseCase;
  final GetSimulatedExamsUseCase getSimulatedExamsUseCase;
  final GetSimulatedModelAnswersUseCase getSimulatedModelAnswersUseCase;
  final SubmitExamAnswerUseCase submitExamAnswerUseCase;
  SimulatedBloc(this.getSimulatedPlansUseCase, this.getSimulatedExamsUseCase, this.getSimulatedModelAnswersUseCase, this.submitExamAnswerUseCase)
      : super(const SimulatedState()) {
    on<GetSimulatedPlansEvent>(_getSimulatedPlans);
    on<GetSimulatedExamsEvent>(_getSimulatedExams);
    on<GetSimulatedModelAnswersEvent>(_getSimulatedModelAnswers);
    on<SubmitSimulatedExamsAnswersEvent>(_submitExamAnswer);
    on<UpdateSimulatedExamsQuestionsAnswersEvent>(_updateSimulatedExamsQuestionsAnswers);
  }

  void _getSimulatedPlans(
      GetSimulatedPlansEvent event, Emitter<SimulatedState> emit) async {
    emit(state.copyWith(getSimulatedPlansState: RequestStates.loading));
    final result = await getSimulatedPlansUseCase(event.childId);
    result.fold(
      (l) => emit(state.copyWith(
          getSimulatedPlansState: RequestStates.error,
          getSimulatedPlansMessage: l.message)),
      (r) {
        emit(
        state.copyWith(
          simulatedPlans: r,
          getSimulatedPlansState: RequestStates.loaded,
        ));
      },
    );
  }


  void _getSimulatedExams(
      GetSimulatedExamsEvent event, Emitter<SimulatedState> emit) async {
    emit(state.copyWith(getSimulatedExamsState: RequestStates.loading));
    final result = await getSimulatedExamsUseCase(event.simulatedExamQuestionsAnswersInputs);
    result.fold(
          (l) => emit(state.copyWith(
              getSimulatedExamsState: RequestStates.error,
          getSimulatedExamsMessage: l.message)),
          (r) {
        emit(
            state.copyWith(
              simulatedExam: r,
              getSimulatedExamsState: RequestStates.loaded,
            ));
      },
    );
  }


  void _getSimulatedModelAnswers(
      GetSimulatedModelAnswersEvent event, Emitter<SimulatedState> emit) async {
    emit(state.copyWith(getSimulatedModelAnswersState: RequestStates.loading));
    final result = await getSimulatedModelAnswersUseCase(event.modelId);
    result.fold(
          (l) => emit(state.copyWith(
          getSimulatedModelAnswersState: RequestStates.error,
          getSimulatedModelAnswersPlansMessage: l.message)),
          (r) {
        emit(
            state.copyWith(
              simulatedModelAnswers: r,
              getSimulatedModelAnswersState: RequestStates.loaded,
            ));
      },
    );
  }

  void _submitExamAnswer(
      SubmitSimulatedExamsAnswersEvent event, Emitter<SimulatedState> emit) async {
    emit(state.copyWith(submitSimulatedQuestionsAnswersState: RequestStates.loading));
    final result = await submitExamAnswerUseCase(event.simulatedExamQuestionsAnswersInputs);
    result.fold(
          (l) => emit(state.copyWith(
          submitSimulatedQuestionsAnswersState: RequestStates.error,
          submitSimulatedQuestionsAnswersMessage: l.message)),
          (r) {
        emit(
            state.copyWith(
              submitSimulatedQuestionsAnswersMessage: r,
              submitSimulatedQuestionsAnswersState: RequestStates.loaded,
            ));
      },
    );
  }

  Future<void> _updateSimulatedExamsQuestionsAnswers(
      UpdateSimulatedExamsQuestionsAnswersEvent event,
      Emitter<SimulatedState> emit) async {
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
