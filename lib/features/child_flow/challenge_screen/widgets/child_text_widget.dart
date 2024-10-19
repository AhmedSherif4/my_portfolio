part of '../challenge_screen.dart';

class _TextWidget extends StatelessWidget {
  const _TextWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p8.responsiveSize,
      ),
      alignment: Alignment.center,
      width: AppReference.deviceWidth(context) * 0.7,
      //height: 35.responsiveHeightRatio,
      decoration: ShapeDecoration(
        color: AppColors.quranColor.withOpacity(.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
        ),
      ),
      child: Text(
        AppStrings.collectPointsAndConfirmYourValuableInformation,
        style: AppReference.themeData.textTheme.bodyMedium!.copyWith(
          color: AppColors.textColor2,
        ),
      ),
    );
  }
}
