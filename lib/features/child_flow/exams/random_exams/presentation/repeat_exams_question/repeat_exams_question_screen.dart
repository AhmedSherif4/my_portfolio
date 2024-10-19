part of'../../random_exams.dart';


class RepeatQuestionScreen extends StatefulWidget {
  final DataToGoExams dataToGoExams;
  const RepeatQuestionScreen({
    super.key, required this.dataToGoExams,
  });

  @override
  State<RepeatQuestionScreen> createState() => _RepeatQuestionScreenState();
}

class _RepeatQuestionScreenState extends State<RepeatQuestionScreen> {
  late final PageController pageController;
  bool exit = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      onPopInvoked: (value) async {
        if (!value) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return  RandamExamsBackDialouge(dataToGoExams:  widget.dataToGoExams);
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
                                    return  RandamExamsBackDialouge(dataToGoExams:  widget.dataToGoExams);
                                  });
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ).paddingBody(),
                BlocConsumer<RandomExamsBloc, RandomExamsState>(
                  listener: (context, state) {
                    switch (
                        state.addRandomExamsQuestionsAndAnswersRequestState) {
                      case RequestStates.loading:
                        showLoadingDialog(context);
                        break;
                      case RequestStates.loaded:
                        Navigator.pop(context);
                        showSnackBar(
                          description:
                              ' أحسنت لقد أنهيت هذه الأسئلة بنجاح\nالنقاط التي حصلت عليها هي( ${state.result} ) ',
                          state: ToastStates.congrats,
                          context: context,
                        );
                        if(AppReference.childIsPrimary()){
                        RouteManager.rPushNamedAndRemoveUntil(
                          context: context,
                          rName: AppRoutesNames.rPrimaryChildRandomExamsScreen,
                          arguments: widget.dataToGoExams,
                        );}else{
                          RouteManager.rPushNamedAndRemoveUntil(
                            context: context,
                            rName: AppRoutesNames.rChildRandomExamsScreen,
                            arguments: widget.dataToGoExams,
                          );
                        }
                        break;
                      case RequestStates.error:
                        Navigator.pop(context);
                        showSnackBar(
                          description: state
                              .addRandomExamsQuestionsAndAnswersErrorMessage,
                          state: ToastStates.error,
                          context: context,
                        );
                        Navigator.pop(context);
                        break;
                      default:
                        break;
                    }
                  },
                  builder: (context, state) {
                    switch (state.repeatedRandomExamsRequestState) {
                      case RequestStates.loading:
                        return const LoadingShimmerList();
                      case RequestStates.loaded:
                        return Expanded(
                          child: PageView.builder(
                            itemCount: state.createdRandomExam.questions.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: pageController,
                            itemBuilder: (pageViewContext, questionIndex) {
                              //ToDo: refactor this section
                              submit() {
                                if (questionIndex <
                                    state.createdRandomExam.questions.length -
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
                                          state.createdRandomExam.questions
                                              .length;
                                      i++) {
                                    if (!context
                                        .read<RandomExamsBloc>()
                                        .state
                                        .selectedAnswers
                                        .containsKey(state
                                            .createdRandomExam.questions[i].id
                                            .toString())) {
                                      unsolvedQuestions.add(i + 1);
                                    }
                                  }

                                  if (unsolvedQuestions.isNotEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CompleteQuestionDialoug(
                                                unsolvedQuestions:
                                                    unsolvedQuestions));
                                    return;
                                  }
                                  BlocProvider.of<RandomExamsBloc>(context)
                                      .add(AddRandomExamsQuestionsAndAnswers(
                                    randomExamQuestionsAnswersInputs:
                                        RandomExamQuestionsAnswersInputs(
                                            examId: state.createdRandomExam.id
                                                .toString(),
                                            questions: context
                                                .read<RandomExamsBloc>()
                                                .state
                                                .selectedAnswers
                                                .entries
                                                .map((entry) =>
                                                    RandomExamsQuestions(
                                                        questionId: entry.key,
                                                        childAnswer:
                                                            entry.value))
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
                                      //! Question Count Circle
                                      SizedBox(
                                        height:
                                            AppReference.deviceHeight(context) *
                                                0.05,
                                        width:
                                            AppReference.deviceWidth(context),
                                        child: Center(
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (listViewContext, index) =>
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
                                                        color: questionIndex ==
                                                                index
                                                            ? AppColors.white
                                                            : AppColors
                                                                .textColor4,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            separatorBuilder:
                                                (listViewContext, index) =>
                                                    AppSize.s6.sizedBoxWidth,
                                            itemCount: state.createdRandomExam
                                                .questions.length,
                                          ),
                                        ),
                                      ).paddingBody(),

                                      Expanded(
                                        child: ListView(
                                          children: [
                                            //! Question Type
                                            if (state
                                                    .createdRandomExam
                                                    .questions[questionIndex]
                                                    .questionType !=
                                                null) ...[
                                              QuestionItem(
                                                  currentQuestion: state
                                                          .createdRandomExam
                                                          .questions[
                                                      questionIndex]),
                                            ],
                                            //! Question Text
                                            QuestionTextWidget(
                                              showHint: false,
                                              currentQuestion: state
                                                  .createdRandomExam
                                                  .questions[questionIndex],
                                            ),
                                            //! Answers
                                            AnswerBuilderForTeacher(
                                              currentQuestion: state
                                                  .createdRandomExam
                                                  .questions[questionIndex],
                                              isAdult: true,
                                            ),
                                          ],
                                        ).paddingBody(),
                                      ),

                                      //! Footer Buttons Submit and Previous
                                      SizedBox(
                                        height:
                                            AppReference.deviceHeight(context) *
                                                0.09,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(5.responsiveSize),
                                          child: Row(children: [
                                            Expanded(
                                                flex: 2,
                                                child: DefaultButtonWidget(
                                                  label: AppStrings.previous,
                                                  buttonColor:
                                                      AppColors.primaryColor,
                                                  onPressed: previous,
                                                )),
                                            AppSize.s10.sizedBoxWidth,
                                            Expanded(
                                                flex: 5,
                                                child: DefaultButtonWidget(
                                                    label: state
                                                                .createdRandomExam
                                                                .questions
                                                                .last ==
                                                            state.createdRandomExam
                                                                    .questions[
                                                                questionIndex]
                                                        ? AppStrings.submit
                                                        : AppStrings.next,
                                                    onPressed: submit)),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  landscapeWidget: Column(
                                    children: [
                                      //! Question Count Circle
                                      SizedBox(
                                        height:
                                            AppReference.deviceHeight(context) *
                                                0.05,
                                        width:
                                            AppReference.deviceWidth(context),
                                        child: Center(
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (listViewContext, index) =>
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
                                                        color: questionIndex ==
                                                                index
                                                            ? AppColors.white
                                                            : AppColors
                                                                .textColor4,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            separatorBuilder:
                                                (listViewContext, index) =>
                                                    AppSize.s6.sizedBoxWidth,
                                            itemCount: state.createdRandomExam
                                                .questions.length,
                                          ),
                                        ),
                                      ).paddingBody(),

                                      Expanded(
                                        child: Row(
                                          children: [
                                            //! Question Type
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    if (state
                                                            .createdRandomExam
                                                            .questions[
                                                                questionIndex]
                                                            .questionType !=
                                                        null) ...[
                                                      QuestionItem(
                                                          currentQuestion: state
                                                                  .createdRandomExam
                                                                  .questions[
                                                              questionIndex]),
                                                    ],
                                                    //! Question Text
                                                    QuestionsText(
                                                      currentQuestion: state
                                                              .createdRandomExam
                                                              .questions[
                                                          questionIndex],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //! Answers
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: AnswerBuilderForTeacher(
                                                  currentQuestion: state
                                                      .createdRandomExam
                                                      .questions[questionIndex],
                                                  isAdult: true,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ).paddingBody(),
                                      ),

                                      //! Footer Buttons Submit and Previous
                                      NextAndPreviousRandomExams(
                                          submit: submit,
                                          previous: previous,
                                          isLastQuestion: state
                                                  .createdRandomExam
                                                  .questions
                                                  .last ==
                                              state.createdRandomExam
                                                  .questions[questionIndex])
                                    ],
                                  ));
                            },
                          ),
                        );

                      case RequestStates.error:
                        return ErrorWidget(
                          state.createRandomExamsErrorMessage,
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
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

class CompleteQuestionDialoug extends StatelessWidget {
  const CompleteQuestionDialoug({
    super.key,
    required this.unsolvedQuestions,
  });

  final List<int> unsolvedQuestions;

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
        width: AppReference.deviceIsTablet
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
              "تنبيه",
              style: AppReference.themeData.textTheme.displaySmall!.copyWith(
                color: AppColors.failColor,
                fontWeight: AppFontWeight.regular2W500,
              ),
            ),
            const Divider(color: AppColors.textColor6, thickness: 2),
            const Spacer(),
            Text(
              "من فضلك قم بحل جميع الأسئلة: ${unsolvedQuestions.join(", ")}",
              style: const AppTextStyle().s16.titleLarge22,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            DefaultButtonWidget(
                label: 'حسنا',
                textVerticalPadding: 0,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

class RandamExamsBackDialouge extends StatelessWidget {
  final DataToGoExams dataToGoExams;
  const RandamExamsBackDialouge({
    super.key, required this.dataToGoExams,
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
      content: BlocProvider(
        create: (context) => getIt<SharedSubjectsBloc>()
          ..add(GetSharedSubjectsEvent(
              parameter: ParameterGoToQuestions(
                  systemId:
                      getIt<UserLocalDataSource>().getUserData()!.systemId!,
                  stageId: getIt<UserLocalDataSource>().getUserData()!.stageId!,
                  classRoomId: getIt<UserLocalDataSource>().getUserData()!.classroomId!,
                  termId: getIt<UserLocalDataSource>().getUserData()!.termId!,
                  pathId: getIt<UserLocalDataSource>().getUserData()!.pathId!,
                  subjectType: SubjectType.subscriptions))),
        child: Container(
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
                  BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                    builder: (context, state) {
                      return Expanded(
                        child: DefaultButtonWidget(
                            label: 'حسنا',
                            textVerticalPadding: AppReference.isPortrait(context) ?0 :6,
                            onPressed: () {
                              Navigator.pop(context);
                              if (AppReference.childIsPrimary()) {
                                Navigator.pop(context);
                                RouteManager.rPushNamedAndRemoveUntil(
                                  context: context,
                                  rName: AppRoutesNames
                                      .rPrimaryChildRandomExamsScreen,
                                  arguments: dataToGoExams,

                                  // DataToGoExams(
                                  //   subjects: state.subjects,
                                  //   isPrimary: AppReference.childIsPrimary(),
                                  //   user: getIt<UserLocalDataSource>().getUserData()!,
                                  // ),
                                );
                              } else {
                                Navigator.pop(context);
                                RouteManager.rPushReplacementNamed(
                                  context: context,
                                  rName: AppRoutesNames.rChildRandomExamsScreen,
                                  arguments: dataToGoExams
                                  // DataToGoExams(
                                  //   subjects: state.subjects,
                                  //   isPrimary: AppReference.childIsPrimary(),
                                  //   user: getIt<UserLocalDataSource>().getUserData()!,
                                  // ),
                                );
                              }
                            }),
                      );
                    },
                  ),
                  AppSize.s10.sizedBoxWidth,
                  Expanded(
                    child: DefaultButtonWidget(
                      textVerticalPadding: AppReference.isPortrait(context) ?0 :6,
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
      ),
    );
  }
}

class QuestionsText extends StatelessWidget {
  final QuestionEntity currentQuestion;

  const QuestionsText({super.key, required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppReference.isPortrait(context)
          ? AppReference.deviceWidth(context) * 0.9
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
        currentQuestion.questionText ?? AppStrings.tryLater,
        textAlign: TextAlign.center,
        textDirection: AppConstants.arabicDirection(
            currentQuestion.questionText ?? AppStrings.tryLater),
        style: AppReference.detectStringType(
                    currentQuestion.questionText ?? AppStrings.tryLater) ==
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
