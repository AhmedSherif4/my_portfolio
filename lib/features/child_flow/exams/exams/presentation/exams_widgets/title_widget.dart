part of '../../exams.dart';

class _TitleWidget extends StatelessWidget {
  final bool isPrimary;

  const _TitleWidget({
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: AppPadding.p20.responsiveSize,
            bottom: AppPadding.p20.responsiveSize,
            right: AppPadding.p20.responsiveSize,
          ),
          alignment: Alignment.center,
          width: AppReference.deviceIsTablet ?AppReference.deviceWidth(context) * 0.2:AppReference.deviceWidth(context) * 0.45,
          height: AppReference.deviceHeight(context) * 0.045.responsiveHeightRatio,
          decoration: ShapeDecoration(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize),
                bottomRight: Radius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize),
              ),
            ),
          ),
          child: Text(
            AppStrings.subjectsTests,
            style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
              color: AppColors.textColor2,
            ),
          ),
        ),
        SvgPicture.asset(
          isPrimary
              ? AppImagesAssets.sExamChallenge
              : AppImagesAssets.sExamAdultChallenge,
          height: 31.responsiveHeightRatio,
        )
      ],
    );
  }
}
