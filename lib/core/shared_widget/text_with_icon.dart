import 'package:flutter/cupertino.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../my_app/app_reference.dart';

class TextAndIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color textColor;
  final Color iconColor;
  final double fontSize;

  const TextAndIcon(
      {super.key,
      required this.text,
      required this.icon,
      required this.textColor,
      required this.iconColor,
      this.fontSize = 12,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: AppReference.themeData.textTheme.bodyMedium!
              .copyWith(color: textColor,fontSize: fontSize.responsiveFontSize),
        ),
        AppSize.s10.sizedBoxWidth,
        Icon(
          icon,
          size: 16.responsiveSize,
          color: iconColor,
        )
      ],
    );
  }
}
