import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../my_app/app_reference.dart';

class BaseSendInvetionSuccessfully extends StatelessWidget {
  final String title;
  final List<InlineSpan>? description;
  final String image;
  final double imageWidth;
  final double imageHeight;
  final bool isParentPath;

  const BaseSendInvetionSuccessfully({
    super.key,
    required this.title,
    this.description,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    required this.isParentPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: ResponsiveWidgetForTablet(
          mobile: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: RichText(
                  text: TextSpan(
                    text: '$title\n',
                    style: AppTextStyle.displaySmall28,
                    children: description,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppPadding.p20.responsiveHeight),
                child: SvgPicture.asset(
                  image,
                  width: imageWidth.responsiveWidth,
                  height: imageHeight.responsiveHeight,
                ),
              ),
              if (!isParentPath) const _GoToHomeButton(),
              if (isParentPath) const _ButtonParentScreen(),
            ],
          ).paddingBody(),
          tablet: Center(
            child: SizedBox(
              width: AppReference.deviceWidth(context)*0.4,
              height: AppReference.deviceHeight(context)*0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: RichText(
                      textAlign: AppReference.deviceIsTablet?TextAlign.center:TextAlign.start,
                      text: TextSpan(
                        text: '$title\n',
                        style: AppTextStyle.displaySmall28,
                        children: description,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppPadding.p40.responsiveHeight),
                    child: SvgPicture.asset(
                      image,
                      width: imageWidth.responsiveWidth,
                      height: imageHeight.responsiveHeight,
                    ),
                  ),
                  if (!isParentPath) const _GoToHomeButton(),
                  if (isParentPath) const _ButtonParentScreen(),
                ],
              ).paddingBody(),
            ),
          ),
        ),
      )),
    );
  }
}

class _GoToHomeButton extends StatelessWidget {
  const _GoToHomeButton();

  @override
  Widget build(BuildContext context) {
    return DefaultButtonWidget(
      label: AppStrings.homeScreen,
      textFontSize: AppFontSize.sp16,
      onPressed: () {
        final userData = getIt<UserLocalDataSource>().getUserData();
        RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rHomeLayoutView,
          arguments: userData,
        );
      },
      buttonColor: AppColors.primaryColor,
    );
  }
}

class _ButtonParentScreen extends StatelessWidget {
  const _ButtonParentScreen();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DefaultButtonWidget(
                label: AppStrings.addAnotherChild,
                textFontSize: AppFontSize.sp16,
                onPressed: () {
                  RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rParentAddChildWays);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p8.responsiveWidth),
              child: Text(
                AppStrings.or,
                style: AppReference.themeData.textTheme.bodyLarge,
              ),
            ),
            const Expanded(
              child: _GoToHomeButton(),
            ),
          ],
        ),
      ],
    );
  }
}
