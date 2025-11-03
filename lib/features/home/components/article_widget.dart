import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../config/resources/app_colors.dart';
import '../../../config/resources/app_constants.dart';
import '../../../config/resources/app_text_style.dart';
import '../../../my_app/app_reference.dart';

class ArticleWidget extends StatelessWidget {
  final String imageAssert;
  final String title;
  final String description;
  final void Function() onTap;

  const ArticleWidget(
      {super.key,
      required this.imageAssert,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          margin: EdgeInsets.all(15.responsiveSize),
          decoration: AppConstants.containerDecoration(
              backgroundColor: AppColors.primaryColor2(context)),
          width: AppReference.deviceWidth(context) *
              (AppReference.deviceIsTablet ? 0.4 : 8),
          height: AppReference.deviceHeight(context),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          AppConstants.appBorderRadiusR20.responsiveSize),
                      topRight: Radius.circular(
                          AppConstants.appBorderRadiusR20.responsiveSize)),
                  child: Image.asset(
                    imageAssert,
                    width: boxConstraints.maxWidth,
                    height: boxConstraints.maxHeight * 0.45,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.responsiveWidth),
                  width: boxConstraints.maxWidth,
                  height: boxConstraints.maxHeight * 0.2,
                  child: Text(
                    title,
                    style: const AppTextStyle().titleMedium26w5.copyWith(
                        fontFamily: AppTextStyle.playfairDisplay, height: 1),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.responsiveWidth),
                  width: boxConstraints.maxWidth,
                  height: boxConstraints.maxHeight * 0.3,
                  child: Text(
                    description,
                    style: const AppTextStyle().gray.labelSmall12w5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 8,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.responsiveWidth),
                  width: boxConstraints.maxWidth,
                  height: boxConstraints.maxHeight * 0.05,
                  child: Text(
                    'CLICK FOR FULL ARTICLE:',
                    style: const AppTextStyle().labelMedium14w5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
