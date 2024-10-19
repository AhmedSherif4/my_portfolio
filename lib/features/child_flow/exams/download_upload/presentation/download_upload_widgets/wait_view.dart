part of '../../download_upload.dart';

class WaitView extends StatelessWidget {
  final bool isPrimary;

  const WaitView({
    super.key,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSize.s50.sizedBoxHeight,
          SvgPicture.asset(
            isPrimary
                ? AppImagesAssets.sSolveProblems
                : AppImagesAssets.sWaitingViewAdult,
            width: 110.responsiveWidth,
            height: 150.responsiveHeight,
          ).animateScaleNFadeHorizontal(),
          AppSize.s20.sizedBoxHeight,
          Text(
            AppStrings.submittedTheTestAndItIsBeingGraded,
            style: AppReference.themeData.textTheme.titleSmall!.copyWith(
              color: isPrimary ? AppColors.primaryColor2 : AppColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
