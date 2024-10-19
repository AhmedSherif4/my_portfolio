part of '../../questions.dart';

class _LinearProgressStep extends StatelessWidget {
  final double progressStep;

  const _LinearProgressStep({required this.progressStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: AppPadding.p8.responsiveWidth,
      ),
      width: double.infinity,
      height: 10.responsiveHeight,
      decoration: BoxDecoration(
          color: AppColors.textColor6,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR10.responsiveSize)),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progressStep,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.successColor,
              borderRadius: BorderRadius.circular(
                  AppConstants.appBorderRadiusR10.responsiveSize)),
        ),
      ),
    );
  }
}
