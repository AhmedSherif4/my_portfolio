import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../../../../../config/resources/app_colors.dart';
import '../../../../../../../config/resources/app_text_style.dart';
import '../../../../../../../config/resources/app_values.dart';
import '../../../../../../../my_app/app_reference.dart';
import '../../../../../more/presentation/more_widgets/header_for_more.dart';

class AllSubscriptionHeader extends StatelessWidget {
  final String title;
  final String body;

  const AllSubscriptionHeader(
      {super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?
      AppReference.deviceHeight(context) * 0.15.responsiveHeightRatio:
      AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.05),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(25.responsiveSize),
          bottomEnd: Radius.circular(25.responsiveSize),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderForMore(
            title: title,
            textColor: AppColors.textColor,
          ).paddingBody(),
          const Spacer(),
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  body,
                  style: AppTextStyle.bodyLarge16
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                AppSize.s10.sizedBoxWidth,
                SvgPicture.asset(AppImagesAssets.sSubscription2)
              ],
            ),
          ),
          const Divider(
            color: AppColors.textColor2,
            height: 1,
          ).paddingBody(
            end: AppPadding.p30.responsiveSize,
            start: AppPadding.p30.responsiveSize,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
