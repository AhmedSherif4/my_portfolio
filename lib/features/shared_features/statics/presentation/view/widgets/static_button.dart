part of '../../../statics.dart';


class StaticButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function() onTap;

  const StaticButton(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        height: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceHeight(context) * 0.4:AppReference.deviceHeight(context) * 0.11.responsiveHeightRatio,
        width: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceWidth(context) * 0.35:double.infinity,
        padding: EdgeInsets.symmetric(vertical:AppPadding.p8.responsiveSize,
            horizontal:AppPadding.p8.responsiveSize),
        decoration:
            AppConstants.containerDecoration(backgroundColor: AppColors.white),
        child: LayoutBuilder(builder: (context, constrains) {
          return Row(
            children: [
              SizedBox(
                width: constrains.maxWidth * 0.3,
                height: constrains.maxHeight,
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                width: constrains.maxWidth * 0.65,
                height: constrains.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        title,
                        style: AppTextStyle.bodyLarge16.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppFontSize.sp18.responsiveFontSize,
                        ),
                      ),
                    ),
                     TextAndIcon(
                       text: AppStrings.more,
                       fontSize: AppFontSize.sp10.responsiveFontSize,
                       icon: Icons.arrow_forward_ios,
                       textColor: AppColors.primaryColor,
                       iconColor: AppColors.primaryColor,
                     )
                  ],
                ).paddingBody(
                  start: 0,
                  end: 0,
                  top: 5,
                  bottom: 5,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
