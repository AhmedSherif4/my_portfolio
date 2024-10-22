import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../config/responsive/responsive_text_widget.dart';
import '../components/app_bar.dart';
import '../components/custom_bottom_app_bar.dart';

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBarWidget(),
              ResponsiveDisplayLargeAnimatedWidget(
                label: AppStrings.welcome.tr(),
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              Container(
                height: 200.responsiveHeight,
              ),
              CustomBottomAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Welcome',
          style: AppTextStyle()
              .displayLarge40w4
              .copyWith(fontFamily: AppTextStyle.playfairDisplay),
        ),
      ),
    );
  }
}
