import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';


class TextWithBackGroundColor extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final double verticalPadding;
  final double horizontalPadding;
  final Color? textColor;
  final bool isOneLine;
  final double fontSize;
  final int? maxLine;

  const TextWithBackGroundColor({
    super.key,
    required this.text,
    this.width,
    this.height,
    required this.backgroundColor,
    this.verticalPadding = AppPadding.p10,
    this.horizontalPadding = AppPadding.p10,
    this.textColor,
    this.isOneLine = false,
    this.fontSize = 18,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.responsiveWidth,
        vertical: verticalPadding.responsiveHeight,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR25.responsiveSize),
      ),
      child: isOneLine
          ? FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
                textDirection: AppConstants.arabicDirection(text),
                style: const AppTextStyle().white.w500.titleSmall18.copyWith(
                    color: textColor ?? AppColors.white,
                    fontSize: fontSize.responsiveFontSize,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Text(
                text,
                textAlign: TextAlign.center,
                textDirection: AppConstants.arabicDirection(text),
                maxLines: maxLine,
                overflow: TextOverflow.ellipsis
                ,
                style: const AppTextStyle().white.w500.titleSmall18.copyWith(
                  color: textColor ?? AppColors.white,
                  fontSize: fontSize.responsiveFontSize,
                ),
              ),
            ),
    );
  }
}
