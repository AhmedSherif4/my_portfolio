import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../my_app/app_reference.dart';

class EmptyListWidgets extends StatelessWidget {
  final String message;
  final bool makeTextBlack;

  const EmptyListWidgets(
      {super.key, required this.message, this.makeTextBlack = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImagesAssets.sEmptyList,
          height: AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio,
          width: AppReference.deviceWidth(context) * 0.5,
        ),
        AppSize.s14.sizedBoxHeight,
        Text(
          message,
          style: AppReference.themeData.textTheme.titleSmall,
        ),
      ],
    );
  }
}
