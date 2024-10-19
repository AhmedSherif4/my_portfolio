part of '../../download_upload.dart';

class _TitleWidget extends StatelessWidget {
  final bool isPrimary;
  final String title;

  const _TitleWidget({
    required this.title,
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
          padding: EdgeInsets.all(AppPadding.p6.responsiveSize),
          alignment: Alignment.center,
          height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
          width: AppReference.deviceIsTablet ?AppReference.deviceWidth(context) * 0.2:AppReference.deviceWidth(context) * 0.5,
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
          child: FittedBox(
            child: Text(
              title,
              style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                color: AppColors.textColor2,
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          isPrimary
              ? AppImagesAssets.sExamChallenge
              : AppImagesAssets.sExamAdultChallenge,
          height: 31.responsiveHeight,
        )
      ],
    );
  }
}
