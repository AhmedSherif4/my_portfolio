import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import 'nullable_network_image.dart';

class BaseContainerHaveTextAndImage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final bool notHaveImage;
  final double width;
  final double height;

  const BaseContainerHaveTextAndImage(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.width,
      required this.height,
      required this.notHaveImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.all(AppConstants.appBorderRadiusR15.responsiveSize),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR25.responsiveSize),
        color: AppColors.primary2,
      ),
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constrains.maxWidth * 0.6,
              child: LayoutBuilder(builder: (context, cons) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: cons.maxHeight * 0.4,
                      width: constrains.maxWidth * 0.6,
                      child: FittedBox(
                        child: Text(
                          title,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const AppTextStyle().balooBhaijaan2.w700.white.s20.displaySmall28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: cons.maxHeight * 0.4,
                      width: constrains.maxWidth * 0.6,
                      child: FittedBox(
                        child: Text(
                          description,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const AppTextStyle()
                              .balooBhaijaan2.w700
                              .white
                              .bodyLarge16,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              child: NullableNetworkImage(
                imagePath: imageUrl,
                notHaveImage: notHaveImage,
                height: constrains.maxHeight * 0.85,
                width: constrains.maxWidth * 0.35,
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      }),
    );
  }
}
