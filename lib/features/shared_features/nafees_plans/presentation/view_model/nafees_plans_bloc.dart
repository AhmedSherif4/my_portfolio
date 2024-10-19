part of '../../nafees_plans.dart';


@Injectable()
class NafeesBloc extends Bloc<NafeesEvent, NafeesState> {
  final GetNafeesPlansUseCase getNafeesPlansUseCase;
  final GetNafeesExamsUseCase getNafeesExamsUseCase;
  final GetNafeesModelAnswersUseCase getNafeesModelAnswersUseCase;
  final SubmitExamAnswerUseCase submitExamAnswerUseCase;
  NafeesBloc(this.getNafeesPlansUseCase, this.getNafeesExamsUseCase, this.getNafeesModelAnswersUseCase, this.submitExamAnswerUseCase)
      : super(const NafeesState()) {
    on<GetNafeesPlansEvent>(_getNafeesPlans);
    on<GetNafeesExamsEvent>(_getNafeesExams);
    on<GetNafeesModelAnswersEvent>(_getNafeesModelAnswers);
    on<SubmitNafeesExamsAnswersEvent>(_submitExamAnswer);
    on<UpdateNafeesExamsQuestionsAnswersEvent>(_updateNafeesExamsQuestionsAnswers);
  }

  void _getNafeesPlans(
      GetNafeesPlansEvent event, Emitter<NafeesState> emit) async {
    emit(state.copyWith(getNafeesPlansState: RequestStates.loading));
    final result = await getNafeesPlansUseCase(event.childId);
    result.fold(
      (l) => emit(state.copyWith(
          getNafeesPlansState: RequestStates.error,
          getNafeesPlansMessage: l.message)),
      (r) {
        emit(
        state.copyWith(
          nafeesPlans: r,
          getNafeesPlansState: RequestStates.loaded,
        ));
      },
    );
  }


  void _getNafeesExams(
      GetNafeesExamsEvent event, Emitter<NafeesState> emit) async {
    emit(state.copyWith(getNafeesExamsState: RequestStates.loading));
    final result = await getNafeesExamsUseCase(event.nafeesExamQuestionsAnswersInputs);
    result.fold(
          (l) => emit(state.copyWith(
              getNafeesExamsState: RequestStates.error,
          getNafeesExamsMessage: l.message)),
          (r) {
        emit(
            state.copyWith(
              nafeesExam: r,
              getNafeesExamsState: RequestStates.loaded,
            ));
      },
    );
  }


  void _getNafeesModelAnswers(
      GetNafeesModelAnswersEvent event, Emitter<NafeesState> emit) async {
    emit(state.copyWith(getNafeesModelAnswersState: RequestStates.loading));
    final result = await getNafeesModelAnswersUseCase(event.modelId);
    result.fold(
          (l) => emit(state.copyWith(
          getNafeesModelAnswersState: RequestStates.error,
          getNafeesModelAnswersPlansMessage: l.message)),
          (r) {
        emit(
            state.copyWith(
              nafeesModelAnswers: r,
              getNafeesModelAnswersState: RequestStates.loaded,
            ));
      },
    );
  }

  void _submitExamAnswer(
      SubmitNafeesExamsAnswersEvent event, Emitter<NafeesState> emit) async {
    emit(state.copyWith(submitNafeesQuestionsAnswersState: RequestStates.loading));
    final result = await submitExamAnswerUseCase(event.nafeesExamQuestionsAnswersInputs);
    result.fold(
          (l) => emit(state.copyWith(
          submitNafeesQuestionsAnswersState: RequestStates.error,
          submitNafeesQuestionsAnswersMessage: l.message)),
          (r) {
        emit(
            state.copyWith(
              submitNafeesQuestionsAnswersMessage: r,
              submitNafeesQuestionsAnswersState: RequestStates.loaded,
            ));
      },
    );
  }

  Future<void> _updateNafeesExamsQuestionsAnswers(
      UpdateNafeesExamsQuestionsAnswersEvent event,
      Emitter<NafeesState> emit) async {
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
