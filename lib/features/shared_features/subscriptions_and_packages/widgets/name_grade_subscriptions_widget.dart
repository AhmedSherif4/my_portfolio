import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../core/shared_models/user/user_entity/user_entity.dart';
import 'base_for_two_widgets_subscriptions.dart';

class NameGradeSubscriptionsWidget extends StatelessWidget {
  final UserEntity? userData;
  const NameGradeSubscriptionsWidget({
    super.key,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return BaseForTwoWidgetsSubscriptions(
      backgroundColor: AppColors.secondaryColor.withOpacity(.1),
      widget1: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.responsiveSize),
        child: Text(
          userData?.name ?? '',
          style: const AppTextStyle().w500.s10.displaySmall28,
        ),
      ),
      widget2: Text(
        userData?.classroomName ?? '',
        style: const AppTextStyle().w500.s10.displaySmall28,
      ),
    );
  }
}
