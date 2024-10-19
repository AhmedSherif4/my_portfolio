import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final String image;
  final Future<void> Function()? onRefresh;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.image = AppImagesAssets.sError404,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.primaryColor,
      color: AppColors.primaryColor,
      onRefresh: onRefresh ?? () async {},
      child: Center(
        child: ListView(
          physics:
              onRefresh != null ? null : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              image,
            ),
            Text(
              '$errorMessage,\t ${AppStrings.tryLater}',
              style: AppReference.themeData.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
