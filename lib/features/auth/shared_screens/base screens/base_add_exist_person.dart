import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/app_input_field/username_filed.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';

import '../../../../config/responsive/responsive_widget.dart';
import '../../../../my_app/app_reference.dart';

class BaseAddExistPerson extends StatefulWidget {
  final Function() buttonOnPressed;

  final TextEditingController textEditingController;

  final double imageWidth;
  final double imageHeight;
  final String title;
  final List<InlineSpan>? description;

  final String image;

  const BaseAddExistPerson({
    super.key,
    required this.buttonOnPressed,
    required this.title,
    this.description,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    required this.textEditingController,
  });

  @override
  State<BaseAddExistPerson> createState() => _BaseAddExistPersonState();
}

class _BaseAddExistPersonState extends State<BaseAddExistPerson> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextBackButton(),
                ),
                AppSize.s20.sizedBoxHeight,
                if(!AppReference.deviceIsTablet||(AppReference.deviceIsTablet&&AppReference.isPortrait(context)))...[
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: RichText(
                    text: TextSpan(
                      text: '${widget.title}\n',
                      style: const AppTextStyle().balooBhaijaan2.w600.displaySmall28,
                      children: widget.description,
                    ),
                  ),
                ),],
                ResponsiveWidgetForTablet(
                  mobile: OrientationItem(
                    portraitWidget: Column(children: [
                      SvgPicture.asset(
                        widget.image,
                        width: widget.imageWidth,
                        height: widget.imageHeight,
                      ),
                      AppSize.s50.sizedBoxHeight,
                      UserNameInputFiled(
                        controller: widget.textEditingController,
                      ),
                    ]),
                    landscapeWidget: SizedBox(
                      height: AppReference.deviceHeight(context) * 0.4,
                      child: Row(
                        children: [
                          Expanded(
                            child: UserNameInputFiled(
                              controller: widget.textEditingController,
                            ),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              widget.image,
                              width: double.infinity,
                              height: widget.imageHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  tablet:OrientationItem(
                    portraitWidget: Column(children: [
                      SvgPicture.asset(
                        widget.image,
                        width: widget.imageWidth,
                        height: widget.imageHeight,
                      ),
                      AppSize.s50.sizedBoxHeight,
                      UserNameInputFiled(
                        controller: widget.textEditingController,
                      ),
                    ]),

                    landscapeWidget: SizedBox(
                      height: AppReference.deviceHeight(context) * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: SizedBox(
                              width: AppReference.deviceWidth(context) * 0.6,
                              child: RichText(
                                text: TextSpan(
                                  text: '${widget.title}\n',
                                  style:const AppTextStyle().balooBhaijaan2.w600.titleMedium20.copyWith(
                                    fontSize: AppFontSize.sp40.responsiveFontSize,
                                  ),
                                  children: widget.description,
                                ),
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: AppReference.deviceWidth(context) * 0.4,
                                child: Column(
                                  children: [
                                    UserNameInputFiled(
                                      controller: widget.textEditingController,
                                    ),
                                    AppSize.s30.sizedBoxHeight,
                                    DefaultButtonWidget(
                                      label: AppStrings.send,
                                      onPressed: widget.buttonOnPressed,
                                    ),
                                  ],
                                ),
                              ),
                              AppSize.s60.sizedBoxWidth,
                              SizedBox(
                                width: AppReference.deviceWidth(context) * 0.3,
                                child: SvgPicture.asset(
                                  widget.image,
                                  width: double.infinity,
                                  height: widget.imageHeight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) ,
                ),
                if(!AppReference.deviceIsTablet||(AppReference.deviceIsTablet&&AppReference.isPortrait(context)))...[
                  DefaultButtonWidget(
                    label: AppStrings.send,
                    onPressed: widget.buttonOnPressed,
                  ),
                ]
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }
}
