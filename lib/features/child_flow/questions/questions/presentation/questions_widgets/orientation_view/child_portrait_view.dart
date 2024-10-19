part of '../../../questions.dart';

class _ChildPortraitView extends StatefulWidget {
  final int currentQuestionNumber;
  final QuestionEntity currentQuestion;
  final bool showHint;
  final Function() reportQuestion;

  const _ChildPortraitView({
    required this.currentQuestion,
    required this.currentQuestionNumber,
    required this.showHint,
    required this.reportQuestion,
  });

  @override
  State<_ChildPortraitView> createState() => _ChildPortraitViewState();
}

class _ChildPortraitViewState extends State<_ChildPortraitView> {


  final _formKey = GlobalKey<FormState>();

  final _answerController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.responsiveWidth),
      child: Stack(
        children: [
          Column(
            children: [
              _HeaderForQuestions(reportQuestion: widget.reportQuestion),
              _LinearProgressStep(
                  progressStep: (widget.currentQuestionNumber /
                      context.read<QuestionsBloc>().allQuestions.length)),
              AppSize.s10.sizedBoxHeight,

              Expanded(child: SingleChildScrollView(child: Column(
                children: [

                  _CountQuestions(
                      target: context.read<QuestionsBloc>().allQuestions.length,
                      count: widget.currentQuestionNumber),
                  if (widget.currentQuestion.questionType == null)
                    AppSize.s40.sizedBoxHeight,
                  if (widget.currentQuestion.questionType != null)
                    QuestionItem(currentQuestion: widget.currentQuestion),
                  QuestionTextWidget(
                    showHint: widget.showHint,
                    currentQuestion: widget.currentQuestion,
                  ),
                  if (widget.currentQuestion.questionType == null)
                    AppSize.s40.sizedBoxHeight,
                  _AnswersSide(currentQuestion: widget.currentQuestion, isAdult: true),
                ]
              ),),),
              AppSize.s10.sizedBoxHeight,
              BlocSelector<QuestionsBloc, QuestionsState, QuestionsStates>(
                selector: (state) => state.questionsStates,
                builder: (context, state) {
                  if (state != QuestionsStates.answeredFromFirstTry) {
                    return Pulse(
                      duration: const Duration(milliseconds: 500),
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
          PositionedDirectional(
            top: AppReference.deviceHeight(context) * 0.3,
            start: AppReference.deviceWidth(context) * 0.1,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: WaterMarkWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
