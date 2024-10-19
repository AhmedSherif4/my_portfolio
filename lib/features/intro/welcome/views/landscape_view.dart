import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../config/resources/app_assets.dart';
import '../../../../config/resources/app_strings.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../config/resources/app_values.dart';
import '../welcome_item.dart';

class WelcomeScreenLandscapeView extends StatelessWidget {
  final Function() goToSignUp;
  final Function() goToLogIn;
  final Function() goToHome;


  const WelcomeScreenLandscapeView(
      {super.key, required this.goToSignUp, required this.goToLogIn, required this.goToHome});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseLandScapeWelcomeButton(
            onTap: goToSignUp,
            title: AppStrings.createNewAccount,
            imagePath: AppImagesAssets.sWelcomeNew,
            textStyle: AppTextStyle.bodySmall12,
            boxFit: BoxFit.fitHeight,
          ),
        ),
        AppReference.deviceIsTablet?AppSize.s10.sizedBoxWidth:AppSize.s30.sizedBoxWidth,
        Expanded(
          child: BaseLandScapeWelcomeButton(
            onTap: goToLogIn,
            title: AppStrings.signIN,
            imagePath: AppImagesAssets.sWelcomeExist,
            textStyle: AppTextStyle.bodySmall12,
            boxFit: BoxFit.fitWidth,
          ),
        ),
        AppReference.deviceIsTablet?AppSize.s10.sizedBoxWidth:AppSize.s30.sizedBoxWidth,
        Expanded(
          child: BaseLandScapeWelcomeButton(
            onTap: goToHome,
            title: AppStrings.guest,
            imagePath: AppImagesAssets.sWelcomeGuest,
            textStyle: AppTextStyle.bodySmall12,
            boxFit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
