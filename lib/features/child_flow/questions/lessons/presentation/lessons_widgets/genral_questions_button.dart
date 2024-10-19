import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_constants.dart';
import '../../../../../../config/resources/app_values.dart';

class GeneralQuestionsButton extends StatelessWidget {
  final Function() goToLevelScreen;

  const GeneralQuestionsButton({super.key, required this.goToLevelScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

        color: AppColors.primaryColor,
        height: AppSize.s60.responsiveHeight,
        minWidth: double.infinity,
        elevation: 5,
        padding: const EdgeInsets.all(0),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          ),
          borderSide: BorderSide.none,
        ),
        onPressed: goToLevelScreen,
        child: Row(
          children: [
            AppSize.s20.sizedBoxWidth,
            SvgPicture.asset(
              AppImagesAssets.sSettingsFilter
            ),
            Expanded(
              child: Text(
                AppStrings.generalQuestionsLevels,
                textAlign: TextAlign.center,
                style: const AppTextStyle().white.w800.s16.titleSmall18,
              ),
            ),
            AppSize.s20.sizedBoxWidth,
          ],
        ));
  }
}


