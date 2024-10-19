import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/core/shared_widget/app_input_field/phone_filed.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../../config/resources/app_strings.dart';
import '../../../../../../../core/shared_widget/button_widget.dart';
import '../../../../core/shared_widget/text_form_field.dart';

class BaseAddNewPerson extends StatefulWidget {
  final String title;
  final String iconPath;
  final bool isParentPath;
  final dynamic Function() onPressed;
  final TextEditingController emailOrPhoneController;

  const BaseAddNewPerson({
    super.key,
    required this.title,
    required this.iconPath,
    required this.isParentPath,
    required this.onPressed,
    required this.emailOrPhoneController,
  });

  @override
  State<BaseAddNewPerson> createState() => _BaseAddNewPersonState();
}

class _BaseAddNewPersonState extends State<BaseAddNewPerson> {
  late final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:ResponsiveWidgetForTablet(
              mobile: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextBackButton(),
                    ),
                    Text(
                      widget.title,
                      style: const AppTextStyle().balooBhaijaan2.w500.displaySmall28,
                    ),
                    AppSize.s50.sizedBoxHeight,
                    SvgPicture.asset(widget.iconPath,
                      width: AppSize.s90.responsiveWidth,
                      height: AppSize.s90.responsiveHeight,
                    ),
                    AppSize.s50.sizedBoxHeight,
                    TextFormFieldWidget(
                      label: AppStrings.phone,
                      textDirection: TextDirection.ltr,
                      //topSizedBox: AppSize.s20,
                      controller: widget.emailOrPhoneController,
                      keyboardType: TextInputType.number,
                      //validator: AppValidation.phoneNumberValidation(),
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return 'برجاء كتابة رقم الجوال';
                        } else if (phone.length < 5) {
                          return 'رقم الجوال يجب أن يكون على الاقل 5 أرقام';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value){}, inputAction: TextInputAction.done,
                    ),
                    // PhoneInputFiled(
                    //   label: AppStrings.phone,
                    //     phoneController: widget.emailOrPhoneController,
                    //
                    //   ),
                    (AppReference.deviceHeight(context) * 0.1).sizedBoxHeight,
                    Center(
                      child: DefaultButtonWidget(
                        label: AppStrings.login,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.onPressed();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              tablet: OrientationItem(
                portraitWidget: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextBackButton(),
                      ),
                      Text(
                        widget.title,
                        style: const AppTextStyle().balooBhaijaan2.w500.displaySmall28,
                      ),
                      AppSize.s50.sizedBoxHeight,
                      SvgPicture.asset(widget.iconPath,
                        width: AppSize.s90.responsiveWidth,
                        height: AppSize.s90.responsiveHeight,
                      ),
                      AppSize.s50.sizedBoxHeight,
                      PhoneInputFiled(
                        label: AppStrings.phone,
                        phoneController: widget.emailOrPhoneController,
                      ),
                      (AppReference.deviceHeight(context) * 0.1).sizedBoxHeight,
                      Center(
                        child: DefaultButtonWidget(
                          label: AppStrings.login,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onPressed();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                landscapeWidget: Form(
                  key: _formKey,
                  child: Column(

                    children: [
                      const Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextBackButton(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: AppReference.deviceWidth(context) * 0.3,
                            height: AppReference.deviceHeight(context) * 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.title,
                                  style: const AppTextStyle().balooBhaijaan2.s20.w500.displaySmall28,
                                ),
                                AppSize.s50.sizedBoxHeight,
                                PhoneInputFiled(
                                  label: AppStrings.phone,
                                    phoneController: widget.emailOrPhoneController,
                                  ),
                                (AppReference.deviceHeight(context) * 0.1).sizedBoxHeight,
                                Center(
                                  child: DefaultButtonWidget(
                                    label: AppStrings.login,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        widget.onPressed();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSize.s50.sizedBoxWidth,
                          SizedBox(
                            width: AppReference.deviceWidth(context) * 0.3,
                            height: AppReference.deviceHeight(context) * 0.3,

                            child:  SvgPicture.asset(widget.iconPath,
                              width: AppSize.s90.responsiveWidth,
                              height: AppSize.s90.responsiveHeight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ).paddingBody(start: 15, top: 25, end: 15, bottom: 25),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
