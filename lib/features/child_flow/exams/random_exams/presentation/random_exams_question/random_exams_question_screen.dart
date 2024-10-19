part of'../../random_exams.dart';


class RandomQuestionScreen extends StatefulWidget {
  final DataToGoExams dataToGoExams;
  const RandomQuestionScreen({
    required this.dataToGoExams,
    super.key,
  });

  @override
  State<RandomQuestionScreen> createState() => _RandomQuestionScreenState();
}

class _RandomQuestionScreenState extends State<RandomQuestionScreen> {
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
      if(!value) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return  RandamExamsBackDialouge(dataToGoExams: widget.dataToGoExams,);
            });}
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children:  [
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
                                    return  RandamExamsBackDialouge(dataToGoExams:  widget.dataToGoExams,);
                                  });
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ).paddingBody(),
            BlocListener<RandomExamsBloc, RandomExamsState>(
              listener: (context, state) {
                switch (
                state.addRandomExamsQuestionsAndAnswersRequestState) {
                  case RequestStates.loading:
                    showLoadingDialog(context);
                  case RequestStates.loaded:
                    RouteManager.rPopRoute(context);
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
                    }                  case RequestStates.error:
                    Navigator.pop(context);
                    showSnackBar(
                      description: state
                          .addRandomExamsQuestionsAndAnswersErrorMessage,
                      state: ToastStates.error,
                      context: context,
                    );
                    RouteManager.rPopRoute(context);
                  default:
                }
              },

              child: Expanded(
              child: PageView.builder(
                itemCount: widget.dataToGoExams.data!.questions.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemBuilder: (pageViewContext, questionIndex) {
                  //ToDo: refactor this section
                  submit() {
                    if (questionIndex < widget.dataToGoExams.data!.questions.length - 1) {pageController.animateToPage(
                        questionIndex + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                    else {
                      List<int> unsolvedQuestions = [];
                      for (int i = 0; i < widget.dataToGoExams.data!.questions.length; i++) {
                        if (!context.read<RandomExamsBloc>().state.selectedAnswers
                            .containsKey(widget.dataToGoExams.data!.questions[i].id.toString())) {
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

                      BlocProvider.of<RandomExamsBloc>(context).add(AddRandomExamsQuestionsAndAnswers(
                        randomExamQuestionsAnswersInputs:
                        RandomExamQuestionsAnswersInputs(
                            examId: widget.dataToGoExams.data!.id
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
                            height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
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
                                          duration:
                                          const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: questionIndex == index
                                            ? 20.responsiveSize
                                            : 15.responsiveSize,
                                        backgroundColor: questionIndex == index
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
                                separatorBuilder: (listViewContext, index) =>
                                AppSize.s6.sizedBoxWidth,
                                itemCount: widget.dataToGoExams.data!.questions.length,
                              ),
                            ),
                          ).paddingBody(),
                          Expanded(
                            child: ListView(
                              children: [
                                //! Question Type
                                if (widget.dataToGoExams.data!
                                    .questions[questionIndex]
                                    .questionType !=
                                    null) ...[
                                  QuestionItem(
                                      currentQuestion:widget.dataToGoExams.data!.questions[questionIndex]),
                                ],
                                //! Question Text
                                QuestionsText(currentQuestion:
                                  widget.dataToGoExams.data!.questions[questionIndex],
                                ),
                                //! Answers
                                AnswerBuilderForTeacher(
                                  currentQuestion:
                                  widget.dataToGoExams.data!.questions[questionIndex],
                                  isAdult: true,
                                ),
                              ],
                            ).paddingBody(),
                          ),
              
                          NextAndPreviousRandomExams(submit: submit, previous: previous, isLastQuestion: widget.dataToGoExams.data!.questions.last ==
                              widget.dataToGoExams.data!.questions[questionIndex]
                          )
              
                        ],
                      ),
                      landscapeWidget: Column(
                        children: [
                          //! Question Count Circle
                          SizedBox(
                            height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
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
                                          duration:
                                          const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: questionIndex == index
                                            ? 20.responsiveSize
                                            : 15.responsiveSize,
                                        backgroundColor: questionIndex == index
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
                                separatorBuilder: (listViewContext, index) =>
                                AppSize.s6.sizedBoxWidth,
                                itemCount: widget.dataToGoExams.data!.questions.length,
                              ),
                            ),
                          ).paddingBody(),
              
                          Expanded(
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  //! Question Type
                                  Expanded(
                                    child: Column(
                                      children: [
                                        if (widget.dataToGoExams.data!
                                            .questions[
                                        questionIndex]
                                            .questionType !=
                                            null) ...[
                                          QuestionItem(
                                              currentQuestion: widget.dataToGoExams.data!.questions[questionIndex]),
                                        ],
                                        //! Question Text
                                        QuestionsText(currentQuestion:
                                        widget.dataToGoExams.data!.questions[questionIndex],
                                        ),
                                      ],
                                    ),
                                  ),
                                  //! Answers
                                  Expanded(
                                    child:     AnswerBuilderForTeacher(
                                      currentQuestion:
                                      widget.dataToGoExams.data!.questions[questionIndex],
                                      isAdult: true,
                                    ),
                                  ),
                                ],
                              ).paddingBody(),
                            ),
                          ),
              
                          //! Footer Buttons Submit and Previous
                          NextAndPreviousRandomExams(submit: submit, previous: previous, isLastQuestion: widget.dataToGoExams.data!.questions.last ==
                              widget.dataToGoExams.data!
                                  .questions[questionIndex]
                          )
                        ],
                      ));
                },
              ),
            ),
),
            ],),

            PositionedDirectional(
              top: AppReference.deviceHeight(context) * 0.3,
              start: AppReference.deviceWidth(context) * 0.25,
              child: Transform.rotate(
                angle:  45,
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
  const NextAndPreviousRandomExams({super.key, required this.submit, required this.previous, required this.isLastQuestion});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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

                  label: isLastQuestion ? AppStrings.submit
                      : AppStrings.next,
                  onPressed: submit)),
        ]),
      ),
    );
  }
}
