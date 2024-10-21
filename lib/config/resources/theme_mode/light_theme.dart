import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';

import 'theme_manager.dart';

class LightTheme with SubThemeData {
  AppTextStyle appTextStyle = AppTextStyle(color: AppColors.black);

  ThemeData buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      useMaterial3: true,
      textTheme: getTextTheme(AppColors.black),
      elevatedButtonTheme: getElevatedButtonTheme(),
      cardTheme: getCardTheme(AppColors.black),
      appBarTheme: getAppBarTheme(AppColors.black),
      switchTheme: getSwitchTheme(
        Icons.light_mode_rounded,
        AppColors.black,
      ),
      textButtonTheme: getTextButtonTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: getInputDecorationTheme(AppColors.black),
        textStyle: appTextStyle.bodyMedium14,
        menuStyle: getMenuStyle(),
      ),
      scaffoldBackgroundColor: AppColors.white,
      inputDecorationTheme: getInputDecorationTheme(AppColors.black),
    );
  }
}
