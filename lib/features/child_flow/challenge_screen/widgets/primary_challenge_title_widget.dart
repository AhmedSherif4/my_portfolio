part of '../challenge_screen.dart';

class PrimaryChallengeTitleWidget extends StatelessWidget {
  const PrimaryChallengeTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppPadding.p20.responsiveSize),
      alignment: Alignment.center,
      width: AppReference.deviceWidth(context) * 0.35,
      height: 50.responsiveHeight ,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
        ),
      ),
      child: Text(
        AppStrings.challenges,
        style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
          color: AppColors.primaryColor2,
        ),
      ),
    );
  }
}
