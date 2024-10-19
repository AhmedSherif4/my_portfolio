import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

class GroupItemWidget extends StatelessWidget {
  final String groupNumber;
  final Function() onTap;

  const GroupItemWidget(
      {super.key, required this.groupNumber, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppReference.deviceHeight(context) * 0.07.responsiveHeightRatio,
        padding: EdgeInsets.symmetric(horizontal: 35.responsiveWidth),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(25.responsiveSize)),
        child: LayoutBuilder(builder: (context, constrains) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constrains.minHeight * 0.7,
                child: FittedBox(
                  child: Text(
                    groupNumber,
                    style: AppReference.themeData.textTheme.titleMedium!
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ),
              SizedBox(
                height: constrains.minHeight * 0.1,
                child: const Divider(
                  thickness: 3,
                  color: AppColors.white,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
