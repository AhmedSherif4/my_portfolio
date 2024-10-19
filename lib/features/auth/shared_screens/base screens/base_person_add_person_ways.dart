import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/core/shared_widget/text_button_widget.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../intro/global/global_view_model/global_bloc.dart';

class BasePersonAddPersonWays extends StatelessWidget {
  final String title;
  final String buttonTitle1;
  final Function() buttonOnPressed1;
  final String buttonTitle2;
  final Function() buttonOnPressed2;
  final bool fromParentsScreen;

  const BasePersonAddPersonWays({
    super.key,
    required this.title,
    required this.buttonTitle1,
    required this.buttonOnPressed1,
    required this.buttonTitle2,
    required this.buttonOnPressed2,
    this.fromParentsScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveWidgetForTablet(
            mobile: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: !fromParentsScreen ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
                    child: !fromParentsScreen
                        ? TextButtonWidget(
                            text: AppStrings.notNow,
                            onPressed: () {
                              final userData =
                                  getIt<UserLocalDataSource>().getUserData();
                              context.read<GlobalBloc>().fromRegister=true;
                              RouteManager.rPushNamedAndRemoveUntil(
                                  context: context,
                                  rName: AppRoutesNames.rHomeLayoutView,
                                  arguments: userData);
                            },
                          )
                        : const TextBackButton(),
                  ),
                  AppSize.s30.sizedBoxHeight,
                  Text(
                    '${AppStrings.welcome}\n$title',
                    textAlign: TextAlign.center,
                    style: const AppTextStyle().balooBhaijaan2.w500.displaySmall28,
                  ),
                  (AppReference.deviceHeight(context) * 0.2).sizedBoxHeight,
                  DefaultButtonWidget(
                    label: buttonTitle1,
                    onPressed: buttonOnPressed1,
                    isExpanded: true,
                  ).paddingBody(
                    bottom: 0,
                    top: 0,
                  ),
                  AppSize.s50.sizedBoxHeight,
                  DefaultButtonWidget(
                    label: buttonTitle2,
                    onPressed: buttonOnPressed2,
                    isExpanded: true,
                  ).paddingBody(
                    bottom: 0,
                    top: 0,
                  ),
                ]).paddingBody(),
            tablet: OrientationItem(
              portraitWidget:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: !fromParentsScreen
                          ? TextButtonWidget(
                        text: AppStrings.notNow,
                        onPressed: () {
                          final userData =
                          getIt<UserLocalDataSource>().getUserData();
                          RouteManager.rPushNamedAndRemoveUntil(
                              context: context,
                              rName: AppRoutesNames.rHomeLayoutView,
                              arguments: userData);
                        },
                      )
                          : const TextBackButton(),
                    ),
                    AppSize.s30.sizedBoxHeight,
                    Text(
                      '${AppStrings.welcome}\n$title',
                      textAlign: TextAlign.center,
                      style: const AppTextStyle().balooBhaijaan2.w500.displaySmall28,
                    ),
                    (AppReference.deviceHeight(context) * 0.2).sizedBoxHeight,
                    DefaultButtonWidget(
                      label: buttonTitle1,
                      onPressed: buttonOnPressed1,
                      isExpanded: true,
                    ).paddingBody(
                      bottom: 0,
                      top: 0,
                    ),
                    AppSize.s50.sizedBoxHeight,
                    DefaultButtonWidget(
                      label: buttonTitle2,
                      onPressed: buttonOnPressed2,
                      isExpanded: true,
                    ).paddingBody(
                      bottom: 0,
                      top: 0,
                    ),
                  ]).paddingBody(),
              landscapeWidget: Center(
                child: SizedBox(
                  width: AppReference.deviceWidth(context) * 0.45,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment:fromParentsScreen? AlignmentDirectional.topEnd:AlignmentDirectional.topStart,
                          child: !fromParentsScreen
                              ? TextButtonWidget(
                            text: AppStrings.notNow,
                            onPressed: () {
                              final userData =
                              getIt<UserLocalDataSource>().getUserData();
                              RouteManager.rPushNamedAndRemoveUntil(
                                  context: context,
                                  rName: AppRoutesNames.rHomeLayoutView,
                                  arguments: userData);
                            },
                          )
                              : const TextBackButton(),
                        ),
                        AppSize.s80.sizedBoxHeight,
                        Text(
                          '${AppStrings.welcome}\n$title',
                          textAlign: TextAlign.center,
                          style: AppReference.deviceIsTablet?const AppTextStyle().balooBhaijaan2.s40.w500.displayLarge32:const AppTextStyle().balooBhaijaan2.s20.w500.displaySmall28,
                        ),
                        (AppReference.deviceHeight(context) * 0.2).sizedBoxHeight,
                        DefaultButtonWidget(
                          label: buttonTitle1,
                          onPressed: buttonOnPressed1,
                          isExpanded: true,
                        ).paddingBody(
                          bottom: 0,
                          top: 0,
                        ),
                        AppSize.s50.sizedBoxHeight,
                        DefaultButtonWidget(
                          label: buttonTitle2,
                          onPressed: buttonOnPressed2,
                          isExpanded: true,
                        ).paddingBody(
                          bottom: 0,
                          top: 0,
                        ),
                      ]).paddingBody(),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
