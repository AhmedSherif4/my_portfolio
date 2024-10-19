
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';

import '../../../../config/resources/app_assets.dart';
import '../../../../config/resources/app_strings.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../core/shared_widget/text_back_button.dart';
import '../../../../my_app/app_reference.dart';

class AppBarSubscriptionsWidget extends StatelessWidget {
  final String title;
  final int? childID;
  final bool isNotHomeSub;
  final bool isHaveCart;

  const AppBarSubscriptionsWidget({
    super.key,
    this.isNotHomeSub = true,
    this.isHaveCart = false,
    this.title = AppStrings.subscriptions,
    required this.childID,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:AppReference.deviceWidth(context),
      height: AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          children: [
            SvgPicture.asset(
              AppImagesAssets.sLogoWithoutName,
              width: constrains.maxWidth * 0.15,
              height: constrains.maxHeight * 0.6,
              fit: BoxFit.cover,
            ),

            SizedBox(
              width: constrains.maxWidth * 0.05,
            ),
            if(isHaveCart)...[
            CustomInkWell(
              onTap: (){
                RouteManager.rPushNamed(
                  context: context,
                  rName: AppRoutesNames.rCartScreen,
                  arguments: childID,
                );
              },
              child: SvgPicture.asset(
                AppImagesAssets.sShoppingCart,
                width: constrains.maxWidth * 0.15,
                height: constrains.maxHeight * 0.6,
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.05,
            ),],
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const AppTextStyle().w700.gray.bodyLarge16,
            ),
            const Spacer(),
            switch (isNotHomeSub) {
              true =>const TextBackButton(),
              false => (constrains.maxWidth * 0.15).sizedBoxWidth
            },
            SizedBox(
              width: constrains.maxWidth * 0.05,
            ),
          ],
        );
      }),
    );
  }
}

