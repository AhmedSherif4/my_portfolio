import 'package:flutter/material.dart';

import '../../../config/resources/app_strings.dart';
import '../../../config/resources/app_values.dart';
import '../../validation/app_validation.dart';
import '../text_form_field.dart';

class ConfirmPasswordInputFiled extends StatefulWidget {
  final TextEditingController confirmPasswordController;
  final FocusNode confirmPasswordFocusNode;

  const ConfirmPasswordInputFiled({
    super.key,
    required this.confirmPasswordController,
    required this.confirmPasswordFocusNode,
  });

  @override
  State<ConfirmPasswordInputFiled> createState() =>
      _ConfirmPasswordInputFiledState();
}

class _ConfirmPasswordInputFiledState extends State<ConfirmPasswordInputFiled> {
  bool isObscureTextForConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      textDirection: TextDirection.ltr,
      topSizedBox: AppSize.s20,
      controller: widget.confirmPasswordController,
      label: AppStrings.confirmPassword,
      keyboardType: TextInputType.visiblePassword,
      validator: AppValidation.passwordValidation(),
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      focusNode: widget.confirmPasswordFocusNode,
      isObscureText: isObscureTextForConfirmPassword,
      inputAction: TextInputAction.next,
      bottomSizedBox: 20,
      suffixIcon: isObscureTextForConfirmPassword
          ? Icons.remove_red_eye_outlined
          : Icons.hide_source_outlined,
      suffixIconOnPress: () {
        setState(() {
          isObscureTextForConfirmPassword = !isObscureTextForConfirmPassword;
        });
      },
    );
  }
}
