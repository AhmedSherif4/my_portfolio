part of '../../../statics.dart';

class SkillsQuestionScreen extends StatefulWidget {
  final GetFailsSkillsWithQuestionsParameters getFailsSkillsWithQuestionsParameters;
  // final FailsSkillsForLessonsModel questionsFails;
  const SkillsQuestionScreen({
    super.key,
    required this.getFailsSkillsWithQuestionsParameters,
  });

  @override
  State<SkillsQuestionScreen> createState() => _SkillsQuestionScreenState();
}

class _SkillsQuestionScreenState extends State<SkillsQuestionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (value) {
            RouteManager.rPushReplacementNamed(
                context: context,
                rName: AppRoutesNames.rFailsSuccessSkillsScreen,
                arguments: widget.getFailsSkillsWithQuestionsParameters);
          },
          child: PageView.builder(
            itemCount: widget.getFailsSkillsWithQuestionsParameters.failQuestions!.questions.length,
            itemBuilder: (context, questionIndex) => Stack(
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
                                RouteManager.rPushReplacementNamed(
                                    context: context,
                                    rName: AppRoutesNames
                                        .rFailsSuccessSkillsScreen,
                                    arguments: widget.getFailsSkillsWithQuestionsParameters);
                              },
                            ),
                          ],
                        );
                      }),
                    ).paddingBody(),
                    BlocListener<SkillStaticsBloc, SkillStaticsState>(
                      listener: (context, state) {
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
                            widget.getFailsSkillsWithQuestionsParameters.failQuestions!.questions.removeAt(questionIndex);

                            if (widget.getFailsSkillsWithQuestionsParameters.failQuestions!.questions.isEmpty) {
                              RouteManager.rPushNamedAndRemoveUntil(
                                context: context,
                                rName: AppRoutesNames.rFailsSkillsScreen,
                                arguments: widget.getFailsSkillsWithQuestionsParameters,
                              );

                            } else {
                              if(mounted){
                              setState(() {});
                              }
                            }
                            showSnackBar(
                              description: 'لقد قمت بحل المهارات الخاصة بك بنجاح',
                              state: ToastStates.congrats,
                              context: context,
                            );
                          default:
                        }

                        switch (state.questionsStates) {
                          case QuestionsStates.questionDone:
                            context.read<SkillStaticsBloc>().add(
                                  SendTheAnswerOfQuestionToServerFromSkills(
                                    SendTheAnswerOfQuestionParameter(
                                      systemId: 0,
                                      pathId: 0,
                                      stageId: 0,
                                      classroomId: 0,
                                      termId: 0,
                                      subjectId: 0,
                                      levelId: 0,
                                      groupId: 0,
                                      isGeneralQuestion: false,
                                      lessonId: 0,
                                      isLast: true,
                                      questionId: widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                          .questions[questionIndex].id,
                                      answerDuration: 2,
                                      triesTaken: 1,
                                      isFromNafees: false,
                                    ),
                                    widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                        .questions[questionIndex],
                                  ),
                                );

                          case QuestionsStates.wrongAnswer:
                            showSnackBar(
                              bottomPadding:
                                  AppReference.deviceHeight(context) * 0.11,
                              description: AppStrings.answerIsWrongTryAgain,
                              state: ToastStates.error,
                              context: context,
                            );

                          default:
                        }
                      },
                      child: Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  //! Question Type
                                  if (widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                          .questions[questionIndex]
                                          .questionType ==
                                      null)
                                    AppSize.s40.sizedBoxHeight,
                                  if (widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                          .questions[questionIndex]
                                          .questionType !=
                                      null)
                                    QuestionItem(
                                        currentQuestion: widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                            .questions[questionIndex]),
                                  //! Question Text
                                  QuestionTextWidget(
                                    showHint: context
                                        .read<SkillStaticsBloc>()
                                        .state
                                        .isHintShown,
                                    currentQuestion: widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                        .questions[questionIndex],
                                  ),
                                  if (widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                          .questions[questionIndex]
                                          .questionType ==
                                      null)
                                    AppSize.s40.sizedBoxHeight,
                                  //! Answers
                                  AnswerBuilderForSkills(
                                    currentQuestion: widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                        .questions[questionIndex],
                                    isAdult: true,
                                  ),
                                ],
                              ).paddingBody(),
                            ),

                            //! Footer Buttons Submit and Previous
                            SizedBox(
                              width: AppReference.deviceWidth(context) * 0.7,
                              child: DefaultButtonWidget(
                                label: AppStrings.submission,
                                textVerticalPadding: AppPadding.p12,
                                width: 200,
                                textStyle:
                                    const AppTextStyle().white.w500.bodyLarge16,
                                onPressed: () {
                                  context
                                      .read<SkillStaticsBloc>()
                                      .add(CheckAnswerForSkills(
                                        widget.getFailsSkillsWithQuestionsParameters.failQuestions!
                                            .questions[questionIndex],
                                      ));
                                },
                                borderColor: AppColors.primaryColor,
                                buttonColor: AppColors.primaryColor,
                              ),
                            ),
                            AppSize.s10.sizedBoxHeight,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                PositionedDirectional(
                  top: AppReference.deviceHeight(context) * 0.3,
                  start: AppReference.deviceWidth(context) * 0.1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Transform.rotate(
                      angle: AppReference.currentOrientation(context) ==
                              Orientation.portrait
                          ? 45
                          : 0,
                      child: Text(
                        getIt<UserLocalDataSource>().getUserData()!.username,
                        style: AppReference.themeData.textTheme.displayLarge!
                            .copyWith(
                          color: Colors.black.withOpacity(0.05),
                          fontSize: AppFontSize.sp50.responsiveFontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
