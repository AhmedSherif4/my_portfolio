import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../config/resources/app_assets.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../config/resources/app_values.dart';

class GoogleButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final double widthRatioForTablet;

  const GoogleButton({
    super.key,
    required this.backgroundColor,
    required this.onTap,
    this.textColor = AppColors.white,
    this.widthRatioForTablet = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppReference.deviceIsTablet?AppReference.deviceHeight(context) * 0.045.responsiveHeightRatio:AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p20.responsiveWidth,
          vertical: AppPadding.p10.responsiveHeight,
        ),
        width: AppReference.deviceIsTablet?AppReference.deviceWidth(context)*widthRatioForTablet:double.infinity,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.google,
              style: const AppTextStyle()
                  .w500
                  .bodySmall12
                  .copyWith(color: textColor),
            ),
            SvgPicture.asset(
              AppIconsAssets.sGoogleLogo,
            ),
          ],
        ),
      ),
    );
  }
}
