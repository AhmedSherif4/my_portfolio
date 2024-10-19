part of '../../questions.dart';

@Injectable()
class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final GetQuestionsUseCase getQuestionsUseCase;
  final SendTheAnswerOfQuestionUseCase sendTheAnswerOfQuestionUseCase;
  final ReportQuestionUseCase reportQuestionUseCase;

  QuestionsBloc(
    this.getQuestionsUseCase,
    this.sendTheAnswerOfQuestionUseCase,
    this.reportQuestionUseCase,
  ) : super(const QuestionsState()) {
    on<GetQuestions>(_getQuestions);
    on<SelectAnswer>(_selectAnswer);
    on<CheckAnswer>(_checkAnswer);
    on<StartTimer>(_startTimer);
    on<SendTheAnswerOfQuestionToServer>(_sendTheAnswerOfQuestion);
    on<TheSelectedAnswerIsTextField>(_theSelectedAnswerIsTextField);
    on<ReportQuestionEvent>(_reportQuestion);
  }

  FutureOr<void> _reportQuestion(
      ReportQuestionEvent event, Emitter<QuestionsState> emit) async {
    emit(state.copyWith(
      reportQuestionState: RequestStates.loading,
      questionsStates: QuestionsStates.initialQuestion,
      sendTheAnswerOfQuestionStates: RequestStates.initial,
    ));
    final result = await reportQuestionUseCase(event.parameters);
    result.fold(
        (l) => emit(state.copyWith(
            reportQuestionState: RequestStates.error,
            questionsStates: QuestionsStates.initialQuestion,
            sendTheAnswerOfQuestionStates: RequestStates.initial,
            reportQuestionMessage: l.message.toString())),
        (r) => emit(state.copyWith(
              reportQuestionState: RequestStates.loaded,
              questionsStates: QuestionsStates.questionDone,
              sendTheAnswerOfQuestionStates: RequestStates.initial,
              reportQuestionMessage: r,
            )));
  }

  bool isShowMessage = false;

  List<QuestionEntity> allQuestions = [];
  int halfQuestions = -1;

  Timer? _timer;
  int _seconds = 0;
  int triesTaken = 1;
  String userName = '';

  FutureOr<void> _getQuestions(
      GetQuestions event, Emitter<QuestionsState> emit) async {
    emit(state.copyWith(getQuestionsStates: RequestStates.loading));
    final result = await getQuestionsUseCase(event.questionParameters);
    final fee = getIt<UserLocalDataSource>();
    final userData = fee.getUserData();
    result.fold(
      (failure) {
        emit(state.copyWith(
          getQuestionsStates: RequestStates.error,
          getQuestionsMessage: failure.message,
        ));
      },
      (remoteQuestions) {
        if (remoteQuestions.allQuestions.isEmpty) {
          emit(state.copyWith(getQuestionsStates: RequestStates.loaded));
        } else {
          allQuestions = remoteQuestions.allQuestions;
          halfQuestions = remoteQuestions.allQuestions.length~/2;
          userName = userData!.username;
          emit(
            state.copyWith(
              getQuestionsStates: RequestStates.loaded,
              currentQuestion: allQuestions[0],
              getQuestionsMessage: remoteQuestions.message,
              currentQuestionIndex: 0,
              isLastQuestion: allQuestions.length == 1,
            ),
          );
        }
      },
    );
  }

  //? done
  FutureOr<void> _selectAnswer(
      SelectAnswer event, Emitter<QuestionsState> emit) {
    emit(state.copyWith(
      isThisAnswerSelected: event.answerIndex == event.selectedIndex,
      selectedAnswerIndex: event.selectedIndex,
      questionsStates: QuestionsStates.initialQuestion,
      sendTheAnswerOfQuestionStates: RequestStates.initial,
      reportQuestionState: RequestStates.initial,
    ));
  }

  //!test it later
  FutureOr<void> _theSelectedAnswerIsTextField(
      TheSelectedAnswerIsTextField event, Emitter<QuestionsState> emit) {
    emit(state.copyWith(
      theSelectedAnswerIfItTextField: event.answer,
    ));
  }

  int? correctSelect;
  FutureOr<void> _checkAnswer(CheckAnswer event, Emitter<QuestionsState> emit) {
    correctSelect =
        int.tryParse(allQuestions[state.currentQuestionIndex].correctSelect);

    bool isCorrect;

    if (correctSelect != null) {
      isCorrect = state.selectedAnswerIndex == correctSelect;
    } else {
      isCorrect = state.theSelectedAnswerIfItTextField ==
          allQuestions[state.currentQuestionIndex].correctSelect;
    }

    if (isCorrect) {
      if (triesTaken == 1) {
        //totalPoints += allQuestions[state.currentQuestionIndex].point;
        emit(state.copyWith(
          questionsStates: QuestionsStates.answeredFromFirstTry,
          sendTheAnswerOfQuestionStates: RequestStates.initial,
          reportQuestionState: RequestStates.initial,
        ));
      } else {
        // totalPoints += allQuestions[state.currentQuestionIndex].point;
        emit(state.copyWith(
          questionsStates: QuestionsStates.questionDone,
          sendTheAnswerOfQuestionStates: RequestStates.initial,
          reportQuestionState: RequestStates.initial,
        ));
      }
    } else {
      if (triesTaken <= 4) {
        triesTaken += 1;
        if (state.currentQuestion?.select3Text != null &&
            state.currentQuestion?.select4Text != null &&
            triesTaken == 3) {
          emit(state.copyWith(
            questionsStates: QuestionsStates.showRetryDialog,
            isDialogShown: true,
            sendTheAnswerOfQuestionStates: RequestStates.initial,
            reportQuestionState: RequestStates.initial,
          ));
        }

        if (state.currentQuestion?.select3Text == null &&
            state.currentQuestion?.select4Text == null &&
            triesTaken == 2) {
          emit(state.copyWith(
            sendTheAnswerOfQuestionStates: RequestStates.initial,
            reportQuestionState: RequestStates.initial,
          ));
        }
        if (triesTaken == 4) {
          emit(state.copyWith(
            isHintShown: true,
            sendTheAnswerOfQuestionStates: RequestStates.initial,
            reportQuestionState: RequestStates.initial,
          ));
        }
        emit(state.copyWith(
          questionsStates: QuestionsStates.wrongAnswer,
          sendTheAnswerOfQuestionStates: RequestStates.initial,
          reportQuestionState: RequestStates.initial,
        ));
      // }
      // else if(halfQuestions==state.currentQuestionIndex){
      //   emit(state.copyWith(
      //     questionsStates: QuestionsStates.halfQuestionDone,
      //     sendTheAnswerOfQuestionStates: RequestStates.initial,
      //     reportQuestionState: RequestStates.initial,
      //   ));
      }else {
        emit(state.copyWith(
          questionsStates: QuestionsStates.questionDone,
          sendTheAnswerOfQuestionStates: RequestStates.initial,
          reportQuestionState: RequestStates.initial,
        ));
      }
    }
    //totalPoints.log();
  }

  FutureOr<void> _sendTheAnswerOfQuestion(SendTheAnswerOfQuestionToServer event,
      Emitter<QuestionsState> emit) async {
    emit(
      state.copyWith(
        sendTheAnswerOfQuestionStates: RequestStates.loading,
        reportQuestionState: RequestStates.initial,
        questionsStates: QuestionsStates.initialQuestion,
      ),
    );

    final result =
        await sendTheAnswerOfQuestionUseCase(SendTheAnswerOfQuestionParameter(
      systemId: event.parameter.systemId,
      pathId: event.parameter.pathId,
      questionId: state.currentQuestion!.id,
      answerDuration: _seconds - AppConstants.durationOfConfetti.inSeconds,
      triesTaken: triesTaken,
      isLast: event.parameter.isLast,
      stageId: event.parameter.stageId,
      classroomId: event.parameter.classroomId,
      termId: event.parameter.termId,
      subjectId: event.parameter.subjectId,
      levelId: event.parameter.levelId,
      groupId: event.parameter.groupId,
      isGeneralQuestion: event.parameter.isGeneralQuestion,
      lessonId: event.parameter.lessonId,
          isFromNafees: event.parameter.isFromNafees,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(
          sendTheAnswerOfQuestionStates: RequestStates.error,
          reportQuestionState: RequestStates.initial,
          sendTheAnswerOfQuestionErrorMessage: failure.message,
          questionsStates: QuestionsStates.initialQuestion,
        ));
      },
      (totalPoints) {
        _seconds = 0;
        triesTaken = 1;
        if (!state.isLastQuestion) {
          emit(state.copyWith(
            sendTheAnswerOfQuestionStates: RequestStates.loaded,
            reportQuestionState: RequestStates.initial,
            questionsStates: QuestionsStates.initialQuestion,
            currentQuestionIndex: state.currentQuestionIndex + 1,
            currentQuestion: allQuestions[state.currentQuestionIndex + 1],
            isLastQuestion: state.currentQuestionIndex + 1 == allQuestions.length - 1,
            isThisAnswerSelected: false,
            selectedAnswerIndex: 0,
            isHintShown: false,
          ));
        } else {
          _timer?.cancel();
          emit(state.copyWith(
            questionsStates: QuestionsStates.finishedAllQuestions,
            sendTheAnswerOfQuestionStates: RequestStates.loaded,
            reportQuestionState: RequestStates.initial,
            answerModel: totalPoints,
          ));
        }
      },
    );
  }

  FutureOr<void> _startTimer(
      StartTimer event, Emitter<QuestionsState> emit) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      // _formattedDuration = _formatDuration(_seconds);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
