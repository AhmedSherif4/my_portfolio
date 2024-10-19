part of '../../questions.dart';

class QuestionTextWidget extends StatelessWidget {
  const QuestionTextWidget({super.key,
    required this.currentQuestion,
    required this.showHint,
    this.questionBackgroundColor = AppColors.white
  });

  final QuestionEntity currentQuestion;
  final bool showHint;
  final Color questionBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: !AppReference.isPortrait(context)?AppReference.deviceWidth(context) * 0.3:AppReference.deviceWidth(context) * 0.77,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 5.responsiveWidth,
            vertical:  AppPadding.p10.responsiveHeight,
          ),
          decoration: BoxDecoration(
            color: questionBackgroundColor,

            borderRadius: BorderRadius.circular(
                AppConstants.appBorderRadiusR25.responsiveSize),
          ),
          child: Text(
            currentQuestion.questionText ?? AppStrings.tryLater,
            textAlign: TextAlign.center,
            textDirection: AppConstants.arabicDirection(currentQuestion.questionText ?? AppStrings.tryLater),
            style:const AppTextStyle().white.w500.titleSmall18.copyWith(
              fontFamily: 'NewFont',
              color: Colors.black,
              fontSize: 16.responsiveFontSize,
            ),
            // style:AppConstants.quranStyle ,
          ),
        ),
        (AppReference.deviceWidth(context) * (AppReference.deviceIsTablet ? 0.001 : 0.007)).sizedBoxWidth,
        showHint
            ? SizedBox(
                width: AppReference.deviceWidth(context) * 0.08,
                height: AppReference.deviceHeight(context) *
                    0.07.responsiveHeightRatio,
                child: HintWidget(currentQuestion: currentQuestion),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class HintWidget extends StatelessWidget {
  const HintWidget({super.key,
    required this.currentQuestion,
  });

  final QuestionEntity currentQuestion;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        showHintOfQuestionsDialog(
            context: context,
            descriptionText: currentQuestion.descriptionText,
            descriptionType: currentQuestion.descriptionType,
            descriptionFile: currentQuestion.descriptionFile);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SvgPicture.asset(
              AppIconsAssets.sAdultHint,
              width: 25.responsiveSize,
              height: 25.responsiveSize,
            ),
          ),
          FittedBox(
            child: Text(
              AppStrings.hint,
              style: const AppTextStyle().w700.bodyMedium14.copyWith(
                fontFamily: 'NewFont',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
