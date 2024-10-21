import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';

import 'theme_manager.dart';

class DarkTheme with SubThemeData {
  AppTextStyle appTextStyle = AppTextStyle(color: AppColors.white);

  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      brightness: Brightness.dark,
      textTheme: getTextTheme(AppColors.textColor6),
      elevatedButtonTheme: getElevatedButtonTheme(),
      cardTheme: getCardTheme(AppColors.white),
      appBarTheme: getAppBarTheme(AppColors.white),
      switchTheme: getSwitchTheme(
        Icons.dark_mode_rounded,
        AppColors.white,
      ),
      textButtonTheme: getTextButtonTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: getInputDecorationTheme(AppColors.white),
        textStyle: appTextStyle.bodyMedium20w4,
        menuStyle: getMenuStyle(),
      ),
      scaffoldBackgroundColor: AppColors.blue,
      inputDecorationTheme: getInputDecorationTheme(AppColors.white),
    );
  }
}
