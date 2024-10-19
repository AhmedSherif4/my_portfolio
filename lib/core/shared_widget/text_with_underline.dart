import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../config/resources/app_colors.dart';
import '../../my_app/app_reference.dart';

class UnderLinedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? lineColor;
  final bool? isLarge;

  const UnderLinedText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.isLarge=false,
    this.lineColor = AppColors.primaryColor2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: style ?? AppReference.themeData.textTheme.titleLarge,
          textAlign: textAlign ?? TextAlign.center,
        ),
        AppSize.s4.sizedBoxHeight,
        Container(
          width: isLarge! ? text.length * 10 : text.length * 5, // Adjust this as needed
          height: 2.5.responsiveHeight,
          color: lineColor,
        ),
      ],
    );
  }
}
