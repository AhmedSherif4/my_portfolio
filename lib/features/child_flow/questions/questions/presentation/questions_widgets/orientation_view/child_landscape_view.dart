part of '../../../questions.dart';

class _ChildLandscapeView extends StatelessWidget {
  final QuestionEntity currentQuestion;
  final int currentQuestionNumber;
  final bool showHint;
  final Function() reportQuestion;

  const _ChildLandscapeView({
    required this.currentQuestion,
    required this.currentQuestionNumber,
    required this.showHint,
    required this.reportQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeaderForQuestions(
            reportQuestion: reportQuestion,
          ).paddingBody(bottom: 0, top: 0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ChildRightSide(
                  currentQuestionNumber: currentQuestionNumber,
                  currentQuestion: currentQuestion,
                  showHint: showHint,
                ),
              ),
              Expanded(child: _ChildLeftSide(currentQuestion: currentQuestion)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChildRightSide extends StatelessWidget {
  final int currentQuestionNumber;
  final QuestionEntity currentQuestion;
  final bool showHint;

  const _ChildRightSide({
    required this.currentQuestionNumber,
    required this.currentQuestion,
    required this.showHint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: AppPadding.p4.responsiveWidth),
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
            if (currentQuestion.questionType == null) AppSize.s40.sizedBoxHeight,
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

class _ChildLeftSide extends StatelessWidget {
  final QuestionEntity currentQuestion;

  const _ChildLeftSide({required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.responsiveWidth),
      width: AppReference.deviceWidth(context) * 0.5,
      child: _AnswersSide(currentQuestion: currentQuestion, isAdult: true),
    );
  }
}
