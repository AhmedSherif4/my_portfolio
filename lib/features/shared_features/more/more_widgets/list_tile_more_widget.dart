part of 'more_widgets.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String? icon;
  final double iconHeight;
  final double iconWidth;
  final Color iconColor;
  final Color textColor;
  final Function() onTap;
  final Color buttonColor;
  final bool fromMore;

  const ListTileWidget({
    super.key,
    required this.title,
    this.icon,
    this.iconHeight=AppSize.s20,
    this.iconWidth=AppSize.s20,
    required this.onTap,
    this.buttonColor = AppColors.white,
    this.iconColor = AppColors.primaryColor,
    this.textColor = AppColors.textColor,
    this.fromMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomInkWell(
        onTap: onTap,
        child: Container(
          // margin: AppReference.deviceIsTablet?EdgeInsets.zero:EdgeInsetsDirectional.symmetric(
          //   horizontal: AppPadding.p20.responsiveWidth,
          //   vertical: AppPadding.p10.responsiveHeight,
          // ),
          // margin: EdgeInsets.zero,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: AppPadding.p20.responsiveSize,

            vertical: AppPadding.p12.responsiveSize,
          ),
          decoration: ShapeDecoration(
            color: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s20.responsiveSize),
            ),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon != null
                  ? SvgPicture.asset(
                      icon!,
                      height: iconHeight.responsiveSize,
                      width: iconWidth.responsiveSize,
                    )
                  : const SizedBox(),
              AppSize.s10.sizedBoxWidth,
              Expanded(
                child: Text(
                  title,
                  style: const AppTextStyle().bodyMedium14.copyWith(
                    color: textColor,
                  ),
                ),
              ),
              AppSize.s10.sizedBoxWidth,
              if(!fromMore)...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s10.responsiveWidth),
                height: AppSize.s24.responsiveSize,
                decoration:  BoxDecoration(
                  color: AppColors.primaryColor2,
                  borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20)
                ),
                child: Center(
                  child: Text(AppStrings.details,
                  style: const AppTextStyle().balooBhaijaan2.white.w700.bodySmall12,
                  ),
                ),
              ),],
              if(fromMore)...[
                 Icon(
                Icons.arrow_back_ios_new_rounded,
                textDirection: TextDirection.ltr,
                color: iconColor,
              ),
              ]
              // AppSize.s10.sizedBoxWidth,
            ],
          ),
        ),
      ),
    );
  }
}

