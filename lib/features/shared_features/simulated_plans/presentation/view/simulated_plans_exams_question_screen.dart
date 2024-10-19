part of '../../simulated_plans.dart';

class SimulatedQuestionScreen extends StatefulWidget {
  final SimulatedSubjectData simulatedSubjectData;
  const SimulatedQuestionScreen({
    required this.simulatedSubjectData,
    super.key,
  });

  @override
  State<SimulatedQuestionScreen> createState() => _SimulatedQuestionScreenState();
}

class _SimulatedQuestionScreenState extends State<SimulatedQuestionScreen> {
  late final PageController pageController;
  Timer? _timer;
  final ValueNotifier<Duration> _duration =
      ValueNotifier<Duration>(const Duration(seconds: 0));
  bool exit = false;

  @override
  void initState() {
    super.initState();
    _duration.value = Duration(minutes: widget.simulatedSubjectData.duration!);
    pageController = PageController();
    if(widget.simulatedSubjectData.playDuration){
    startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.value.inSeconds > 0) {
        _duration.value = _duration.value - const Duration(seconds: 1);
        if (_duration.value.inSeconds == 2) {

          showDialog(context: context,
              builder: (dialogContext)=> SimulatedTimeOutDialog(
               onPressed: (){
                 if (context
                     .read<SimulatedBloc>()
                     .state
                     .selectedAnswers
                     .isNotEmpty) {
                   BlocProvider.of<SimulatedBloc>(context).add(
                       SubmitSimulatedExamsAnswersEvent(
                         simulatedExamQuestionsAnswersInputs:
                         SimulatedExamQuestionsAnswersInputs(
                             childId: widget.simulatedSubjectData.childId,
                             examId: widget
                                 .simulatedSubjectData
                                 .simulatedPlans.examsData[widget
                                 .simulatedSubjectData.index!].id,
                             questions: context
                                 .read<SimulatedBloc>()
                                 .state
                                 .selectedAnswers
                                 .entries
                                 .map((entry) =>
                                 SimulatedExamQuestionsAndAnswersIdsInputs(
                                     questionId: entry.key,
                                     answerId: entry.value))
                                 .toList()),
                       )
                   );
                 }
               },
              ));}
      } else {
        timer.cancel();
      }
    });
  }

  String convertTimer(var duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        if (!value) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return SimulatedExamsBackDialouge(
                  simulatedSubjectData: widget.simulatedSubjectData,
                );
              });
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppReference.deviceHeight(context) *
                      0.06.responsiveHeightRatio,
                  child: LayoutBuilder(builder: (context, constrains) {
                    return Row(
                      children: [
                        SvgPicture.asset(
                          AppImagesAssets.sLogoWithoutName,
                          width: constrains.maxWidth * 0.2,
                          height: constrains.maxHeight * 0.7,
                          fit: BoxFit.cover,
                        ),
                        AppSize.s10.sizedBoxWidth,
                        TextWithBackGroundColor(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(.1),
                          text: AppStrings.questions,
                          width: constrains.maxWidth * 0.6,
                          height: constrains.maxHeight * 0.7,
                          verticalPadding: 0,
                          textColor: AppColors.textColor4,
                        ),
                        const Spacer(),
                        TextBackButton(
                          backTo: () {
                            if (exit) {
                              Navigator.pop(context);
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return SimulatedExamsBackDialouge(
                                      simulatedSubjectData:
                                          widget.simulatedSubjectData,
                                    );
                                  });
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ).paddingBody(),
                BlocListener<SimulatedBloc, SimulatedState>(
                  listener: (context, state) {
                    switch (state.submitSimulatedQuestionsAnswersState) {
                      case RequestStates.loading:
                        showLoadingDialog(context);
                      case RequestStates.loaded:
                        RouteManager.rPopRoute(context);
                        showSnackBar(
                          description:
                              ' أحسنت لقد أنهيت هذه الأسئلة بنجاح\nالنقاط التي حصلت عليها هي( ${state.submitSimulatedQuestionsAnswersMessage} ) ',
                          state: ToastStates.congrats,
                          context: context,
                        );
                        RouteManager.rPushReplacementNamed(
                          context: context,
                          rName: AppRoutesNames.rSimulatedeExamsScreen,
                          arguments: widget.simulatedSubjectData,
                        );
                      case RequestStates.error:
                        Navigator.pop(context);
                        showSnackBar(
                          description:
                              state.submitSimulatedQuestionsAnswersMessage,
                          state: ToastStates.error,
                          context: context,
                        );
                        RouteManager.rPopRoute(context);
                      default:
                    }
                  },
                  child: Expanded(
                    child: PageView.builder(
                      itemCount:
                          widget.simulatedSubjectData.simulatedQuestionEntity!.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: pageController,
                      itemBuilder: (pageViewContext, questionIndex) {
                        //ToDo: refactor this section
                        submit() {
                          if (questionIndex <
                              widget.simulatedSubjectData.simulatedQuestionEntity!
                                      .length -
                                  1) {
                            pageController.animateToPage(
                              questionIndex + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            List<int> unsolvedQuestions = [];
                            for (int i = 0;
                                i <
                                    widget.simulatedSubjectData
                                        .simulatedQuestionEntity!.length;
                                i++) {
                              if (!context
                                  .read<SimulatedBloc>()
                                  .state
                                  .selectedAnswers
                                  .containsKey(widget.simulatedSubjectData
                                      .simulatedQuestionEntity![i].id
                                      .toString())) {
                                unsolvedQuestions.add(i + 1);
                              }
                            }

                            if (unsolvedQuestions.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => CompleteQuestionDialoug(
                                      unsolvedQuestions: unsolvedQuestions));
                              return;
                            }

                            BlocProvider.of<SimulatedBloc>(context)
                                .add(SubmitSimulatedExamsAnswersEvent(
                              simulatedExamQuestionsAnswersInputs:
                                  SimulatedExamQuestionsAnswersInputs(
                                      childId: widget.simulatedSubjectData.childId,
                                      examId: widget
                                          .simulatedSubjectData
                                          .simulatedQuestionEntity![questionIndex]
                                          .examId,
                                      questions: context
                                          .read<SimulatedBloc>()
                                          .state
                                          .selectedAnswers
                                          .entries
                                          .map((entry) =>
                                              SimulatedExamQuestionsAndAnswersIdsInputs(
                                                  questionId: entry.key,
                                                  answerId: entry.value))
                                          .toList()),
                            ));
                          }
                        }

                        previous() {
                          if (questionIndex > 0) {
                            pageController.jumpToPage(
                              questionIndex - 1,
                            );
                          }
                        }

                        return OrientationItem(
                            portraitWidget: Column(
                              children: [
                                if(widget.simulatedSubjectData.playDuration)...[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p20.responsiveSize,
                                      vertical: AppPadding.p10.responsiveSize,
                                    ),
                                    width: double.infinity,
                                    color: AppColors.white,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            AppIconsAssets.sNafessClock),
                                        AppSize.s10.sizedBoxWidth,
                                        Text(
                                          "وقت الاختبار",
                                          style:
                                              AppTextStyle().w600.bodyMedium14,
                                        ),
                                        const Spacer(),
                                        ValueListenableBuilder<Duration>(
                                          valueListenable: _duration,
                                          builder: (context, value, child) {
                                            return Text(
                                              convertTimer(value),
                                              style:  const AppTextStyle()
                                                  .w600
                                                  .bodyLarge16
                                                  .copyWith(
                                                  color: AppColors.textColor4),
                                            );
                                          },
                                        )
                                      ],
                                    ))],
                                AppSize.s10.sizedBoxHeight,
                                Container(
                                  width: double.infinity,
                                  height: 10.responsiveHeight,
                                  decoration: BoxDecoration(
                                      color: AppColors.textColor6,
                                      borderRadius: BorderRadius.circular(
                                          AppConstants.appBorderRadiusR10
                                              .responsiveSize)),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: ((questionIndex + 1) /
                                        widget.simulatedSubjectData
                                            .simulatedQuestionEntity!.length),
                                    child: Container(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),

                                //! Question Count Circle
                                SizedBox(
                                  height: AppReference.deviceHeight(context) *
                                      0.05.responsiveHeightRatio,
                                  width: AppReference.deviceWidth(context),
                                  child: Center(
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (listViewContext, index) =>
                                          CustomInkWell(
                                        onTap: () {
                                          pageController.animateToPage(
                                            index,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: questionIndex == index
                                              ? 20.responsiveSize
                                              : 15.responsiveSize,
                                          backgroundColor:
                                              questionIndex == index
                                                  ? AppColors.secondaryColor
                                                  : AppColors.white,
                                          child: Text(
                                            '${index + 1}',
                                            style: const AppTextStyle()
                                                .w700
                                                .bodyMedium14
                                                .copyWith(
                                                  color: questionIndex == index
                                                      ? AppColors.white
                                                      : AppColors.textColor4,
                                                ),
                                          ),
                                        ),
                                      ),
                                      separatorBuilder:
                                          (listViewContext, index) =>
                                              AppSize.s6.sizedBoxWidth,
                                      itemCount: widget.simulatedSubjectData
                                          .simulatedQuestionEntity!.length,
                                    ),
                                  ),
                                ).paddingBody(),
                                Expanded(
                                  child: ListView(
                                    children: [
                                      if (widget.simulatedSubjectData.simulatedQuestionEntity![questionIndex].category != "") ...[
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppPadding.p20.responsiveSize,
                                              vertical:
                                                  AppPadding.p10.responsiveSize,
                                            ),
                                            width: double.infinity,
                                            color: AppColors.white,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(AppIconsAssets
                                                    .sNafeesCategory),
                                                AppSize.s10.sizedBoxWidth,
                                                Text(
                                                  widget
                                                      .simulatedSubjectData
                                                      .simulatedQuestionEntity![
                                                          questionIndex]
                                                      .category!,
                                                  style: AppTextStyle()
                                                      .w600
                                                      .bodyMedium14,
                                                ),
                                              ],
                                            )),
                                        AppSize.s10.sizedBoxHeight,
                                      ],
if (widget
                                              .simulatedSubjectData
                                              .simulatedQuestionEntity![
                                                  questionIndex]
                                              .img !=
                                          null) ...[
                                        QuestionItemForSimulated(
                                            currentQuestion: widget
                                                    .simulatedSubjectData
                                                    .simulatedQuestionEntity![
                                                questionIndex]),
                                      ],
                                      Row(
                                        children: [
                                          QuestionsText(
                                            currentQuestion: widget
                                                    .simulatedSubjectData
                                                    .simulatedQuestionEntity![
                                                questionIndex],
                                          ),
                        if(!widget.simulatedSubjectData.playDuration)...[
                                          AppSize.s10.sizedBoxWidth,
                                          HintWidgetForSimulated(
                                              currentQuestion: widget
                                                      .simulatedSubjectData
                                                      .simulatedQuestionEntity![
                                                  questionIndex]),]
                                        ],
                                      ).paddingBody(),
                                      if(widget
                                          .simulatedSubjectData
                                          .simulatedQuestionEntity![
                                      questionIndex].usePiece)...[
                                      CustomInkWell(
                                        onTap: () {
                                          showDialog(context: context,
                                              builder: (dialogContext)=> SimulatedPieceDialog(
                                                piece:widget.simulatedSubjectData.piece!,
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppIconsAssets.sNafeesPieceText),

                                            AppSize.s10.sizedBoxWidth,
                                            Text("انظر القطعة",style: AppTextStyle().w600.bodySmall12.copyWith(
                                              color: AppColors.primaryColor2,
                                              decoration: TextDecoration.underline,
                                              decorationColor: AppColors.primaryColor2
                                            ),)
                                          ],
                                        ).paddingBody(),
                                      )],
                                      //! Answers
                                      AnswerBuilderForSimulated(
                                        currentQuestion: widget
                                                .simulatedSubjectData
                                                .simulatedQuestionEntity![
                                            questionIndex],
                                        isAdult: true,
                                      ).paddingBody(),
                                    ],
                                  ),
                                ),

                                NextAndPreviousRandomExams(
                                    submit: submit,
                                    previous: previous,
                                    isLastQuestion: widget.simulatedSubjectData
                                            .simulatedQuestionEntity!.last ==
                                        widget.simulatedSubjectData
                                                .simulatedQuestionEntity![
                                            questionIndex])
                              ],
                            ),
                            landscapeWidget: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 10.responsiveHeight,
                                  decoration: BoxDecoration(
                                      color: AppColors.textColor6,
                                      borderRadius: BorderRadius.circular(
                                          AppConstants.appBorderRadiusR10
                                              .responsiveSize)),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: ((questionIndex + 1) /
                                        widget.simulatedSubjectData
                                            .simulatedQuestionEntity!.length),
                                    child: Container(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ).paddingBody(),

                                //! Question Count Circle
                                SizedBox(
                                  height: AppReference.deviceHeight(context) *
                                      0.05.responsiveHeightRatio,
                                  width: AppReference.deviceWidth(context),
                                  child: Center(
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (listViewContext, index) =>
                                          CustomInkWell(
                                        onTap: () {
                                          pageController.animateToPage(
                                            index,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: questionIndex == index
                                              ? 20.responsiveSize
                                              : 15.responsiveSize,
                                          backgroundColor:
                                              questionIndex == index
                                                  ? AppColors.primaryColor
                                                  : AppColors.white,
                                          child: Text(
                                            '${index + 1}',
                                            style: const AppTextStyle()
                                                .w700
                                                .bodyMedium14
                                                .copyWith(
                                                  color: questionIndex == index
                                                      ? AppColors.white
                                                      : AppColors.textColor4,
                                                ),
                                          ),
                                        ),
                                      ),
                                      separatorBuilder:
                                          (listViewContext, index) =>
                                              AppSize.s6.sizedBoxWidth,
                                      itemCount: widget.simulatedSubjectData
                                          .simulatedQuestionEntity!.length,
                                    ),
                                  ),
                                ).paddingBody(),
                                AppSize.s10.sizedBoxHeight,
                                if(widget.simulatedSubjectData.playDuration)...[
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppPadding.p20.responsiveSize,
                                        vertical: AppPadding.p10.responsiveSize,
                                      ),
                                      width: double.infinity,
                                      color: AppColors.white,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              AppIconsAssets.sNafessClock),
                                          AppSize.s10.sizedBoxWidth,
                                          Text(
                                            "وقت الاختبار",
                                            style:
                                            AppTextStyle().w600.bodyMedium14,
                                          ),
                                          const Spacer(),
                                          ValueListenableBuilder<Duration>(
                                            valueListenable: _duration,
                                            builder: (context, value, child) {
                                              return Text(
                                                convertTimer(value),
                                                style:  const AppTextStyle()
                                                    .w600
                                                    .bodyLarge16
                                                    .copyWith(
                                                    color: AppColors.textColor4),
                                              );
                                            },
                                          )
                                        ],
                                      )).paddingBody()],

                                AppSize.s10.sizedBoxHeight,

                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Row(
                                      children: [
                                        //! Question Type
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if (widget.simulatedSubjectData.simulatedQuestionEntity![questionIndex].category != "") ...[
                                                Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                      AppPadding.p20.responsiveSize,
                                                      vertical:
                                                      AppPadding.p10.responsiveSize,
                                                    ),
                                                    width: double.infinity,
                                                    color: AppColors.white,
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(AppIconsAssets
                                                            .sNafeesCategory),
                                                        AppSize.s10.sizedBoxWidth,
                                                        Text(
                                                          widget
                                                              .simulatedSubjectData
                                                              .simulatedQuestionEntity![
                                                          questionIndex]
                                                              .category!,
                                                          style: AppTextStyle()
                                                              .w600
                                                              .bodyMedium14,
                                                        ),
                                                      ],
                                                    )).paddingBody(),
                                                AppSize.s10.sizedBoxHeight,
                                              ],
                                              if(widget
                                                  .simulatedSubjectData
                                                  .simulatedQuestionEntity![
                                              questionIndex].usePiece)...[
                                                CustomInkWell(
                                                  onTap: () {
                                                    showDialog(context: context,
                                                        builder: (dialogContext)=> SimulatedPieceDialog(
                                                          piece:widget.simulatedSubjectData.piece!,
                                                        ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          AppIconsAssets.sNafeesPieceText),

                                                      AppSize.s10.sizedBoxWidth,
                                                      Text("انظر القطعة",style: AppTextStyle().w600.bodySmall12.copyWith(
                                                          color: AppColors.primaryColor2,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: AppColors.primaryColor2
                                                      ),)
                                                    ],
                                                  ).paddingBody(),
                                                )],
                                              //! Question Type
                                              if (widget
                                                  .simulatedSubjectData
                                                  .simulatedQuestionEntity![
                                              questionIndex]
                                                  .img !=
                                                  null) ...[
                                                QuestionItemForSimulated(
                                                    currentQuestion: widget
                                                        .simulatedSubjectData
                                                        .simulatedQuestionEntity![
                                                    questionIndex]),
                                              ],
                                              Row(
                                                children: [
                                                  QuestionsText(
                                                    currentQuestion: widget
                                                        .simulatedSubjectData
                                                        .simulatedQuestionEntity![
                                                    questionIndex],
                                                  ),
                                                    if(!widget.simulatedSubjectData.playDuration)...[
                                                  AppSize.s10.sizedBoxWidth,
                                                  HintWidgetForSimulated(
                                                      currentQuestion: widget
                                                          .simulatedSubjectData
                                                          .simulatedQuestionEntity![
                                                      questionIndex]),]
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        //! Answers
                                        Expanded(
                                          child: AnswerBuilderForSimulated(
                                            currentQuestion: widget
                                                    .simulatedSubjectData
                                                    .simulatedQuestionEntity![
                                                questionIndex],
                                            isAdult: true,
                                          ),
                                        ),
                                      ],
                                    ).paddingBody(),
                                  ),
                                ),

                                //! Footer Buttons Submit and Previous
                                NextAndPreviousRandomExams(
                                    submit: submit,
                                    previous: previous,
                                    isLastQuestion: widget.simulatedSubjectData
                                            .simulatedQuestionEntity!.last ==
                                        widget.simulatedSubjectData
                                                .simulatedQuestionEntity![
                                            questionIndex])
                              ],
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              top: AppReference.deviceHeight(context) * 0.3,
              start: AppReference.deviceWidth(context) * 0.25,
              child: Transform.rotate(
                angle: 45,
                child: Text(
                  getIt<UserLocalDataSource>().getUserData()!.username,
                  style:
                      AppReference.themeData.textTheme.displayLarge!.copyWith(
                    color: Colors.black.withOpacity(0.05),
                    fontSize: AppFontSize.sp50.responsiveFontSize,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class NextAndPreviousRandomExams extends StatelessWidget {
  final Function() submit;
  final Function() previous;
  final bool isLastQuestion;
  const NextAndPreviousRandomExams(
      {super.key,
      required this.submit,
      required this.previous,
      required this.isLastQuestion});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.07.responsiveHeightRatio,
      child: Padding(
        padding: EdgeInsets.all(5.responsiveSize),
        child: Row(children: [
          Expanded(
              flex: 2,
              child: DefaultButtonWidget(
                textVerticalPadding: 5,
                label: AppStrings.previous,
                buttonColor: AppColors.primaryColor,
                onPressed: previous,
              )),
          AppSize.s10.sizedBoxWidth,
          Expanded(
              flex: 5,
              child: DefaultButtonWidget(
                  textVerticalPadding: 5,
                  label: isLastQuestion ? AppStrings.submit : AppStrings.next,
                  onPressed: submit)),
        ]),
      ),
    );
  }
}

class SimulatedExamsBackDialouge extends StatelessWidget {
  final SimulatedSubjectData simulatedSubjectData;
  const SimulatedExamsBackDialouge({
    super.key,
    required this.simulatedSubjectData,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Container(
        height: AppReference.deviceIsTablet
            ? AppReference.deviceHeight(context) * 0.1.responsiveHeight
            : null,
        width: !AppReference.isPortrait(context)
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context) * 0.8,
        padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
        constraints: BoxConstraints(
          minHeight:
              AppReference.deviceHeight(context) * 0.26.responsiveHeightRatio,
          maxHeight:
              AppReference.deviceHeight(context) * 0.34.responsiveHeightRatio,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.responsiveSize),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              AppStrings.developerModeCheckTitle,
              style: AppReference.themeData.textTheme.displaySmall!.copyWith(
                color: AppColors.failColor,
                fontWeight: AppFontWeight.regular2W500,
              ),
            ),
            const Divider(color: AppColors.textColor6, thickness: 2),
            const Spacer(),
            Text(
              "بمجرد الخروج من هذا الامتحان، لن يتم احتساب هذة المحاولة.",
              style: const AppTextStyle().s16.titleLarge22,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: DefaultButtonWidget(
                      label: 'حسنا',
                      textVerticalPadding:
                          AppReference.isPortrait(context) ? 0 : 6,
                      onPressed: () {
                        Navigator.pop(context);
                        RouteManager.rPushReplacementNamed(
                          context: context,
                          rName: AppRoutesNames.rSimulatedeExamsScreen,
                          arguments: simulatedSubjectData,
                        );
                      }),
                ),
                AppSize.s10.sizedBoxWidth,
                Expanded(
                  child: DefaultButtonWidget(
                    textVerticalPadding:
                        AppReference.isPortrait(context) ? 0 : 6,
                    label: AppStrings.cancel,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class QuestionsText extends StatelessWidget {
  final SimulatedQuestionEntity currentQuestion;

  const QuestionsText({super.key, required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppReference.isPortrait(context)
          ? AppReference.deviceWidth(context) * 0.8
          : AppReference.deviceWidth(context) * 0.4,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 5.responsiveWidth,
        vertical: AppPadding.p10.responsiveHeight,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR25.responsiveSize),
      ),
      child: Text(
        currentQuestion.name ?? AppStrings.tryLater,
        textAlign: TextAlign.center,
        textDirection: AppConstants.arabicDirection(
            currentQuestion.name ?? AppStrings.tryLater),
        style: AppReference.detectStringType(
                    currentQuestion.name ?? AppStrings.tryLater) ==
                StringType.quranicArabic
            ? AppConstants.quranStyle
            : const AppTextStyle().white.w500.titleSmall18.copyWith(
                  fontFamily: 'NewFont',
                  color: Colors.black,
                  fontSize: 14.responsiveFontSize,
                ),
      ),
    );
  }
}

class HintWidgetForSimulated extends StatelessWidget {
  const HintWidgetForSimulated({
    super.key,
    required this.currentQuestion,
  });

  final SimulatedQuestionEntity currentQuestion;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        showHintOfQuestionsDialog(
          context: context,
          descriptionText: currentQuestion.description,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            AppIconsAssets.sAdultHint,
            width: 25.responsiveSize,
            height: 25.responsiveSize,
          ),
          Text(
            AppStrings.hint,
            style: const AppTextStyle().w700.bodyMedium14.copyWith(
                  fontFamily: 'NewFont',
                ),
          ),
        ],
      ),
    );
  }
}

