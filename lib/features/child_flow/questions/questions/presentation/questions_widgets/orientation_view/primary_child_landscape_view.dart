part of '../../../questions.dart';

class _PrimaryChildLandscapeView extends StatelessWidget {
  final QuestionEntity currentQuestion;
  final int currentQuestionNumber;
  final bool showHint;
  final Function() reportQuestion;

  const _PrimaryChildLandscapeView({
    required this.currentQuestion,
    required this.currentQuestionNumber,
    required this.showHint,
    required this.reportQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderForQuestions(
          reportQuestion: reportQuestion,
        ).paddingBody(bottom: 0, top: 0),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PrimaryChildRightSide(
                currentQuestionNumber: currentQuestionNumber,
                currentQuestion: currentQuestion,
                showHint: showHint,
              ),
              _PrimaryChildLeftSide(currentQuestion: currentQuestion),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrimaryChildRightSide extends StatelessWidget {
  final int currentQuestionNumber;
  final bool showHint;
  final QuestionEntity currentQuestion;

  const _PrimaryChildRightSide({
    required this.currentQuestionNumber,
    required this.showHint,
    required this.currentQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 5.responsiveWidth),
      width: AppReference.deviceWidth(context) * 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppReference.deviceHeight(context) * 0.08,
              width: AppReference.deviceWidth(context) * 0.5,
              child: LayoutBuilder(builder: (context, consRow) {
                return Row(
                  children: [
                    SizedBox(
                      width: consRow.maxWidth * 0.85,
                      height: consRow.maxHeight * 0.4,
                      child: _LinearProgressStep(
                        progressStep: (currentQuestionNumber /
                            context.read<QuestionsBloc>().allQuestions.length),
                      ),
                    ),
                    SizedBox(
                      width: consRow.maxWidth * 0.15,
                      height: consRow.maxHeight,
                      child: _CountQuestions(
                          target:
                              context.read<QuestionsBloc>().allQuestions.length,
                          count: currentQuestionNumber),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: AppReference.deviceHeight(context) * 0.15,
              child: CarProgressStep(
                progressStep: (currentQuestionNumber /
                    context.read<QuestionsBloc>().allQuestions.length),
              ),
            ),
            if (currentQuestion.questionType == null)
              AppSize.s40.sizedBoxHeight,
            if (currentQuestion.questionType != null)
              QuestionItem(currentQuestion: currentQuestion),
            QuestionTextWidget(
              showHint: showHint,
              currentQuestion: currentQuestion,
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryChildLeftSide extends StatelessWidget {
  final QuestionEntity currentQuestion;

  const _PrimaryChildLeftSide({required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.responsiveWidth),
        width: AppReference.deviceWidth(context) * 0.5,
        child: _AnswersSide(currentQuestion: currentQuestion),
      ),
    );
  }
}
