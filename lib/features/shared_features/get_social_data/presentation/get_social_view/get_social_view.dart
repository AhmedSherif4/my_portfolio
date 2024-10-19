import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:my_portfolio/features/shared_features/get_social_data/presentation/get_social_data_view_model/get_social_data_bloc.dart';
import 'package:my_portfolio/features/shared_features/get_social_data/presentation/get_social_data_view_model/get_social_data_event.dart';
import 'package:my_portfolio/features/shared_features/get_social_data/presentation/get_social_data_view_model/get_social_data_state.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';
import '../../domain/entity/social_login_data_entity.dart';
import '../widgets/get_social_data_button.dart';

class GetSocialView extends StatelessWidget {
  const GetSocialView({
    super.key,
    required this.isAgree,
    required this.isLogin,
    required this.onDataLoaded,
  });

  final bool isAgree;
  final bool isLogin;
  final Function(SocialLoginDataEntity) onDataLoaded;

  _getGoogleID(context) async {
    BlocProvider.of<GetSocialDataBloc>(context).add(GetGoogleDataEvent());
  }

  _getAppleID(context) async {
    BlocProvider.of<GetSocialDataBloc>(context).add(GetAppleDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetSocialDataBloc>(),
      child: Builder(builder: (buildCtx) {
          return BlocListener<GetSocialDataBloc, GetSocialDataState>(
            listener: (_, state) {
              if (state.getGoogleDataState == RequestStates.loaded || state.getAppleDataState == RequestStates.loaded) {

                onDataLoaded(state.socialLoginDataEntity);
              }
            },
            child: AppReference.deviceIsIos
                ? SignInWithAppleButton(
                    text: 'التسجيل من خلال حساب أبل',
                    onPressed: () async {
                      _getAppleID(buildCtx);
                          }):
            GoogleButton(
              widthRatioForTablet: AppReference.isPortrait(context)? 1 : .25,
              backgroundColor: AppColors.primaryColor.withOpacity(.1),
              textColor: AppColors.black,
              onTap: () async {
                 _getGoogleID(buildCtx);
              },
            ),
          );
      }),
    );
  }
}