class SimulatedTimeDialog extends StatelessWidget {
  final Function() onPressedYes,onPressedNo;
  const SimulatedTimeDialog({super.key, required this.onPressedNo, required this.onPressedYes});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          )),
      content: Container(
        width: !AppReference.isPortrait(context)
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context) * .8,
        padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
            BorderRadius.circular(AppConstants.appBorderRadiusR10)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "تنبيه !",
                    style: AppTextStyle().w700.titleMedium20,
                  )),
              AppSize.s20.sizedBoxHeight,
              SvgPicture.asset(AppIconsAssets.sNafeesTime),
              AppSize.s20.sizedBoxHeight,
              Text("هل تريد أن تفعل وقتا للاختبار؟",
                  textAlign: TextAlign.center,
                  style: const AppTextStyle()
                      .balooBhaijaan2
                      .black
                      .w700
                      .bodyLarge16),
              AppSize.s20.sizedBoxHeight,
              Row(
                children: [
                  Expanded(
                    child: DefaultButtonWidget(
                        textVerticalPadding:
                        AppReference.isPortrait(context) ? 2 : 6,
                        buttonColor: AppColors.primaryColor,
                        labelColor: AppColors.white,
                        isExpanded: true,
                        label: "نعم",
                        borderColor: AppColors.primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                          onPressedYes();
                        }),
                  ),
                  AppSize.s10.sizedBoxWidth,
                  Expanded(
                    child: DefaultButtonWidget(
                        textVerticalPadding:
                        AppReference.isPortrait(context) ? 2 : 6,
                        buttonColor: AppColors.primaryColor,
                        labelColor: AppColors.white,
                        isExpanded: true,
                        label: "لا",
                        borderColor: AppColors.primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                          onPressedNo();
                        }),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
class SimulatedTimeOutDialog extends StatelessWidget {
  final Function() onPressed;
  const SimulatedTimeOutDialog({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          )),
      content: Container(
        width: !AppReference.isPortrait(context)
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context) * .8,
        padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
            BorderRadius.circular(AppConstants.appBorderRadiusR10)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "عذراً !",
                    style: AppTextStyle().w700.titleMedium20,
                  )),
              AppSize.s20.sizedBoxHeight,
              SvgPicture.asset(AppIconsAssets.sNafeesTimeOut),
              AppSize.s20.sizedBoxHeight,
              Text("لقد انتهي الوقت المحدد للاختبار !",
                  textAlign: TextAlign.center,
                  style: const AppTextStyle()
                      .balooBhaijaan2
                      .black
                      .w700
                      .bodyLarge16),
              AppSize.s20.sizedBoxHeight,
              DefaultButtonWidget(
                  textVerticalPadding:
                  AppReference.isPortrait(context) ? 2 : 6,
                  buttonColor: AppColors.primaryColor,
                  labelColor: AppColors.white,
                  isExpanded: true,
                  label: "حسنا",
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed();
                  }),
            ]),
      ),
    );
  }
}

class SimulatedPieceDialog extends StatelessWidget {
  final String piece;
  const SimulatedPieceDialog({super.key, required this.piece});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          )),
      content: Container(
        width: !AppReference.isPortrait(context)
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context)*.8,
        padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
            BorderRadius.circular(AppConstants.appBorderRadiusR10)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CustomInkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppIconsAssets.sDeleteNotification,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIconsAssets.sNafeesTextFile),
                  AppSize.s10.sizedBoxWidth,
                  Text(
                    "نص القطعة",
                      textAlign: TextAlign.center,
                      style: const AppTextStyle()
                          .balooBhaijaan2.black
                          .w500
                          .bodyLarge16),
                ],
              ),
              Divider(
                color: AppColors.primaryColor2,
                thickness: 2,
              ),
              AppSize.s20.sizedBoxHeight,
              Text(
                piece,
                  textAlign: TextAlign.center,
                  style: const AppTextStyle()
                      .balooBhaijaan2.black
                      .w400
                      .bodyMedium14),
            ]),
      ),
    );
  }
}