import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../config/resources/app_strings.dart';
import '../components/app_bar.dart';
import '../components/custom_bottom_app_bar.dart';

class HomeAndroid extends StatelessWidget {
  const HomeAndroid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBarWidget(),
              ResponsiveDisplayLargeWidget(
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
