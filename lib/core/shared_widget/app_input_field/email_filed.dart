import 'package:flutter/material.dart';

import '../../../config/resources/app_strings.dart';
import '../../../config/resources/app_values.dart';
import '../../validation/app_validation.dart';
import '../text_form_field.dart';

class EmailInputFiled extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode? emailFocusNode;
  final FocusNode? nextFocusNode;
  final bool isLoginScreen;

  const EmailInputFiled({
    super.key,
    required this.emailController,
    this.emailFocusNode,
    this.nextFocusNode,
    this.isLoginScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      textDirection: TextDirection.ltr,
      topSizedBox: AppSize.s20,
      controller: emailController,
      label: isLoginScreen ? AppStrings.emailOptional : AppStrings.email,
      keyboardType: TextInputType.emailAddress,
      validator: isLoginScreen&&emailController.text.isEmpty ? null : AppValidation.emailValidation(),
      onFieldSubmitted: (value) => emailFocusNode != null
          ? FocusScope.of(context).requestFocus(nextFocusNode)
          : FocusScope.of(context).unfocus(),
      focusNode: emailFocusNode,
      inputAction: TextInputAction.next,
    );
  }
}
