import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../core/shared_widget/text_with_icon.dart';

class LessonItemWidget extends StatelessWidget {
  final String lessonName;
  final String description;
  final String imagePath;
  final bool isCompleted;
  final bool isLock;
  final bool notHaveImage;
  final bool fromNafees;
  final Function() onTap;

  const LessonItemWidget(
      {super.key,
      required this.lessonName,
      required this.description,
      required this.notHaveImage,
      required this.imagePath,
      required this.isCompleted,
      required this.onTap,
      this.fromNafees = false,
      required this.isLock});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLock,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height:AppReference.deviceHeight(context) * 0.1.responsiveHeightRatio,
          padding: EdgeInsets.symmetric(
              horizontal:AppReference.deviceIsTablet? AppPadding.p10.responsiveWidth:AppPadding.p30.responsiveWidth,
              vertical: AppReference.deviceIsTablet?AppPadding.p4.responsiveHeight:AppPadding.p12.responsiveHeight),
          decoration: BoxDecoration(
            color: const Color(0xffECF2FC),
            borderRadius: BorderRadius.circular(
                AppReference.deviceIsTablet?
                AppConstants.appBorderRadiusR10.responsiveSize
                    : AppConstants.appBorderRadiusR20.responsiveSize),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color:AppColors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                spreadRadius: 0
              )
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constrains) => Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: constrains.maxHeight * 0.35,
                        width: constrains.maxWidth,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              lessonName,
                              style: AppReference.themeData.textTheme.titleLarge,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constrains.maxHeight * 0.4,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            description.isEmpty || description == 'لا يوجد وصف'? '' : description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppReference.themeData.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      if(!fromNafees)
                      SizedBox(
                        height: constrains.maxHeight * 0.25,
                        child: FittedBox(
                          child: TextAndIcon(
                            text: isLock
                                ? AppStrings.closed
                                : isCompleted
                                    ? AppStrings.finished
                                    : AppStrings.toLesson,
                            icon: isLock
                                ? Icons.lock
                                : isCompleted
                                    ? Icons.check_circle
                                    : Icons.arrow_forward,
                            fontSize: 18,
                            textColor: _textAndIconColor(),
                            iconColor: _textAndIconColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size:16.responsiveSize,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _textAndIconColor() => isLock
      ? AppColors.primaryColor
      : isCompleted
          ? AppColors.successColor
          : AppColors.primaryColor;
}

