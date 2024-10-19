part of 'more_widgets.dart';

class DefaultButtonWithIcon extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String svgIconPath;
  final Color backgroundColor;
  final Color textColor;
  final bool isDeleteButton;

  const DefaultButtonWithIcon({
    super.key,
    required this.title,
    required this.onTap,
    required this.svgIconPath,
    required this.backgroundColor,
    this.textColor = AppColors.white,
    this.isDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p20.responsiveWidth,
          vertical: AppPadding.p10.responsiveHeight,
        ),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p20.responsiveWidth,
          vertical: AppPadding.p10.responsiveHeight,
        ),
        height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
        width: double.infinity,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.responsiveSize),
          ),
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constrains.maxWidth * 0.2,
                child: SvgPicture.asset(
                  svgIconPath,
                  colorFilter:  ColorFilter.mode(
                    isDeleteButton ? AppColors.failColor :AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(
                width: constrains.maxWidth * 0.6,
                child: Text(
                  title,
                  style: const AppTextStyle()
                      .w500
                      .bodyMedium14
                      .copyWith(color: textColor),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class GoogleButtonWithIcon extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String svgIconPath;
  final Color backgroundColor;
  final Color textColor;

  const GoogleButtonWithIcon({
    super.key,
    required this.title,
    required this.onTap,
    required this.svgIconPath,
    required this.backgroundColor,
    this.textColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSize.s40.responsiveHeight,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p20.responsiveWidth,
          vertical: AppPadding.p10.responsiveHeight,
        ),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.responsiveSize),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const AppTextStyle()
                  .w500
                  .bodySmall12
                  .copyWith(color: textColor),
            ),
            SvgPicture.asset(
              svgIconPath,
            ),
          ],
        ),
      ),
    );
  }
}
