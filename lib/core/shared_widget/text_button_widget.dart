import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import '../../config/resources/app_colors.dart';

class TextButtonWidget extends StatelessWidget {
  final Color textColor;
  final String text;
  final FontWeight weight;
  final double fontSize;
  final Function() onPressed;
  final bool withDecoration;


  const TextButtonWidget({
    super.key,
    this.textColor = AppColors.primaryColor,
    required this.text,
    required this.onPressed,
    this.weight = FontWeight.w500,
    this.withDecoration = false,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: const AppTextStyle().bodyLarge16.copyWith(
              color: textColor,
              fontWeight: weight,
              fontSize: fontSize.responsiveFontSize,
          decorationColor: AppColors.primaryColor,

          decoration:withDecoration? TextDecoration.underline:TextDecoration.none,
            ),
      ),
    );
  }
}
