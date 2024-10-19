import 'package:flutter/material.dart';
import '../text_form_field.dart';

class PhoneInputFiled extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode? phoneFocusNode;
  final FocusNode? nextFocusNode;
  final String? label;

  const PhoneInputFiled(
      {super.key,
      required this.phoneController,
        this.label,
      this.phoneFocusNode,
      this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      label: label,
      textDirection: TextDirection.ltr,
      //topSizedBox: AppSize.s20,
      controller: phoneController,
      keyboardType: TextInputType.number,
       //validator: AppValidation.phoneNumberValidation(),
      onFieldSubmitted: (value) => phoneFocusNode != null
          ? FocusScope.of(context).requestFocus(nextFocusNode)
          : FocusScope.of(context).unfocus(),
      focusNode: phoneFocusNode,
      inputAction: TextInputAction.next,
    );
  }
}
