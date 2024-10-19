import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../config/resources/app_colors.dart';
import '../../config/resources/app_constants.dart';
import '../../my_app/app_reference.dart';

class DefaultDropDownButton<T> extends StatelessWidget {
  final List<T> studyingData;
  final T selectedItem;
  final Function(T?) onChange;
  final String Function(T) displayText;
  final String? icon;
  final bool withSuffixIcon;
  final double borderRadius;
  final Color color;
  final Color labelColor;

  const DefaultDropDownButton({
    super.key,
    required this.studyingData,
    required this.selectedItem,
    required this.onChange,
    required this.displayText,
    this.icon=AppIconsAssets.sDropDownMenuButtonBlue,
    this.withSuffixIcon=false,
    this.color = AppColors.white,
    this.labelColor = AppColors.textColor,
    this.borderRadius = AppConstants.appBorderRadiusR30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(horizontal: 15.responsiveWidth,vertical: 5.responsiveHeight),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          borderRadius.responsiveSize
          //,
        ),
      ),
      child: Row(
        children: [
          if(withSuffixIcon)...[
          SvgPicture.asset(AppIconsAssets.sDropDownMenuButtonBlue),
          AppSize.s10.sizedBoxWidth
          ],
          Expanded(
            child: DropdownButton<T>(

              menuMaxHeight:
                  AppReference.deviceHeight(context) * 0.3.responsiveHeightRatio,
              elevation: 12,
              style: AppReference.themeData.textTheme.bodyLarge,
              isExpanded: true,
              dropdownColor: AppColors.backgroundColor,
              underline: const SizedBox(),
              items: studyingData
                  .map((T item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          displayText(item),
                          style: const AppTextStyle().bodyLarge16.copyWith(
                            fontSize: AppFontSize.sp16.responsiveFontSize,
                            color: labelColor,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: onChange,
              value: selectedItem,
             icon: icon !=null?SvgPicture.asset(icon!):const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
