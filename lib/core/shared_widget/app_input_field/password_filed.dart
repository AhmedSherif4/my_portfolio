import 'package:flutter/material.dart';

import '../../../config/resources/app_strings.dart';
import '../../../config/resources/app_values.dart';
import '../../validation/app_validation.dart';
import '../text_form_field.dart';

class PasswordInputFiled extends StatefulWidget {
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final FocusNode? nextFocusNode;
  final String label;

  const PasswordInputFiled(
      {super.key,
      required this.passwordController,
      required this.passwordFocusNode,
      this.label=AppStrings.password,
      this.nextFocusNode});

  @override
  State<PasswordInputFiled> createState() => _PasswordInputFiledState();
}

class _PasswordInputFiledState extends State<PasswordInputFiled> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      textDirection: TextDirection.ltr,
      topSizedBox: AppSize.s20,
      controller: widget.passwordController,
      label: widget.label,
      keyboardType: TextInputType.visiblePassword,
      validator: AppValidation.passwordValidation(),
      onFieldSubmitted: (value) => widget.nextFocusNode != null
          ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
          : FocusScope.of(context).unfocus(),
      isObscureText: isObscureText,
      focusNode: widget.passwordFocusNode,
      inputAction: TextInputAction.next,
      suffixIcon: isObscureText
          ? Icons.remove_red_eye_outlined
          : Icons.hide_source_outlined,
      suffixIconOnPress: () {
        setState(() {
          isObscureText = !isObscureText;
        });
      },
    );
  }
}
