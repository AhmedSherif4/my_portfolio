part of '../../../questions.dart';

class _PrimaryChildPortraitView extends StatefulWidget {
  final int currentQuestionNumber;
  final QuestionEntity currentQuestion;
  final bool showHint;
  final Function() reportQuestion;

  const _PrimaryChildPortraitView({
    required this.currentQuestion,
    required this.currentQuestionNumber,
    required this.showHint,
    required this.reportQuestion,
  });

  @override
  State<_PrimaryChildPortraitView> createState() =>
      _PrimaryChildPortraitViewState();
}

class _PrimaryChildPortraitViewState extends State<_PrimaryChildPortraitView> {
  final _formKey = GlobalKey<FormState>();

  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.responsiveWidth),
      child: Column(
        children: [
          _HeaderForQuestions(reportQuestion: widget.reportQuestion),
          _LinearProgressStep(
              progressStep: (widget.currentQuestionNumber /
                  context.read<QuestionsBloc>().allQuestions.length)),
          AppSize.s10.sizedBoxHeight,

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  _CountQuestions(
                      target: context.read<QuestionsBloc>().allQuestions.length,
                      count: widget.currentQuestionNumber),
                  CarProgressStep(
                    progressStep: (widget.currentQuestionNumber /
                        context.read<QuestionsBloc>().allQuestions.length),
                  ),
                  if (widget.currentQuestion.questionType == null)
                    AppSize.s40.sizedBoxHeight,
                  if (widget.currentQuestion.questionType != null)...[
                    QuestionItem(currentQuestion: widget.currentQuestion),
                    AppSize.s10.sizedBoxHeight
                  ],

                  QuestionTextWidget(
                    questionBackgroundColor: AppColors.quranColor.withOpacity(.2),
                    showHint: widget.showHint,
                    currentQuestion: widget.currentQuestion,
                  ),
                  AppSize.s16.sizedBoxHeight,

                  if (widget.currentQuestion.questionType == null)
                    AppSize.s40.sizedBoxHeight,
                  _AnswersSide(currentQuestion: widget.currentQuestion),

                ],
              ),
            ),
          ),
          AppSize.s10.sizedBoxHeight,
          BlocSelector<QuestionsBloc, QuestionsState, QuestionsStates>(
            selector: (state) => state.questionsStates,
            builder: (context, state) {
              if (state != QuestionsStates.answeredFromFirstTry) {
                return Bounce(
                  duration: const Duration(milliseconds: 200),
                  animate: state == QuestionsStates.wrongAnswer,
                  child: DefaultButtonWidget(
                    label: AppStrings.submission,
                    textVerticalPadding: AppPadding.p12,
                    width: 200,
                    textStyle: const AppTextStyle().white.w500.bodyLarge16,
                    onPressed: () {
                      if (widget.currentQuestion.select1Type ==
                              AppKeys.textFieldKey &&
                          _formKey.currentState!.validate()) {
                        context.read<QuestionsBloc>().add(
                            TheSelectedAnswerIsTextField(
                                answer: _answerController.text));
                      } else if (widget.currentQuestion.select1Type !=
                              AppKeys.textFieldKey &&
                          context
                                  .read<QuestionsBloc>()
                                  .state
                                  .selectedAnswerIndex !=
                              0) {
                        context
                            .read<QuestionsBloc>()
                            .add(const CheckAnswer());
                      }
                    },
                    borderColor: AppColors.primaryColor,
                    buttonColor: AppColors.primaryColor,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          AppSize.s10.sizedBoxHeight,

        ],
      ),
    );
  }
}
