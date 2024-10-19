part of '../../../statics.dart';



@Injectable()
class SkillStaticsBloc extends Bloc<SkillStaticsEvent, SkillStaticsState> {
  final GetFailSkillsStaticsUseCase failSkillsStaticsUseCase;
  final GetFailSkillsQuestionsUseCase getFailSkillsQuestionsUseCase;
  final SendTheAnswerOfQuestionUseCase sendTheAnswerOfQuestionUseCase;

  int? correctSelect;

  SkillStaticsBloc(
    this.failSkillsStaticsUseCase,
    this.getFailSkillsQuestionsUseCase,
    this.sendTheAnswerOfQuestionUseCase,
  ) : super(const SkillStaticsState()) {
    on<GetFailsSkillsEvent>((GetFailsSkillsEvent event, emit) async {
      emit(
        state.copyWith(
          failsSkillsStates: RequestStates.loading,
        ),
      );
      final result = await failSkillsStaticsUseCase(event.failsSkillsParm);

      result.fold((failure) {
        emit(
          state.copyWith(
            failsSkillsStates: RequestStates.error,
            failsSkillsErrorMessage: failure.message,
          ),
        );
      }, (failsSkills) {
        emit(state.copyWith(
          failsSkillsStates: RequestStates.loaded,
          failsSkills: failsSkills,
        ));
      });
    });


    on<SelectAnswerForSkills>((SelectAnswerForSkills event, emit) async {

      emit(state.copyWith(
        isThisAnswerSelected: event.answerIndex == event.selectedIndex,
        selectedAnswerIndex: event.selectedIndex,
        questionsStates: QuestionsStates.initialQuestion,
        sendTheAnswerOfQuestionStates: RequestStates.initial,
      ));
    });

    on<CheckAnswerForSkills>((CheckAnswerForSkills event, emit) async {


      bool isCorrect = false;
      correctSelect = int.tryParse(event.currentQuestion.correctSelect);
      if (correctSelect != null) {
        isCorrect = state.selectedAnswerIndex == correctSelect;
      }

      if (isCorrect) {
          emit(state.copyWith(
            questionsStates: QuestionsStates.questionDone,
          ));
        } else {
          emit(state.copyWith(
            questionsStates: QuestionsStates.wrongAnswer,
          ));
        }

    });

    on<SendTheAnswerOfQuestionToServerFromSkills>(
        (SendTheAnswerOfQuestionToServerFromSkills event, emit) async {
      emit(
        state.copyWith(
          sendTheAnswerOfQuestionStates: RequestStates.loading,
          questionsStates: QuestionsStates.initialQuestion,
          selectedAnswerIndex: -1,
        ),
      );
      correctSelect = -1;

      final result =
          await sendTheAnswerOfQuestionUseCase(SendTheAnswerOfQuestionParameter(
        questionId: event.currentQuestion.id,
        answerDuration: 2,
        triesTaken: 1,
        isLast: true,
        stageId: 0,
        classroomId: 0,
        termId: 0,
        subjectId: 0,
        levelId: 0,
        groupId: 0,
        isGeneralQuestion: false,
        lessonId: 0,
        systemId: 0,
        pathId: 0,
        isFromNafees: false,
      ));

      result.fold((failure) {
        emit(state.copyWith(
          sendTheAnswerOfQuestionStates: RequestStates.error,
          sendTheAnswerOfQuestionErrorMessage: failure.message,
          questionsStates: QuestionsStates.initialQuestion,
        ));
      }, (totalPoints) {
        emit(state.copyWith(
          questionsStates: QuestionsStates.initialQuestion,
          sendTheAnswerOfQuestionStates: RequestStates.loaded,

        ));
      });
    });
  }
}
