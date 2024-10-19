import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';


class TextWithImageWidget extends StatelessWidget {
  final String label;
  final String imagePath;

  const TextWithImageWidget(
      {super.key, required this.label, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            style: AppTextStyle.titleSmall18,
          ),
        ),
        AppSize.s10.sizedBoxWidth,
        SvgPicture.asset(
          imagePath,
          // width: 50.responsiveWidth,
          height: AppReference.deviceHeight(context) * 0.03.responsiveHeightRatio,
        )
      ],
    );
  }
}
