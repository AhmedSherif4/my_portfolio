import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/select_gender.dart';
import 'package:my_portfolio/core/shared_widget/select_type_of_user.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/social_register_view_model/social_register_bloc.dart';
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/social_register_view_model/social_register_event.dart';
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/social_register_view_model/social_register_state.dart';
import '../../../../config/resources/app_strings.dart';
import '../../../../config/storages/keys.dart';
import '../../../../core/shared_widget/dialogs/default_alert_dialog.dart';
import '../../../../my_app/app_reference.dart';
import '../../../intro/global/global_view_model/global_bloc.dart';
import '../../../shared_features/get_social_data/domain/entity/social_login_data_entity.dart';
import 'domain/social_register_usecases/social_register_usecase.dart';

class CompleteProfileScreen extends StatefulWidget {
  final SocialLoginDataEntity socialLoginDataEntity;

  const CompleteProfileScreen(
      {super.key, required this.socialLoginDataEntity});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState
    extends State<CompleteProfileScreen> {
  UsersType userType = UsersType.child;
  GenderType genderType = GenderType.male;


  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  void _goToGradeChoosingScreen() {
    RouteManager.rPushNamedAndRemoveUntil(
      context: context,
      rName: AppRoutesNames.rGradeChoosingScreen,
      arguments: false,
    );
  }

  void _checkUserTypeThenNavigateToNextScreen() {
    switch (userType.name) {
      case AppKeys.childKey:
        _goToGradeChoosingScreen();

      case AppKeys.parentKey:
        RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rParentAddChildWays,
        );

      case AppKeys.institutionKey:
        context.read<GlobalBloc>().fromRegister=true;
        RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rHomeLayoutView,
          arguments: context.read<SocialRegisterBloc>().userData,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialRegisterBloc, SocialRegisterState>(
      listener: (context, state) {
        switch (state.signUpStates) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            _checkUserTypeThenNavigateToNextScreen();
          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
                description: state.signUpMessage,
                state: ToastStates.error,
                context: context);
          default:
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SizedBox(
              width: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceWidth(context)*0.5:AppReference.deviceWidth(context),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(alignment: AlignmentDirectional.centerEnd,child: TextBackButton()),
                    AppSize.s20.sizedBoxHeight,
                    Text(AppStrings.welcome,
                      textAlign: TextAlign.center,
                      style: AppReference.themeData.textTheme.displayMedium,
                    ),
                    AppSize.s70.sizedBoxHeight,

                    // SelectTypeOfUser(
                    //   onChanged: (value) {
                    //     userType = value;
                    //   },
                    // ),
                    CustomDropdown(onChanged: (value) {
                      userType = value;
                    },),
                    AppSize.s20.sizedBoxHeight,
                    SelectGender(onGenderSelected: (value) {
                      genderType = value;
                    }),
                    AppSize.s70.sizedBoxHeight,
                    DefaultButtonWidget(
                        label: AppStrings.continueText,
                        onPressed: () {

                          if (userType == UsersType.child) {
                            bool confirmed = false;
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => DefaultAlertDialog(
                                confirm: (value) {
                                  confirmed = value;
                                },
                                message: AppStrings.childAccountOpenOneDevice,
                              ),
                            ).then((value) {
                              if (confirmed) {
                                _socialRegister();
                              }
                            });
                          } else {
                            _socialRegister();
                          }
                        }),
                    20.sizedBoxHeight,
                  ],
                ).paddingBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _socialRegister() {
      context.read<SocialRegisterBloc>().add(SignedUpEvent(
          signUpParameter: SocialRegisterData(
            displayName:  widget.socialLoginDataEntity.displayName ,
            photoUrl: widget.socialLoginDataEntity.photoUrl,
            socialId: widget.socialLoginDataEntity.socialId,
            email:  widget.socialLoginDataEntity.email,
            gender: genderType.name,
            type: userType.name,
          ),
        ));
  }
}
