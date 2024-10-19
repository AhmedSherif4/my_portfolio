part of '../../questions.dart';

class
QuestionsScreen extends StatefulWidget {
  final DataToGoQuestions data;

  const QuestionsScreen({
    super.key,
    required this.data,
  });

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final TextEditingController reportController = TextEditingController();
  late String reportMessage;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _formKey = GlobalKey<FormState>();
  final _answerController = TextEditingController();

  Future<void> _initScreenProtector() async {
    await ScreenProtector.preventScreenshotOn();
    if (Platform.isAndroid) {
      await ScreenProtector.protectDataLeakageOn();
    } else {
      await ScreenProtector.protectDataLeakageWithBlur();
    }
  }


  @override
  Widget build(BuildContext context) {

    return BlocListener<QuestionsBloc, QuestionsState>(
      listener: (context, state) async {
        switch (state.reportQuestionState) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            showSnackBar(
                description: state.reportQuestionMessage,
                state: ToastStates.congrats,
                context: context);
          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
                description: state.reportQuestionMessage,
                state: ToastStates.error,
                context: context);
          default:
        }
        switch (state.sendTheAnswerOfQuestionStates) {
          case RequestStates.error:
            Navigator.of(context).pop();
            showSnackBar(
              description: state.sendTheAnswerOfQuestionErrorMessage,
              state: ToastStates.error,
              context: context,
            );
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.of(context).pop();
          // if(BlocProvider.of<QuestionsBloc>(context).halfQuestions
          //     == state.currentQuestionIndex){
          //
          //
          //   showDialog(
          //           context: context,
          //           builder: (context) {
          //             return const BasicDialogContent(
          //               basicDialogStatus: BasicDialogStatus.halfSuccess,
          //             );
          //           });
          // }
          default:
        }

        switch (state.questionsStates) {
          // case QuestionsStates.showRetryDialog:
          //   showDialog(
          //       context: context,
          //       builder: (ctx) {
          //         return const BasicDialogContent(
          //           basicDialogStatus: BasicDialogStatus.failed,
          //         );
          //       });
          // case QuestionsStates.halfQuestionDone:
          //   showDialog(
          //       context: context,
          //       builder: (ctx) {
          //         return const BasicDialogContent(
          //           basicDialogStatus: BasicDialogStatus.retry,
          //         );
          //       });
          case QuestionsStates.answeredFromFirstTry:
            _audioPlayer.play(AssetSource('audio/SuccessfulAnswer.wav'));
            _confettiControllerBottom.play();
            _confettiControllerLeft.play();
            _confettiControllerRight.play();

            Future.delayed(
              const Duration(seconds: 1),
              () async {
                if (context.mounted){
                  context.read<QuestionsBloc>().add(
                      SendTheAnswerOfQuestionToServer(
                        SendTheAnswerOfQuestionParameter(
                          systemId: widget.data.systemId,
                          pathId: widget.data.pathId,
                          stageId: widget.data.stageId,
                          classroomId: widget.data.classRoomId,
                          termId: widget.data.termId,
                          subjectId: widget.data.subjectId,
                          levelId: widget.data.levelId,
                          groupId: widget.data.groupId,
                          isGeneralQuestion: widget.data.isGeneralQuestions,
                          lessonId: widget.data.lessonId,
                          isLast: state.isLastQuestion,
                          questionId: state.currentQuestion!.id,
                          answerDuration:
                              context.read<QuestionsBloc>()._seconds,
                          triesTaken: context.read<QuestionsBloc>().triesTaken,
                          isFromNafees: widget.data.isFromNafees,
                        ),
                      ),
                    );}
              },
            );
          case QuestionsStates.questionDone:
            _audioPlayer.play(AssetSource('audio/SuccessfulAnswer.wav'));

            BlocProvider.of<QuestionsBloc>(context).add(
              SendTheAnswerOfQuestionToServer(
                SendTheAnswerOfQuestionParameter(
                  systemId: widget.data.systemId,
                  pathId: widget.data.pathId,
                  stageId: widget.data.stageId,
                  classroomId: widget.data.classRoomId,
                  termId: widget.data.termId,
                  subjectId: widget.data.subjectId,
                  levelId: widget.data.levelId,
                  groupId: widget.data.groupId,
                  isGeneralQuestion: widget.data.isGeneralQuestions,
                  lessonId: widget.data.lessonId,
                  isLast: state.isLastQuestion,
                  questionId: state.currentQuestion!.id,
                  answerDuration: context.read<QuestionsBloc>()._seconds,
                  triesTaken: context.read<QuestionsBloc>().triesTaken,
                  isFromNafees: widget.data.isFromNafees,
                ),
              ),
            );

          case QuestionsStates.finishedAllQuestions:
            _audioPlayer.play(AssetSource('audio/SuccessfulAnswer.wav'));
            // if(state.answerModel.point != -1){
            //   showDialog(
            //       context: context,
            //       builder: (ctx) {
            //         return const BasicDialogContent(
            //           basicDialogStatus: BasicDialogStatus.success,
            //         );
            //       });
            // }else{
            //   showDialog(
            //       context: context,
            //       builder: (ctx) {
            //         return const BasicDialogContent(
            //           basicDialogStatus: BasicDialogStatus.failed,
            //         );
            //       });
            // }

            showSnackBar(
              description: state.answerModel.point != -1
                  ? ' أحسنت لقد أنهيت هذه الأسئلة بنجاح\nالنقاط التي حصلت عليها هي( ${state.answerModel.point} ) '
                  : state.answerModel.message,
              state: ToastStates.congrats,
              context: context,
            );

            _questionNavigationController();

          case QuestionsStates.wrongAnswer:
            _audioPlayer.play(AssetSource('audio/WrongAnswer.wav'));
            showSnackBar(
              bottomPadding: AppReference.deviceHeight(context) * 0.11,
              description: AppStrings.answerIsWrongTryAgain,
              state: ToastStates.error,
              context: context,
            );

            // Future.delayed(const Duration(seconds: 1), () {
            //   BlocProvider.of<QuestionsBloc>(context).emit(state.copyWith(
            //       questionsStates: QuestionsStates.initialQuestion));
            // });
          default:
        }
      },
      child: PopScope(
        canPop: widget.data.isFromNafees ? true : false,
        onPopInvoked: (value) async {
          if (!value) {
            if (context.read<QuestionsBloc>().allQuestions.isEmpty) {
              _questionNavigationController();
            } else {
              showSnackBar(
                description: AppStrings.questionHintIfWantBack,
                state: ToastStates.warning,
                context: context,
              );
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: BlocConsumer<QuestionsBloc, QuestionsState>(
              listener: (context, state) {
                if (state.getQuestionsMessage.isNotEmpty &&
                    state.getQuestionsStates == RequestStates.loaded &&
                    !context.read<QuestionsBloc>().isShowMessage) {
                  if (!BlocProvider.of<GlobalBloc>(context)
                      .state
                      .appVersionModel
                      .inReview2) {
                    if (BlocProvider.of<QuestionsBloc>(context)
                            .allQuestions
                            .last
                            .id ==
                        state.currentQuestion!.id) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          elevation: 5,
                          actionsPadding: EdgeInsets.zero,
                          buttonPadding: EdgeInsets.zero,
                          iconPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          titlePadding: EdgeInsets.zero,
                          content: Container(
                            padding:
                                EdgeInsets.all(AppPadding.p20.responsiveSize),
                            width: AppReference.deviceWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants
                                  .appBorderRadiusR25.responsiveSize),
                              color: AppColors.backgroundColor,
                            ),
                            height: AppReference.deviceHeight(context) * 0.15,
                            child: Text(
                              state.getQuestionsMessage,
                              style: const AppTextStyle().w400.titleMedium20,
                            ),
                          ),
                        ),
                      ).then((value) {
                        if (context.mounted){
                          context.read<QuestionsBloc>().isShowMessage = true;
                        }
                      });
                    }
                  }
                }
              },
              builder: (context, state) {
                switch (state.getQuestionsStates) {
                  case RequestStates.loading:
                    return const QuestionScreenLoading();
                  case RequestStates.loaded:
                    if (context.read<QuestionsBloc>().allQuestions.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional.center,
                            child: EmptyListWidgets(
                              message: AppStrings.emptyQuestionsList,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _questionNavigationController();
                            },
                            child: const Text('رجوع'),
                          ),
                        ],
                      );
                    } else {
                      context.read<QuestionsBloc>().add(const StartTimer());
                      final QuestionEntity currentQuestion =
                          state.currentQuestion!;
                      final int currentQuestionNumber =
                          state.currentQuestionIndex;

                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SafeArea(
                            child: widget.data.isPrimary
                                ? ResponsiveWidgetForTablet(
                                    tablet: OrientationItem(
                                      landscapeWidget: Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                _PrimaryChildLandscapeView(
                                                  currentQuestion:
                                                      currentQuestion,
                                                  currentQuestionNumber:
                                                      currentQuestionNumber,
                                                  showHint: state.isHintShown,
                                                  reportQuestion: () {
                                                    _reportOnTap(
                                                        currentQuestion.id);
                                                  },
                                                ),
                                                PositionedDirectional(
                                                  top: AppReference.deviceHeight(
                                                          context) *
                                                      0.2,
                                                  start: AppReference.deviceWidth(
                                                          context) *
                                                      0.15,
                                                  child: const FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: WaterMarkWidget(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AppSize.s10.sizedBoxHeight,
                                          SizedBox(
                                            width: AppReference.deviceWidth(
                                                    context) *
                                                0.5,
                                            child: BlocSelector<
                                                QuestionsBloc,
                                                QuestionsState,
                                                QuestionsStates>(
                                              selector: (state) =>
                                                  state.questionsStates,
                                              builder: (context, state) {
                                                if (state !=
                                                    QuestionsStates
                                                        .answeredFromFirstTry) {
                                                  return Pulse(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    animate: state ==
                                                        QuestionsStates
                                                            .wrongAnswer,
                                                    child: DefaultButtonWidget(
                                                      label:
                                                          AppStrings.submission,
                                                      textVerticalPadding:
                                                          AppPadding.p12,
                                                      width: 200,
                                                      textStyle:
                                                          const AppTextStyle()
                                                              .white
                                                              .w500
                                                              .bodyLarge16,
                                                      onPressed: () {
                                                        if (currentQuestion
                                                                    .select1Type ==
                                                                AppKeys
                                                                    .textFieldKey &&
                                                            _formKey
                                                                .currentState!
                                                                .validate()) {
                                                          context
                                                              .read<
                                                                  QuestionsBloc>()
                                                              .add(TheSelectedAnswerIsTextField(
                                                                  answer:
                                                                      _answerController
                                                                          .text));
                                                        } else if (currentQuestion
                                                                    .select1Type !=
                                                                AppKeys
                                                                    .textFieldKey &&
                                                            context
                                                                    .read<
                                                                        QuestionsBloc>()
                                                                    .state
                                                                    .selectedAnswerIndex !=
                                                                0) {
                                                          context
                                                              .read<
                                                                  QuestionsBloc>()
                                                              .add(
                                                                  const CheckAnswer());
                                                        }
                                                      },
                                                      borderColor: AppColors
                                                          .primaryColor,
                                                      buttonColor: AppColors
                                                          .primaryColor,
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      portraitWidget: Stack(
                                        children: [
                                          _PrimaryChildPortraitView(
                                            currentQuestion: currentQuestion,
                                            currentQuestionNumber:
                                                currentQuestionNumber,
                                            showHint: state.isHintShown,
                                            reportQuestion: () {
                                              // RouteManager.rPopRoute(context);
                                              _reportOnTap(currentQuestion.id);
                                            },
                                          ),
                                          //WaterMark
                                          PositionedDirectional(
                                            top: AppReference.deviceHeight(
                                                    context) *
                                                0.5,
                                            start: AppReference.deviceWidth(
                                                    context) *
                                                0.1,
                                            child: const FittedBox(
                                              fit: BoxFit.fill,
                                              child: WaterMarkWidget(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    mobile: OrientationItem(
                                        portraitWidget: Stack(
                                          children: [
                                            _PrimaryChildPortraitView(
                                              currentQuestion: currentQuestion,
                                              currentQuestionNumber:
                                                  currentQuestionNumber,
                                              showHint: state.isHintShown,
                                              reportQuestion: () {
                                                // RouteManager.rPopRoute(context);
                                                _reportOnTap(
                                                    currentQuestion.id);
                                              },
                                            ),
                                            //WaterMark
                                            PositionedDirectional(
                                              top: AppReference.deviceHeight(
                                                      context) *
                                                  0.5,
                                              start: AppReference.deviceWidth(
                                                      context) *
                                                  0.1,
                                              child: const FittedBox(
                                                fit: BoxFit.fill,
                                                child: WaterMarkWidget(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        landscapeWidget: Column(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  _PrimaryChildLandscapeView(
                                                    currentQuestion:
                                                        currentQuestion,
                                                    currentQuestionNumber:
                                                        currentQuestionNumber,
                                                    showHint: state.isHintShown,
                                                    reportQuestion: () {
                                                      _reportOnTap(
                                                          currentQuestion.id);
                                                    },
                                                  ),
                                                  PositionedDirectional(
                                                    top:
                                                        AppReference.deviceHeight(
                                                                context) *
                                                            0.2,
                                                    start:
                                                        AppReference.deviceWidth(
                                                                context) *
                                                            0.15,
                                                    child: const FittedBox(
                                                      fit: BoxFit.fill,
                                                      child: WaterMarkWidget(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            AppSize.s10.sizedBoxHeight,
                                            SizedBox(
                                              width: AppReference.deviceWidth(
                                                      context) *
                                                  0.5,
                                              child: BlocSelector<
                                                  QuestionsBloc,
                                                  QuestionsState,
                                                  QuestionsStates>(
                                                selector: (state) =>
                                                    state.questionsStates,
                                                builder: (context, state) {
                                                  if (state !=
                                                      QuestionsStates
                                                          .answeredFromFirstTry) {
                                                    return Pulse(
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      animate: state ==
                                                          QuestionsStates
                                                              .wrongAnswer,
                                                      child:
                                                          DefaultButtonWidget(
                                                        label: AppStrings
                                                            .submission,
                                                        textVerticalPadding:
                                                            AppPadding.p12,
                                                        width: 200,
                                                        textStyle:
                                                            const AppTextStyle()
                                                                .white
                                                                .w500
                                                                .bodyLarge16,
                                                        onPressed: () {
                                                          if (currentQuestion
                                                                      .select1Type ==
                                                                  AppKeys
                                                                      .textFieldKey &&
                                                              _formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                            context
                                                                .read<
                                                                    QuestionsBloc>()
                                                                .add(TheSelectedAnswerIsTextField(
                                                                    answer: _answerController
                                                                        .text));
                                                          } else if (currentQuestion
                                                                      .select1Type !=
                                                                  AppKeys
                                                                      .textFieldKey &&
                                                              context
                                                                      .read<
                                                                          QuestionsBloc>()
                                                                      .state
                                                                      .selectedAnswerIndex !=
                                                                  0) {
                                                            context
                                                                .read<
                                                                    QuestionsBloc>()
                                                                .add(
                                                                    const CheckAnswer());
                                                          }
                                                        },
                                                        borderColor: AppColors
                                                            .primaryColor,
                                                        buttonColor: AppColors
                                                            .primaryColor,
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                : ResponsiveWidgetForTablet(
                                    tablet: OrientationItem(
                                      landscapeWidget: Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                _ChildLandscapeView(
                                                  currentQuestion:
                                                      currentQuestion,
                                                  currentQuestionNumber:
                                                      currentQuestionNumber,
                                                  showHint: state.isHintShown,
                                                  reportQuestion: () {
                                                    _reportOnTap(
                                                        currentQuestion.id);
                                                  },
                                                ),
                                                PositionedDirectional(
                                                  top: AppReference.deviceHeight(
                                                          context) *
                                                      0.2,
                                                  start: AppReference.deviceWidth(
                                                          context) *
                                                      0.15,
                                                  child: const FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: WaterMarkWidget(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AppSize.s10.sizedBoxHeight,
                                          SizedBox(
                                            width: AppReference.deviceWidth(
                                                    context) *
                                                0.5,
                                            child: BlocSelector<
                                                QuestionsBloc,
                                                QuestionsState,
                                                QuestionsStates>(
                                              selector: (state) =>
                                                  state.questionsStates,
                                              builder: (context, state) {
                                                if (state !=
                                                    QuestionsStates
                                                        .answeredFromFirstTry) {
                                                  return Pulse(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    animate: state ==
                                                        QuestionsStates
                                                            .wrongAnswer,
                                                    child: DefaultButtonWidget(
                                                      label:
                                                          AppStrings.submission,
                                                      textVerticalPadding:
                                                          AppPadding.p12,
                                                      width: 200,
                                                      textStyle:
                                                          const AppTextStyle()
                                                              .white
                                                              .w500
                                                              .bodyLarge16,
                                                      onPressed: () {
                                                        if (currentQuestion
                                                                    .select1Type ==
                                                                AppKeys
                                                                    .textFieldKey &&
                                                            _formKey
                                                                .currentState!
                                                                .validate()) {
                                                          context
                                                              .read<
                                                                  QuestionsBloc>()
                                                              .add(TheSelectedAnswerIsTextField(
                                                                  answer:
                                                                      _answerController
                                                                          .text));
                                                        } else if (currentQuestion
                                                                    .select1Type !=
                                                                AppKeys
                                                                    .textFieldKey &&
                                                            context
                                                                    .read<
                                                                        QuestionsBloc>()
                                                                    .state
                                                                    .selectedAnswerIndex !=
                                                                0) {
                                                          context
                                                              .read<
                                                                  QuestionsBloc>()
                                                              .add(
                                                                  const CheckAnswer());
                                                        }
                                                      },
                                                      borderColor: AppColors
                                                          .primaryColor,
                                                      buttonColor: AppColors
                                                          .primaryColor,
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      portraitWidget: _ChildPortraitView(
                                        currentQuestion: currentQuestion,
                                        currentQuestionNumber:
                                            currentQuestionNumber,
                                        reportQuestion: () {
                                          _reportOnTap(currentQuestion.id);
                                        },
                                        showHint: state.isHintShown,
                                        //questionNumber: questionNumber,
                                      ),
                                    ),
                                    mobile: OrientationItem(
                                        portraitWidget: _ChildPortraitView(
                                          currentQuestion: currentQuestion,
                                          currentQuestionNumber:
                                              currentQuestionNumber,
                                          reportQuestion: () {
                                            _reportOnTap(currentQuestion.id);
                                          },
                                          showHint: state.isHintShown,
                                          //questionNumber: questionNumber,
                                        ),
                                        landscapeWidget: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                _ChildLandscapeView(
                                                  currentQuestion:
                                                      currentQuestion,
                                                  currentQuestionNumber:
                                                      currentQuestionNumber,
                                                  showHint: state.isHintShown,
                                                  reportQuestion: () {
                                                    _reportOnTap(
                                                        currentQuestion.id);
                                                  },
                                                ),
                                                PositionedDirectional(
                                                  top:
                                                      AppReference.deviceHeight(
                                                              context) *
                                                          0.2,
                                                  start:
                                                      AppReference.deviceWidth(
                                                              context) *
                                                          0.15,
                                                  child: const FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: WaterMarkWidget(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AppSize.s10.sizedBoxHeight,
                                            SizedBox(
                                              width: AppReference.deviceWidth(
                                                      context) *
                                                  0.5,
                                              child: BlocSelector<
                                                  QuestionsBloc,
                                                  QuestionsState,
                                                  QuestionsStates>(
                                                selector: (state) =>
                                                    state.questionsStates,
                                                builder: (context, state) {
                                                  if (state !=
                                                      QuestionsStates
                                                          .answeredFromFirstTry) {
                                                    return Pulse(
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      animate: state ==
                                                          QuestionsStates
                                                              .wrongAnswer,
                                                      child:
                                                          DefaultButtonWidget(
                                                        label: AppStrings
                                                            .submission,
                                                        textVerticalPadding:
                                                            AppPadding.p12,
                                                        width: 200,
                                                        textStyle:
                                                            const AppTextStyle()
                                                                .white
                                                                .w500
                                                                .bodyLarge16,
                                                        onPressed: () {
                                                          if (currentQuestion
                                                                      .select1Type ==
                                                                  AppKeys
                                                                      .textFieldKey &&
                                                              _formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                            context
                                                                .read<
                                                                    QuestionsBloc>()
                                                                .add(TheSelectedAnswerIsTextField(
                                                                    answer: _answerController
                                                                        .text));
                                                          } else if (currentQuestion
                                                                      .select1Type !=
                                                                  AppKeys
                                                                      .textFieldKey &&
                                                              context
                                                                      .read<
                                                                          QuestionsBloc>()
                                                                      .state
                                                                      .selectedAnswerIndex !=
                                                                  0) {
                                                            context
                                                                .read<
                                                                    QuestionsBloc>()
                                                                .add(
                                                                    const CheckAnswer());
                                                          }
                                                        },
                                                        borderColor: AppColors
                                                            .primaryColor,
                                                        buttonColor: AppColors
                                                            .primaryColor,
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                          ),
                          ConfettiBottom(controller: _confettiControllerBottom),
                          ConfettiRight(controller: _confettiControllerRight),
                          ConfettiLeft(controller: _confettiControllerLeft),
                        ],
                      );
                    }
                  case RequestStates.error:
                    return RefreshIndicator(
                      backgroundColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                      onRefresh: () async {},
                      child: Center(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            SvgPicture.asset(
                              AppImagesAssets.sError404,
                            ),
                            Text(
                              '${state.getQuestionsMessage},\t ${AppStrings.tryLater}',
                              style: AppReference.themeData.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            AppSize.s20.sizedBoxHeight,
                            TextButton(
                              onPressed: () {
                                _questionNavigationController();
                              },
                              child: const Text('رجوع'),
                            ),
                          ],
                        ),
                      ),
                    );
                  default:
                    return const Center(
                      child: TextBackButton(),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  late final ConfettiController _confettiControllerBottom;
  late final ConfettiController _confettiControllerLeft;
  late final ConfettiController _confettiControllerRight;

  void _questionNavigationController() {
    if (widget.data.isFromNafees) {
      RouteManager.rPopRoute(context);
    } else {
      if (widget.data.isGeneralQuestions) {
        if (widget.data.isPrimary) {
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rPrimaryCollectionsScreen,
              arguments: widget.data);
        } else {
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rChildCollectionsScreen,
              arguments: widget.data);
        }
      } else {
        RouteManager.rPushNamedAndRemoveUntil(
            context: context,
            rName: AppRoutesNames.rLessonScreen,
            arguments: widget.data);
      }
    }
  }

  _reportOnTap(id) {
    return showDialog(
        context: context,
        builder: (o) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              elevation: 5,
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              content: BlocProvider(
                create: (context) => getIt<QuestionsBloc>(),
                child: Container(
                  padding: EdgeInsets.all(20.responsiveSize),
                  width: AppReference.deviceWidth(context) * 0.8,
                  height: AppReference.deviceHeight(context) * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.responsiveSize),
                    color: AppColors.backgroundColor,
                  ),
                  child: BlocListener<QuestionsBloc, QuestionsState>(
                    listener: (context, state) {
                      switch (state.reportQuestionState) {
                        case RequestStates.loading:
                          showLoadingDialog(context);
                        case RequestStates.loaded:
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showSnackBar(
                              description: state.reportQuestionMessage,
                              state: ToastStates.congrats,
                              context: context);
                          reportController.clear();
                        case RequestStates.error:
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showSnackBar(
                              description: state.reportQuestionMessage,
                              state: ToastStates.error,
                              context: context);
                        default:
                      }
                    },
                    child: LayoutBuilder(builder: (context, constrains) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (constrains.maxHeight * 0.01).sizedBoxHeight,
                          Text(
                            AppStrings.writeYourReport,
                            style: const AppTextStyle().s16.titleLarge22,
                          ),
                          TextFormFieldWidget(
                            controller: reportController,
                            keyboardType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            label: '',
                            onFieldSubmitted: (value) {
                              reportMessage = value;
                            },
                          ),
                          (constrains.maxHeight * 0.01).sizedBoxHeight,
                          DefaultButtonWidget(
                            label: AppStrings.report,
                            onPressed: () {
                              if (reportController.text.isNotEmpty) {
                                context
                                    .read<QuestionsBloc>()
                                    .add(ReportQuestionEvent(
                                        parameters: ReportQuestionParameters(
                                      questionId: id,
                                      message: reportController.text.toString(),
                                      type: widget.data.isGeneralQuestions
                                          ? 'general'
                                          : 'lesson',
                                    )));
                              }
                            },
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            )).then((value) {
      // reportController.clear();
    });
  }

  @override
  void initState() {

    _confettiControllerBottom =
        ConfettiController(duration: AppConstants.durationOfConfetti);
    _confettiControllerLeft =
        ConfettiController(duration: AppConstants.durationOfConfetti);
    _confettiControllerRight =
        ConfettiController(duration: AppConstants.durationOfConfetti);

    super.initState();
    _initScreenProtector();

  }

  @override
  void dispose() {
    _confettiControllerBottom.removeListener(() {
      _confettiControllerBottom.dispose();
    });
    _confettiControllerLeft.removeListener(() {
      _confettiControllerLeft.dispose();
    });
    _confettiControllerRight.removeListener(() {
      _confettiControllerRight.dispose();
    });

    super.dispose();
  }

  @override
  void didChangeDependencies()async {
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageOff();
    await ScreenProtector.protectDataLeakageWithBlur();
    if (Platform.isIOS) {
      await ScreenProtector.protectDataLeakageWithBlur();
    }

    super.didChangeDependencies();
  }
}

class QuestionScreenLoading extends StatelessWidget {
  const QuestionScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadingShimmerStructure(
          height:
              AppReference.deviceHeight(context) * .04.responsiveHeightRatio,
          width: double.infinity,
        ),
        LoadingShimmerStructure(
          height: AppReference.deviceHeight(context) * .1.responsiveHeightRatio,
          width: double.infinity,
        ),
        LoadingShimmerStructure(
          height:
              AppReference.deviceHeight(context) * .14.responsiveHeightRatio,
          width: double.infinity,
        ),
        const Expanded(
          child: LoadingShimmerList(),
        ),
      ],
    );
  }
}
