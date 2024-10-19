import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../config/resources/app_colors.dart';
import '../../config/resources/app_constants.dart';
import '../../my_app/app_reference.dart';

class TextFormFieldWidget extends StatelessWidget {
  final double bottomSizedBox;
  final double topSizedBox;
  final double? hintTextSize;
  final TextEditingController controller;
  final TextDirection textDirection;

  final String? hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String? label;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction inputAction;
  final bool isObscureText;
  final bool isReadOnly;

  final IconData? suffixIcon;
  final Function()? suffixIconOnPress;
  final String? Function(String?)? validator;
  final int maxLine;

  final List<TextInputFormatter>? inputFormatters;
  final bool isPaymentScreen;
  final Widget? suffixWidget;
  final Color? suffixIconColor;
  final double? horizontalPadding;
  final double? verticalPadding;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.hintTextSize,
    required this.keyboardType,
    this.focusNode,
    this.horizontalPadding=10,
    this.verticalPadding=0,
    required this.inputAction,
    this.isObscureText = false,
    this.textDirection = TextDirection.rtl,
    this.suffixIcon,
    this.suffixIconOnPress,
    this.validator,
    this.maxLine = 1,
     this.label,
    this.bottomSizedBox = 0,
    this.topSizedBox = 0,
    required this.onFieldSubmitted,
    this.inputFormatters,
    this.isPaymentScreen = false,
    this.isReadOnly = false,
    this.suffixWidget, this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isPaymentScreen ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        topSizedBox.sizedBoxHeight,
        if(label != null)
        Text(
          label!,
          style:AppReference.deviceIsTablet? AppTextStyle.bodySmall12: const AppTextStyle().w500.bodyMedium14,
        ),
        AppSize.s10.sizedBoxHeight,
        TextFormField(
          textDirection: textDirection,
          readOnly: isReadOnly,
          controller: controller,
          autocorrect: true,
          maxLines: maxLine,
          validator: validator,
          style: AppReference.themeData.textTheme.bodyLarge,
          keyboardType: keyboardType,
          cursorColor: AppColors.primaryColor,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: inputAction,
          obscureText: isObscureText,
          enableSuggestions: true,
          decoration: InputDecoration(

            filled: true,
            fillColor: AppColors.white,
            hintText: hintText,
            suffixIcon: isPaymentScreen
                ? suffixWidget
                : suffixIcon == null
                    ? null
                    : IconButton(
                        icon: Icon(
                          suffixIcon,
                          size: AppConstants.iconSizeS20,
                          color: suffixIconColor ?? AppColors.black,
                        ),
                        onPressed: suffixIconOnPress,
                      ),
            hintStyle: AppReference.themeData.inputDecorationTheme.hintStyle!.copyWith(
              fontSize: hintTextSize ?? AppFontSize.sp12.responsiveFontSize,
              color: AppColors.textColor5
            ),
            enabledBorder:
                AppReference.themeData.inputDecorationTheme.enabledBorder,
            focusedBorder:
                AppReference.themeData.inputDecorationTheme.focusedBorder,
            errorBorder:
                AppReference.themeData.inputDecorationTheme.errorBorder,
            focusedErrorBorder:
                AppReference.themeData.inputDecorationTheme.focusedErrorBorder,
            disabledBorder:
                AppReference.themeData.inputDecorationTheme.disabledBorder,
            border: AppReference.themeData.inputDecorationTheme.border,
            errorMaxLines:
                AppReference.themeData.inputDecorationTheme.errorMaxLines,
            errorStyle: AppReference.themeData.inputDecorationTheme.errorStyle,
            focusColor: AppColors.primaryColor,
            contentPadding: AppReference.deviceIsTablet
                ? EdgeInsets.symmetric(
                    vertical: 7.responsiveHeight,
                    horizontal: 15.responsiveWidth)
                :  EdgeInsets.symmetric(horizontal: horizontalPadding!, vertical: verticalPadding!),
          ),
          inputFormatters: inputFormatters,
        ),
        bottomSizedBox.sizedBoxHeight,
      ],
    );
  }
}
