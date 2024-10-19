part of '../challenge_screen.dart';

class _ChildChallengeTitleWidget extends StatelessWidget {
  const _ChildChallengeTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppPadding.p20.responsiveSize),
      alignment: Alignment.center,
      width: 125.responsiveWidth,
      height: 31.responsiveHeightRatio,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
        ),
      ),
      child: Text(
        AppStrings.challenges,
        style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
          color: AppColors.textColor2,
        ),
      ),
    );
  }
}
