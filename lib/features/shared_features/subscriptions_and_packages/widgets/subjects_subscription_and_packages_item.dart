import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../my_app/app_reference.dart';

class CustomSelectWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final int price;

  const CustomSelectWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0.responsiveWidth),
        margin: EdgeInsets.symmetric(vertical: 5.0.responsiveHeight),
        height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.responsiveSize),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              10.sizedBoxWidth,
              Container(
                width: constraints.maxWidth * 0.5,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  title,
                  style: const AppTextStyle().gray.w500.bodyMedium14,
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.3,
                alignment: AlignmentDirectional.center,
                child: Text(
                  '$price ريال',
                  style: const AppTextStyle().w600.bodySmall12.copyWith(
                    color: AppColors.secondaryColor4,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
