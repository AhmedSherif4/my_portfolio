import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../config/resources/app_assets.dart';
import '../../config/resources/app_colors.dart';
import '../../config/resources/app_values.dart';

class LockWidgets extends StatelessWidget {
  final Widget lockWidget;
  final bool isLocked;
  final String textLock;

  final String assetLock;

  const LockWidgets({
    super.key,
    required this.lockWidget,
    required this.isLocked,
    required this.textLock,
    this.assetLock = AppImagesAssets.sLock,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AbsorbPointer(
          absorbing: isLocked,
          child: Opacity(
            opacity: isLocked == true ? 0.4 : 1,
            child: lockWidget,
          ),
        ),
        if (isLocked)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSize.s10.sizedBoxWidth,
              SvgPicture.asset(
                assetLock,
                height: 30.responsiveHeightRatio,
                width: 30.responsiveHeightRatio,
                colorFilter: const ColorFilter.mode(AppColors.secondaryColor4, BlendMode.srcIn),
              ),
              AppSize.s10.sizedBoxWidth,
              Text(
                textLock,
                style: const AppTextStyle().titleSmall18.copyWith(
                  color: AppColors.secondaryColor4,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
