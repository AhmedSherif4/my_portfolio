import 'package:flutter/material.dart';
import 'package:my_portfolio/config/extensions/color_extension.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/core/shared_widget/text_with_background_color.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

class LevelNameWidgetInCollectionScreen extends StatelessWidget {
  final String currentLevel;
  final String levelColor;

  const LevelNameWidgetInCollectionScreen({
    super.key,
    required this.currentLevel,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextWithBackGroundColor(
      width: AppReference.deviceIsTablet ? AppReference.deviceWidth(context) * 0.2 : AppReference.deviceWidth(context) * 0.5,
      text: currentLevel,
      backgroundColor: HexColor.fromHex(levelColor),
      textColor: AppColors.textColor3,
    );
  }
}
