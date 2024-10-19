part of '../../child_common_questions.dart';

@Injectable()
class ChildCommonQuestionsBloc
    extends Bloc<ChildCommonQuestionsEvent, ChildCommonQuestionsState> {
  final GetAllCommonQuestionUseCase getAllCommonQuestionUse;

  ChildCommonQuestionsBloc(this.getAllCommonQuestionUse)
      : super(const ChildCommonQuestionsState()) {
    on<GetAllChildCommonQuestionsEvent>(_getAllQuestions);
  }

  _getAllQuestions(GetAllChildCommonQuestionsEvent event,
      Emitter<ChildCommonQuestionsState> emit) async {
    emit(
      state.copyWith(
        getAllQuestionsState: RequestStates.loading,
      ),
    );
    final result = await getAllCommonQuestionUse(const NoParameter());

    result.fold((failure) {
      emit(
        state.copyWith(
          getAllQuestionsState: RequestStates.error,
          getAllQuestionMessage: failure.message,
        ),
      );
    }, (allQuestions) {
      emit(state.copyWith(
        getAllQuestionsState: RequestStates.loaded,
        allQuestions: allQuestions,
      ));
    });
  }
}
