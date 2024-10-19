import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/features/shared_features/sign_with_social_media/presentation/social_media_view_model/social_media_state.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/routes/route_manager.dart';
import '../../../../../config/routes/routes_names.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_widget/custom_inkwell.dart';
import '../social_media_view_model/social_media_bloc.dart';
import '../social_media_view_model/social_media_event.dart';


class SocialMediaInkWell extends StatelessWidget {

  const SocialMediaInkWell({super.key,
    required this.socialMediaWidget, required this.isAgree, required this.isLogin,});

  final Widget socialMediaWidget;
  final bool isAgree;
  final bool isLogin;


  _getGoogleID(context) async {
    BlocProvider.of<SignWithSocialMediaBloc>(context).add(GetGoogleIdAndUserDataByGoogleAccountEvent());
  }



  @override
  Widget build(BuildContext context) {
    void goToHome() {
      RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rHomeLayoutView,
          arguments: BlocProvider.of<SignWithSocialMediaBloc>(context).userData);
    }

    void checkChildIsBlockedOrNot(String loginMessage) {
      if (BlocProvider.of<SignWithSocialMediaBloc>(context).userData.lock == "yes") {
        showSnackBar(
            description: BlocProvider.of<SignWithSocialMediaBloc>(context).userData.lockMessage ??
                AppStrings.contactWithOwner,
            state: ToastStates.error,
            context: context);
        return;
      } else {
        showSnackBar(
          description: loginMessage,
          state: ToastStates.congrats,
          context: context,
        );
        goToHome();
      }
    }


    void checkChildHaveStageOrNot(loginMessage) {
      if (BlocProvider.of<SignWithSocialMediaBloc>(context).userData.stageId != 0) {
        checkChildIsBlockedOrNot(loginMessage);
      } else {
        Navigator.pushReplacementNamed(
          context,
          AppRoutesNames.rGradeChoosingScreen,
          arguments: false,
        );
      }
    }

    void checkUserIsChild(String loginMessage) {
      if (BlocProvider.of<SignWithSocialMediaBloc>(context).userData.type == UsersType.child.name) {
        checkChildHaveStageOrNot(loginMessage);
      } else {
        showSnackBar(
          description: loginMessage,
          state: ToastStates.congrats,
          context: context,
        );
        goToHome();
      }
    }


    return BlocProvider(
      create: (_) => getIt<SignWithSocialMediaBloc>(),
      child: Builder(
          builder: (buildCtx) {
            return Center(
              child: CustomInkWell(
                onTap: isLogin?()async{
              _getGoogleID(buildCtx);
          }:() async {
                  if (!isAgree){
                    showSnackBar(
                      description: AppStrings.alarmForApplicationPoliciesAndPrivacy,
                      state: ToastStates.warning,
                      context: context,
                    );}else{
                  _getGoogleID(buildCtx);}
                },
                child: Builder(
                  builder: (context) {
                    return BlocListener<SignWithSocialMediaBloc, SignWithSocialMediaState>(
                        listener: (_, state) {
                          if (state.getGoogleIdAndUserDataByGoogleAccountState ==
                              RequestStates.loaded) {
                            context.read<SignWithSocialMediaBloc>().add(SocialLoginEvent(
                                socialId: state.socialLoginDataEntity.socialId));
                          }
                          switch (state.socialLoginStates) {
                            case RequestStates.loading:
                              showLoadingDialog(buildCtx);
                            case RequestStates.loaded:
                              checkUserIsChild(state.loginMessage);
                            case RequestStates.error:
                              Navigator.of(context).pop();
                              RouteManager.rPushNamed(
                                context: context,
                                rName: AppRoutesNames.rCompleteProfileScreen,
                                arguments: state.socialLoginDataEntity,
                              );
                            default:
                          }
                        },
                      child: socialMediaWidget,
                    );
                  }
                ),
              ),
            );
          }
      ),
    );

  }
}
