import 'package:flutter/material.dart';
import 'package:my_portfolio/config/extensions/color_extension.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_shadow.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

class BaseListTile extends StatelessWidget {
  final String title;
  final String? description;
  final bool isHaveDescription;
  final String imagePath;
  final TextStyle titleStyle;
  final TextStyle? descriptionStyle;
  final Function() onTap;
  final String backgroundColor;
  final bool notHaveImage;
  final BoxFit? imageBoxFit;

  const BaseListTile(
      {super.key,
      required this.title,
      this.description,
      required this.imagePath,
      required this.titleStyle,
      this.descriptionStyle,
      required this.onTap,
      this.notHaveImage = false,
      this.isHaveDescription = false,
      required this.backgroundColor,
      this.imageBoxFit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppReference.deviceIsTablet
            ? AppReference.deviceHeight(context) * .13
            : AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio,
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p18.responsiveWidth,
            vertical: AppPadding.p5.responsiveHeight),
        decoration: BoxDecoration(
          color: HexColor.fromHex(backgroundColor.isEmpty
              ? AppConstants.primaryColorHexCode
              : backgroundColor),
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR15.responsiveSize),
          boxShadow: [AppShadow.appBoxShadow()],
        ),
        child: LayoutBuilder(
            builder: (context, constrains) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: constrains.maxWidth * 0.63,
                      height: constrains.maxHeight,
                      child:
                          LayoutBuilder(builder: (context, constrainsColumn) {
                        return isHaveDescription
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: constrainsColumn.maxHeight * 0.4,
                                    child: FittedBox(
                                      child: Text(
                                        title,
                                        style: titleStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: constrainsColumn.maxHeight * 0.6,
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Text(
                                        description!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: descriptionStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  title,
                                  style: titleStyle,
                                ),
                              );
                      }),
                    ),
                    SizedBox(
                        width: constrains.maxWidth * 0.36,
                        height: constrains.maxHeight,
                        child: NullableNetworkImage(
                          imagePath: imagePath,
                          width: constrains.maxWidth * 0.36,
                          height: constrains.maxHeight,
                          fit: imageBoxFit ?? BoxFit.fill,
                          notHaveImage: notHaveImage,
                        )),
                  ],
                )),
      ),
    );
  }
}
