import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';

import '../../../../../../../config/resources/app_colors.dart';
import '../../../../../../../config/resources/app_constants.dart';
import '../../../../../../../config/resources/app_text_style.dart';
import '../../../../../../../config/resources/app_values.dart';
import '../../../../../../../config/responsive/responsive.dart';

class TermItemForAllSubscription extends StatelessWidget {
  final bool isSubscriptionTerm;
  final String termName;
  final Function() termOnTap;

  const TermItemForAllSubscription(
      {super.key,
      required this.isSubscriptionTerm,
      required this.termName,
      required this.termOnTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: termOnTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.s10.responsiveSize,
          vertical: AppSize.s6.responsiveSize,
        ),
        decoration: BoxDecoration(
          color: isSubscriptionTerm? AppColors.quranColor.withOpacity(.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: ResponsiveManager.calculateRadius(20, 10),
              backgroundColor:
                  isSubscriptionTerm ? AppColors.secondaryColor2 : AppColors.failColor,
              child: Icon(
                isSubscriptionTerm ? Icons.check : Icons.close,
                color: AppColors.white,
                size: 15.responsiveSize,
              ),
            ),
            10.sizedBoxWidth,
            Text(
              termName,
              style: AppTextStyle.bodyMedium14,
            ),
            if (isSubscriptionTerm) const Spacer(),
            if (isSubscriptionTerm)
              Icon(Icons.arrow_forward_ios,
              size: AppSize.s12.responsiveSize,
              )
          ],
        ),
      ),
    );
  }
}
