import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import '../../../config/resources/app_colors.dart';
import '../../../config/resources/app_constants.dart';
import '../../../config/resources/app_text_style.dart';
import '../../../config/resources/app_values.dart';
import '../../../core/shared_widget/custom_inkwell.dart';
import '../../../my_app/app_reference.dart';

class BaseWelcomeButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String imagePath;
  final TextStyle textStyle;
  final BoxFit? boxFit;

  const BaseWelcomeButton(
      {super.key,
      required this.onTap,
      required this.title,
       this.boxFit,
      required this.imagePath, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        height: AppReference.deviceIsTablet ? AppReference.deviceHeight(context) * .2.responsiveHeightRatio :AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
        padding: EdgeInsets.all(10.responsiveSize),
        width: AppReference.deviceIsTablet ? AppReference.deviceWidth(context) * .7 : double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR15),
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Row(
            children: [
              SizedBox(
                width: constrains.maxWidth * 0.33,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: AppReference.deviceIsTablet
                          ? const AppTextStyle().w600.bodyLarge16.copyWith(
                        fontSize: AppFontSize.sp16.responsiveFontSize,
                      )
                          : textStyle,
                    ),
                    SvgPicture.asset(
                      AppIconsAssets.sOrangeBack,
                    ),
                  ],
                ),
              ),
              (constrains.maxWidth * 0.03).sizedBoxWidth,
              Expanded(
                child: SvgPicture.asset(
                  imagePath,
                  height: constrains.maxHeight * 0.9,
                   fit: boxFit??BoxFit.contain,
                ),
              ),
              (constrains.maxWidth * 0.03).sizedBoxWidth,
            ],
          );
        }),
      ),
    );
  }
}

class BaseLandScapeWelcomeButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String imagePath;
  final TextStyle textStyle;
  final BoxFit? boxFit;

  const BaseLandScapeWelcomeButton(
      {super.key,
        required this.onTap,
        required this.title,
        this.boxFit,
        required this.imagePath, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p10.responsiveSize,
          vertical: AppPadding.p10.responsiveSize,
        ),
        width:  double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR15),
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: textStyle,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    AppIconsAssets.sOrangeBack,
                    height: AppSize.s10,
                  ),
                ],
              ),
              AppSize.s16.sizedBoxHeight,
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  imagePath,
                  height: constrains.maxHeight * 0.9,
                  fit: boxFit??BoxFit.contain,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
