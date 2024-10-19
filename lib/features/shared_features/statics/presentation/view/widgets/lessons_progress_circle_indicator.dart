part of '../../../statics.dart';


class LessonsProgressCircleIndicator extends StatelessWidget {
  final int totalLessons;
  final int finishedLessons;

  const LessonsProgressCircleIndicator({
    super.key,
    required this.totalLessons,
    required this.finishedLessons,
  });

  double calculatePercentage() {
    if (totalLessons == 0) {
      return 0.0;
    }
    return  ( finishedLessons / totalLessons).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:AppReference.deviceIsTablet&&!AppReference.isPortrait(context)? AppReference.deviceHeight(context) * 0.14.responsiveHeightRatio:AppReference.deviceHeight(context) * 0.25.responsiveHeightRatio,
      child: FittedBox(
        child: CircularPercentIndicator(
          radius: AppReference.deviceHeight(context) * 0.22.responsiveHeightRatio,
          lineWidth: AppReference.deviceIsTablet?20.responsiveSize:12.responsiveSize,
          backgroundColor: AppColors.textColor6,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          percent: calculatePercentage(),
          center: RichText(
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            text: TextSpan(
                text: '$totalLessons / ',
                style: AppReference.themeData.textTheme.titleLarge!
                    .copyWith(
                  fontSize: AppFontSize.sp40.responsiveFontSize,
                    fontWeight: AppFontWeight.semiBoldW600,
                    color: AppColors.textColor2),
                children: [
                  TextSpan(
                    text: '$finishedLessons\n',
                    style: AppReference.themeData.textTheme.titleLarge!
                        .copyWith(color: AppColors.secondaryColor2,
                      fontSize: AppFontSize.sp40.responsiveFontSize,
                      fontWeight: AppFontWeight.semiBoldW600,
                    ),
                  ),
                  TextSpan(
                    text: AppStrings.lesssonAchieve,
                      style: AppTextStyle.titleLarge22,
                  ),
                ]),
          ),
          progressColor: AppColors.successColor,
        ),
      ),
    );
  }
}
