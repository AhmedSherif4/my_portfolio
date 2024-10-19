import 'package:flutter/material.dart';

import '../../../config/resources/app_strings.dart';
import '../../../config/resources/app_values.dart';
import '../text_form_field.dart';

class UserNameInputFiled extends StatelessWidget {
  final TextEditingController controller;

  const UserNameInputFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      topSizedBox: AppSize.s10,
      label: AppStrings.userName,
      controller: controller,
      hintText: '11223344',
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.send,
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
      bottomSizedBox: AppSize.s58,
    );
  }
}
