import 'package:flutter/material.dart';

import '../resources/app_text_style.dart';

class ResponsiveDisplayLargeAnimatedWidget extends StatelessWidget {
  final String label;

  const ResponsiveDisplayLargeAnimatedWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: const AppTextStyle()
              .displayLarge40w4
              .copyWith(fontFamily: AppTextStyle.playfairDisplay),
        ),
      ),
    );
  }
}

class ResponsiveBodyMediumAnimatedWidget extends StatelessWidget {
  final bool isCentered;

  final String label;

  const ResponsiveBodyMediumAnimatedWidget({
    super.key,
    required this.label,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: const AppTextStyle().bodyMedium20w4.copyWith(
                fontFamily: AppTextStyle.playfairDisplay,
              ),
          textAlign: isCentered ? TextAlign.center : null,
        ),
      ),
    );
  }
}
