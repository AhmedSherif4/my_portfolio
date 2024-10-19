import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import '../../../config/resources/app_assets.dart';
import '../../../config/resources/app_text_style.dart';
import '../../../config/resources/app_values.dart';
import '../../../config/routes/route_manager.dart';
import '../../../config/routes/routes_names.dart';
import '../../../my_app/app_reference.dart';

class InstitutionAndParentHeader extends StatelessWidget {
  final String title;
  final bool withBackButton;

  const InstitutionAndParentHeader(
      {super.key, required this.title, this.withBackButton = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrain) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppImagesAssets.sLogoWithoutName,
              fit: BoxFit.fitHeight,
              height: constrain.maxHeight,
            ),
            AppSize.s10.sizedBoxWidth,
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: AppTextStyle.bodyLarge16,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                RouteManager.rPushNamed(
                  context: context,
                  rName: AppRoutesNames.rNotificationScreen,
                );
              },
              child: SvgPicture.asset(
                AppIconsAssets.sNotificationHomeIcon,
                fit: BoxFit.contain,
                height: constrain.maxHeight * 0.7,
              ),
            ),
            AppSize.s10.sizedBoxWidth,
            if (withBackButton)
              const TextBackButton(),
          ],
        );
      }),
    );
  }
}
