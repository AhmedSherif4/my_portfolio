part of '../../questions.dart';

class QuestionItem extends StatelessWidget {
  final QuestionEntity currentQuestion;

  const QuestionItem({
    super.key,
    required this.currentQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      child: LayoutBuilder(
        builder: (context, constraints) => CustomPaint(
          painter: TVPainter(),
          child: Align(
            alignment: const Alignment(0, -0.6),
            child: SizedBox(
              width: constraints.maxWidth * 0.932,
              height: constraints.maxHeight * 0.679,
              child:
                GetQuestionType(
                  constraints: constraints,
                  currentQuestion: currentQuestion,
                ),
            ),
          ),
        ),
      ),
    );
  }
}

class GetQuestionType extends StatelessWidget {
  final BoxConstraints constraints;
  final QuestionEntity currentQuestion;

  const GetQuestionType(
      {super.key, required this.currentQuestion, required this.constraints});

  @override
  Widget build(BuildContext context) {
    if (currentQuestion.questionFile == null ||
        currentQuestion.questionFile!.isEmpty ||
        currentQuestion.questionFile == '') {
      return const Center(
        child: Text(
          AppStrings.readAndAnswerTheQuestion,
        ),
      );
    } else {
      return switch (currentQuestion.questionType) {
        AppKeys.audioKey => AudioPlayerWidget(
            source: EndPoints.imagePath(currentQuestion.questionFile!),
          ),
        AppKeys.imageKey =>
            Stack(
              children: [
                BaseCachedNetworkImage(
                  width: constraints.maxWidth * 0.932,
                  height: constraints.maxHeight * 0.679,
                  imgUrl: EndPoints.imagePath(currentQuestion.questionFile!),
                  fit: BoxFit.contain,
                ),
                PositionedDirectional(
                  start: 18.responsiveSize,
                  top: 2.responsiveSize,
                  child:MyPopImage(
                      image:currentQuestion.questionFile!,
                      tappedWidget: Container(
                        padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR10),
                        ),
                        child: Icon(
                          Icons.zoom_out_map_outlined,
                          color: AppColors.primaryColor,
                          size: AppSize.s20.responsiveSize,
                        ),
                      ),
                      imageWidget: BaseCachedNetworkImage(
                        width: constraints.maxWidth * 0.932,
                        height: constraints.maxHeight * 0.679,
                        imgUrl: EndPoints.imagePath(currentQuestion.questionFile!),
                        fit: BoxFit.contain,
                      )
                  ), )

              ],
            ),

        AppKeys.videoKey => VideoWidget(
            source: EndPoints.imagePath(currentQuestion.questionFile!),
            reachedTheEnd: () {},
          ),
        null => const Center(
            child: Text(
              AppStrings.readAndAnswerTheQuestion,
            ),
          ),
        String() => const Center(
            child: Text(
              AppStrings.readAndAnswerTheQuestion,
            ),
          ),
      };
    }
  }
}



class QuestionItemForNafees extends StatelessWidget {
  final NafeesQuestionEntity currentQuestion;

  const QuestionItemForNafees({
    super.key,
    required this.currentQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      child: LayoutBuilder(
        builder: (context, constraints) => CustomPaint(
          painter: TVPainter(),
          child: Align(
            alignment: const Alignment(0, -0.6),
            child: SizedBox(
              width: constraints.maxWidth * 0.932,
              height: constraints.maxHeight * 0.679,
              child:
              GetQuestionTypeForNafees(
                  constraints: constraints,
                  currentQuestion: currentQuestion,
                ),
            ),
          ),
        ),
      ),
    );
  }
}

class GetQuestionTypeForNafees extends StatelessWidget {
  final BoxConstraints constraints;
  final NafeesQuestionEntity currentQuestion;

  const GetQuestionTypeForNafees(
      {super.key, required this.currentQuestion, required this.constraints});

  @override
  Widget build(BuildContext context) {
    if (currentQuestion.img == null ||
        currentQuestion.img!.isEmpty ||
        currentQuestion.img == '') {
      return const Center(
        child: Text(
          AppStrings.readAndAnswerTheQuestion,
        ),
      );
    } else {
      return Stack(
        children: [
          BaseCachedNetworkImage(
            width: constraints.maxWidth * 0.932,
            height: constraints.maxHeight * 0.679,
            imgUrl: EndPoints.imagePath(currentQuestion.img!),
            fit: BoxFit.contain,
          ),
          PositionedDirectional(
            start: 18.responsiveSize,
            top: 2.responsiveSize,
            child:MyPopImage(
                image:currentQuestion.img!,
                tappedWidget: Container(
                  padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR10),
                  ),
                  child: Icon(
                    Icons.zoom_out_map_outlined,
                    color: AppColors.primaryColor,
                    size: AppSize.s20.responsiveSize,
                  ),
                ),
                imageWidget: BaseCachedNetworkImage(
                  width: constraints.maxWidth * 0.932,
                  height: constraints.maxHeight * 0.679,
                  imgUrl: EndPoints.imagePath(currentQuestion.img!),
                  fit: BoxFit.contain,
                )
            ), )

        ],
      );
    }
  }
}




class QuestionItemForSimulated extends StatelessWidget {
  final SimulatedQuestionEntity currentQuestion;

  const QuestionItemForSimulated({
    super.key,
    required this.currentQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      child: LayoutBuilder(
        builder: (context, constraints) => CustomPaint(
          painter: TVPainter(),
          child: Align(
            alignment: const Alignment(0, -0.6),
            child: SizedBox(
              width: constraints.maxWidth * 0.932,
              height: constraints.maxHeight * 0.679,
              child:
              GetQuestionTypeForSimulated(
                constraints: constraints,
                currentQuestion: currentQuestion,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GetQuestionTypeForSimulated extends StatelessWidget {
  final BoxConstraints constraints;
  final SimulatedQuestionEntity currentQuestion;

  const GetQuestionTypeForSimulated(
      {super.key, required this.currentQuestion, required this.constraints});

  @override
  Widget build(BuildContext context) {
    if (currentQuestion.img == null ||
        currentQuestion.img!.isEmpty ||
        currentQuestion.img == '') {
      return const Center(
        child: Text(
          AppStrings.readAndAnswerTheQuestion,
        ),
      );
    } else {
      return Stack(
        children: [
          BaseCachedNetworkImage(
            width: constraints.maxWidth * 0.932,
            height: constraints.maxHeight * 0.679,
            imgUrl: EndPoints.imagePath(currentQuestion.img!),
            fit: BoxFit.contain,
          ),
          PositionedDirectional(
            start: 18.responsiveSize,
            top: 2.responsiveSize,
            child:MyPopImage(
                image:currentQuestion.img!,
                tappedWidget: Container(
                  padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR10),
                  ),
                  child: Icon(
                    Icons.zoom_out_map_outlined,
                    color: AppColors.primaryColor,
                    size: AppSize.s20.responsiveSize,
                  ),
                ),
                imageWidget: BaseCachedNetworkImage(
                  width: constraints.maxWidth * 0.932,
                  height: constraints.maxHeight * 0.679,
                  imgUrl: EndPoints.imagePath(currentQuestion.img!),
                  fit: BoxFit.contain,
                )
            ), )

        ],
      );
    }
  }
}