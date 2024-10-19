import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

import '../../config/resources/app_colors.dart';
import '../../config/resources/app_constants.dart';
import '../../my_app/app_reference.dart';
import 'custom_inkwell.dart';

class TypeUserSelectionButton extends StatelessWidget {
  final String iconImagePath;
  final String label;
  final Function() onTap;
  final UsersType typeUser;
  final UsersType selectedType;

  const TypeUserSelectionButton({
    super.key,
    required this.iconImagePath,
    required this.label,
    required this.onTap,
    required this.typeUser,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomInkWell(
        onTap: onTap,
        child: Container(
          height:AppReference.deviceIsTablet ? AppReference.deviceHeight(context) * 0.09.responsiveHeightRatio:
              AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio,
          padding: EdgeInsets.all(AppConstants.appPaddingR10.responsiveSize),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              width: 2,
              color: selectedType == typeUser
                  ? AppColors.primaryColor
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR10.responsiveSize,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: SvgPicture.asset(
                  iconImagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: _UserTypeName(label: label),
                ),
              ),
            ],
          ),
        ),
      ).animateShimmer(),
    );
  }
}

class _UserTypeName extends StatelessWidget {
  final String label;

  const _UserTypeName({required this.label});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidgetForTablet(
      mobile: Text(
        label,
        style: AppReference.themeData.textTheme.bodyMedium,
      ),
      tablet: FittedBox(
        child: Text(
          label,
          style: AppReference.themeData.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
