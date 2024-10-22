import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';

import '../resources/app_text_style.dart';

class ResponsiveDisplayLargeAnimatedWidget extends StatelessWidget {
  final String label;

  const ResponsiveDisplayLargeAnimatedWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: AppTextStyle()
              .displayLarge40w4
              .copyWith(fontFamily: AppTextStyle.playfairDisplay),
        ).animateText(),
      ),
    );
  }
}
