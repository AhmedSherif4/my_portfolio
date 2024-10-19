import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_bloc.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_event.dart';
import 'package:my_portfolio/features/intro/welcome/views/landscape_view.dart';
import 'package:my_portfolio/features/intro/welcome/views/portait_view.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../config/storages/secure_storage.dart';
import '../../../core/api/network_info.dart';
import '../../../core/base_widgets/snackbar_widget.dart';
import '../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                height:AppReference.deviceIsTablet?AppReference.deviceHeight(context) *
              0.05.responsiveHeightRatio: AppReference.deviceHeight(context) *
                    0.1.responsiveHeightRatio,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImagesAssets.sLogoWithoutName,
                      height: AppReference.deviceIsTablet?AppReference.deviceHeight(context) *
                          0.035.responsiveHeightRatio:AppReference.deviceHeight(context) *
                          0.055.responsiveHeightRatio,
                    ),
                    AppSize.s20.sizedBoxWidth,
                    Text(
                      AppStrings.welcomeScreenTitle,
                      style: const AppTextStyle().balooBhaijaan2.w600.s20.displaySmall28.copyWith(
                        fontSize: AppReference.deviceIsTablet? AppFontSize.sp25 : AppSize.s22.responsiveFontSize
                      ),
                    ),

                    AppSize.s12.sizedBoxWidth,
                    SvgPicture.asset(
                      AppIconsAssets.sHand,
                      height: AppReference.deviceIsTablet?AppReference.deviceHeight(context) *
                          0.025.responsiveHeightRatio:AppReference.deviceHeight(context) *
                          0.055.responsiveHeightRatio,
                    ),

                  ],
                ),
              ),
              AppSize.s20.sizedBoxHeight,
              Text('هل تريد', style: const AppTextStyle().w600.bodyLarge16),
              AppSize.s30.sizedBoxHeight,
              ResponsiveWidgetForTablet(
                mobile: OrientationItem(
                  portraitWidget: WelcomeScreenPortraitView(
                    goToSignUp: () {
                      _goToSignUp(context);
                    },
                    goToLogIn: () {
                      _goToLogIn(context);
                    },
                    goToHome:


                        () async{
                      if (!await getIt<NetworkInfo>().isConnected) {
                       showSnackBar(
                      description: AppStrings.noInternetConnection,
                      state: ToastStates.warning,
                      context: context,
                      );
                      }else{
                      _goToHome(context);}
                    },
                  ),
                  landscapeWidget: WelcomeScreenLandscapeView(
                    goToSignUp: () {
                      _goToSignUp(context);
                    },
                    goToLogIn: () {
                      _goToLogIn(context);
                    },
                    goToHome: () {
                      _goToHome(context);
                    },
                  ),
                ),
                tablet: Center(
                  child: WelcomeScreenPortraitView(
                    goToSignUp: () {
                      _goToSignUp(context);
                    },
                    goToLogIn: () {
                      _goToLogIn(context);
                    },
                    goToHome:


                        () async{
                      if (!await getIt<NetworkInfo>().isConnected) {
                        showSnackBar(
                          description: AppStrings.noInternetConnection,
                          state: ToastStates.warning,
                          context: context,
                        );
                      }else{
                        _goToHome(context);}
                    },
                  ),
                ) ,
              ),
            ],
          ),
        ).paddingBody(
          start: 20,
          end: 20,
        ),
      ),
    );
  }

  void _goToSignUp(context) {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rSignUpScreen,
    );
  }

  void _goToLogIn(context) {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rLoginScreen,
    );
  }

  void _goToHome(context) async {
      getIt<BaseAppSecurityData>().deleteToken().then((value) {
        BlocProvider.of<GlobalBloc>(context).add(GetGuestDataEvent());
        BlocProvider
            .of<GlobalBloc>(context)
            .stream
            .listen((event) {
          if (event.getGuestDataState == RequestStates.loaded) {
            RouteManager.rPushNamed(
              context: context,
              rName: AppRoutesNames.rHomeLayoutView,
              arguments: getIt<UserLocalDataSource>().getUserData(),
            );
          }
        });
      });
      }
}



