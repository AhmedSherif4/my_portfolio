import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../responsive/responsive.dart';
import '../app_colors.dart';

ThemeData appLightTheme() {
  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: AppTextStyle.hintTextStyle14,
      inputDecorationTheme: InputDecorationTheme(
        // hint style
        hintStyle: AppTextStyle.hintTextStyle14,
        errorStyle: AppTextStyle.errorTextStyle12,

        // enabled border style
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveManager.getSize(
              AppConstants.textInputFieldBorderRadiusR35,
            ),
          ),
          borderSide: const BorderSide(
            color: AppColors.white,
            width: AppConstants.appBorderSideWidthR1,
          ),
        ),

        // focused border style
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveManager.getSize(
              AppConstants.textInputFieldBorderRadiusR35,
            ),
          ),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: AppConstants.appBorderSideWidthR1,
          ),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveManager.getSize(
              AppConstants.textInputFieldBorderRadiusR35,
            ),
          ),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: AppConstants.appBorderSideWidthR1,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveManager.getSize(
              AppConstants.textInputFieldBorderRadiusR35,
            ),
          ),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: AppConstants.appBorderSideWidthR1,
          ),
        ),

        // error border style
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveManager.getSize(
              AppConstants.textInputFieldBorderRadiusR35,
            ),
          ),
          borderSide: const BorderSide(
            color: AppColors.failColor,
            width: AppConstants.appBorderSideWidthR1,
          ),
        ),

        // focused border style
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveManager.getSize(
              AppConstants.textInputFieldBorderRadiusR35,
            ),
          ),
          borderSide: const BorderSide(
            color: AppColors.failColor,
            width: AppConstants.appBorderSideWidthR1,
          ),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveManager.getSize(
                AppConstants.textInputFieldBorderRadiusR35,
              ),
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        padding: WidgetStatePropertyAll(
          EdgeInsets.all(AppPadding.p10.responsiveSize),
        ),
      ),
    ),

    //set default font family
    fontFamily: AppTextStyle.balooBhaijaan2,

    scaffoldBackgroundColor: AppColors.backgroundColor,

    // set Colors as background

    // set text Style
    textTheme: TextTheme(
      displayLarge: AppTextStyle.displayLarge32,
      displayMedium: AppTextStyle.displayMedium30,
      displaySmall: AppTextStyle.displaySmall28,
      titleLarge: AppTextStyle.titleLarge22,
      titleMedium: AppTextStyle.titleMedium20,
      titleSmall: AppTextStyle.titleSmall18,
      bodyLarge: AppTextStyle.bodyLarge16,
      bodyMedium: AppTextStyle.bodyMedium14,
      bodySmall: AppTextStyle.bodySmall12,
    ),

    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveManager.getHorizontalSize(AppPadding.p10),
        vertical: 0,
      ),

      // hint style
      hintStyle: AppTextStyle.hintTextStyle14,
      errorStyle: AppTextStyle.errorTextStyle12,

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.white,
          width: AppConstants.appBorderSideWidthR1,
        ),
      ),

      // focused border style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: AppConstants.appBorderSideWidthR1,
        ),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: AppConstants.appBorderSideWidthR1,
        ),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: AppConstants.appBorderSideWidthR1,
        ),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.failColor,
          width: AppConstants.appBorderSideWidthR1,
        ),
      ),

      // focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.failColor,
          width: AppConstants.appBorderSideWidthR1,
        ),
      ),
    ),
  );
}