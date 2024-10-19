import 'package:flutter/material.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../config/resources/app_colors.dart';
import '../../config/resources/app_strings.dart';
import '../../config/resources/app_text_style.dart';
import '../../config/routes/route_manager.dart';
import 'text_button_widget.dart';

class TextBackButton extends StatelessWidget {
  final Function()? backTo;
  const TextBackButton({super.key, this.backTo});

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      text: AppStrings.back,
      textColor: AppColors.primaryColor2,
      fontSize: AppReference.deviceIsTablet?AppFontSize.sp16:AppFontSize.sp14,
      onPressed: backTo??  () {
        RouteManager.rPopRoute(context);
      },
    );
  }
}
