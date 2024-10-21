import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

enum AppTheme { light, dark }

class ThemeManager {
  static final Map<AppTheme, ThemeData> appThemeData = {
    AppTheme.light: LightTheme().buildLightTheme(),
    AppTheme.dark: DarkTheme().buildDarkTheme(),
  };

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

// class for sharing themes that duplicate with light and dark mode.
mixin SubThemeData {
  TextButtonThemeData getTextButtonTheme() => TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.responsiveSize)),
          )),
          backgroundColor: const MaterialStatePropertyAll(AppColors.white),
        ),
      );

  SwitchThemeData getSwitchTheme(
    IconData icon,
    Color color,
  ) =>
      SwitchThemeData(
        thumbColor: const MaterialStatePropertyAll(AppColors.white),
        thumbIcon: MaterialStatePropertyAll(Icon(icon)),
        trackColor: MaterialStatePropertyAll(color),
        overlayColor: const MaterialStatePropertyAll(AppColors.white),
      );

  AppBarTheme getAppBarTheme(Color? colorDependOnTheme) => AppBarTheme(
        backgroundColor: colorDependOnTheme,
      );

  CardTheme getCardTheme(Color? colorDependOnTheme) => CardTheme(
        color: colorDependOnTheme,
        margin: EdgeInsets.all(10.responsiveSize),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.responsiveSize),
          ),
        ),
      );

  ElevatedButtonThemeData getElevatedButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          fixedSize: MaterialStatePropertyAll(
            Size(
              296.responsiveWidth,
              55.responsiveHeight,
            ),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.responsiveSize),
              ),
            ),
          ),
        ),
      );

  TextTheme getTextTheme(Color? colorDependOnTheme) {
    AppTextStyle appTextStyle = AppTextStyle(color: colorDependOnTheme);

    return TextTheme(
      displayLarge: appTextStyle.displayLarge32,
      displayMedium: appTextStyle.displayMedium30,
      displaySmall: appTextStyle.displaySmall28,
      titleLarge: appTextStyle.titleLarge22,
      titleMedium: appTextStyle.titleMedium20,
      titleSmall: appTextStyle.titleSmall18,
      bodyLarge: appTextStyle.bodyLarge16,
      bodyMedium: appTextStyle.bodyMedium14,
      bodySmall: appTextStyle.bodySmall12,
    );
  }

  InputDecorationTheme getInputDecorationTheme(Color? colorDependOnTheme) {
    AppTextStyle appTextStyle = AppTextStyle(color: colorDependOnTheme);
    return InputDecorationTheme(
      // content padding
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveManager.getHorizontalSize(10),
        vertical: 0,
      ),

      // hint style
      // hintStyle: appTextStyle.hintTextStyle14,
      // errorStyle: appTextStyle.errorTextStyle12,

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveManager.getSize(
            AppConstants.textInputFieldBorderRadiusR35,
          ),
        ),
        borderSide: const BorderSide(
          color: AppColors.gray,
          width: 1,
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
          width: 1,
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
          width: 1,
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
          width: 1,
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
          color: AppColors.red,
          width: 1,
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
          color: AppColors.red,
          width: 1,
        ),
      ),
    );
  }

  MenuStyle getMenuStyle() => MenuStyle(
        backgroundColor: const MaterialStatePropertyAll(AppColors.gray),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveManager.getSize(
                AppConstants.textInputFieldBorderRadiusR35,
              ),
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(10.0.responsiveSize),
        ),
      );
}

extension AppThemeX on AppTheme {
  bool get isLight => this == AppTheme.light;

  bool get isDark => this == AppTheme.dark;
}

/*
Display
Headline
Title
Label
Body
*/
