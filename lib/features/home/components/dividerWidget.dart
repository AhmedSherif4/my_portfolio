import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../config/resources/app_colors.dart';
import '../../../config/resources/app_constants.dart';
import '../../../my_app/app_reference.dart';

class DividerWidget extends StatelessWidget {
  final bool isVertical;

  const DividerWidget({super.key, required this.isVertical});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isVertical ? AppReference.deviceHeight(context) * 0.3 : 2,
      width: isVertical ? 2 : AppReference.deviceWidth(context) * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.appBorderRadiusR20.responsiveSize,
        ),
        color: AppColors.gray,
      ),
    );
  }
}
