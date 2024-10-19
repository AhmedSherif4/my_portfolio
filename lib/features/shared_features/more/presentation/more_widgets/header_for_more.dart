import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../config/resources/app_values.dart';

class HeaderForMore extends StatelessWidget {
  final String title;
  final Color textColor;
  final bool notFirst;
  final bool haveIcon;
  final Function()? onBack;

  const HeaderForMore({
    required this.title,
    this.textColor = AppColors.black,
    super.key,
    this.notFirst = true,
    this.haveIcon = false,
    this.onBack ,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: (AppReference.deviceIsTablet && !AppReference.isPortrait(context))?AppReference.deviceWidth(context) * 0.04.responsiveHeightRatio : AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AppImagesAssets.sLogoWithoutName,
              width: constrains.maxWidth * 0.15,
              height: constrains.maxHeight * 0.6,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              style: const AppTextStyle()
                  .w500
                  .bodyLarge16
                  .copyWith(
                  fontSize: AppFontSize.sp16.responsiveFontSize,
                  color: textColor),
            ),
            if(haveIcon)
              SvgPicture.asset(
                AppImagesAssets.sMyTime,
                fit: BoxFit.contain,
              ),
            switch (notFirst) {
              true => GestureDetector(
                onTap: onBack ?? () {
                  Navigator.pop(context);
                },
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    height: constrains.maxHeight,
                    padding: EdgeInsetsDirectional.all(
                        AppPadding.p12.responsiveSize),
                    child: Text(
                      "رجوع",
                      style: const AppTextStyle().balooBhaijaan2.w700.bodyMedium14.copyWith(
                          fontSize: AppFontSize.sp14.responsiveFontSize,
                          color: AppColors.primaryColor2),
                    )

                  // SvgPicture.asset(
                  //   AppIconsAssets.sOrangeBack,
                  //   width: constrains.maxWidth * 0.1,
                  //   height: constrains.maxHeight * 0.3,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              false => (constrains.maxWidth * 0.1).sizedBoxWidth
            }
          ],
        );
      }),
    );
  }
}
