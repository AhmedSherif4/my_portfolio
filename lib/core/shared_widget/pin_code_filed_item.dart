import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../my_app/app_reference.dart';

class PinCodeFieldWidget extends StatelessWidget {
  final Function(String) onComplete;

  const PinCodeFieldWidget({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(
                AppConstants.appBorderRadiusR10.responsiveSize),
            fieldHeight: AppReference.deviceIsTablet ?AppReference.deviceHeight(context)*.09.responsiveHeightRatio:AppReference.isPortrait(context)
                ? 50.responsiveHeight
                : 100.responsiveHeight,
            fieldWidth: AppReference.deviceIsTablet ?30.responsiveWidth :45.responsiveWidth,
            borderWidth: 1,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.white,
            inactiveFillColor: AppColors.white,
            activeFillColor: AppColors.primaryColor,
            selectedColor: AppColors.primaryColor,
            selectedFillColor: AppColors.white,
            disabledColor: AppColors.white,
            errorBorderColor: AppColors.failColor),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: AppReference.themeData.scaffoldBackgroundColor,
        enableActiveFill: true,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        onCompleted: onComplete,
      ),
    );
  }
}
