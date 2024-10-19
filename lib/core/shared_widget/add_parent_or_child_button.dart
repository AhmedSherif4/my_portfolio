import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../config/resources/app_colors.dart';
import '../../config/resources/app_text_style.dart';

class AddParentOrChildButton extends StatelessWidget {
  final Function() onTap;
  final String buttonLabel;
  final Color backgroundColor;
  final String svgPath;
  final AlignmentDirectional alignmentDirectional;

  const AddParentOrChildButton({
    super.key,
    required this.onTap,
    required this.buttonLabel,
    required this.backgroundColor,
    required this.svgPath,
    this.alignmentDirectional = AlignmentDirectional.centerStart,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignmentDirectional,
      child: CustomInkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width:(AppReference.deviceIsTablet && !AppReference.isPortrait(context))?AppReference.deviceWidth(context) * 0.1 :AppReference.deviceWidth(context) * 0.2,
              height: (AppReference.deviceIsTablet && !AppReference.isPortrait(context))?AppReference.deviceWidth(context) * 0.09 :AppReference.deviceHeight(context) *
                  0.085.responsiveHeightRatio,
              padding: EdgeInsets.all(10.responsiveSize),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(
                  AppConstants.appBorderRadiusR15.responsiveSize,
                ),
              ),
              child: FittedBox(
                child: SvgPicture.asset(svgPath),
              ),
            ),
            5.sizedBoxHeight,
            SizedBox(
              height: AppReference.deviceHeight(context) *
                  0.025.responsiveHeightRatio,
              child: FittedBox(
                child: Text(
                  buttonLabel,
                  style: const AppTextStyle().balooBhaijaan2.w700.bodySmall12.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
