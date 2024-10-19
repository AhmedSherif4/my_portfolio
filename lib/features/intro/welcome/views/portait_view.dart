import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/base_widgets/loading_shimmer_widget.dart';


import '../../../../config/resources/app_assets.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_strings.dart';
import '../../../../config/resources/app_values.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../my_app/app_reference.dart';
import '../../global/global_view_model/global_bloc.dart';
import '../../global/global_view_model/global_state.dart';
import '../welcome_item.dart';

class WelcomeScreenPortraitView extends StatelessWidget {
  final Function() goToSignUp;
  final Function() goToLogIn;
  final Function() goToHome;

  const WelcomeScreenPortraitView(
      {super.key,
      required this.goToSignUp,
      required this.goToLogIn,
      required this.goToHome});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseWelcomeButton(
          onTap: goToSignUp,
          title: AppStrings.createNewAccount,
          imagePath: AppImagesAssets.sWelcomeNew,
          textStyle: const AppTextStyle().w600.bodyLarge16.copyWith(
            color: AppColors.textColor2,
          ),
          boxFit: BoxFit.cover,
        ),
        AppSize.s30.sizedBoxHeight,
        BaseWelcomeButton(
          onTap: goToLogIn,
          title: AppStrings.signIN,
          boxFit: BoxFit.cover,
          imagePath: AppImagesAssets.sWelcomeExist,
 textStyle: const AppTextStyle().w600.bodyLarge16.copyWith(
            color: AppColors.textColor2,
          ),        ),
        AppSize.s30.sizedBoxHeight,
        BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            switch (state.getGuestDataState) {
              case RequestStates.loading:
                return LoadingShimmerStructure(
                    height: AppReference.deviceHeight(context) *
                        0.2.responsiveHeightRatio);
              case RequestStates.loaded:
                return BaseWelcomeButton(
                  onTap: goToHome,
                  title: AppStrings.guest,
                  imagePath: AppImagesAssets.sWelcomeGuest,
         textStyle: const AppTextStyle().w600.bodyLarge16.copyWith(
            color: AppColors.textColor2,
          ),                );

              case RequestStates.error:
                return BaseWelcomeButton(
                  onTap: goToHome,
                  title: AppStrings.guest,
                  imagePath: AppImagesAssets.sWelcomeGuest,
         textStyle: const AppTextStyle().w600.bodyLarge16.copyWith(
            color: AppColors.textColor2,
          ),                );
              default:
                 return BaseWelcomeButton(
                  onTap: goToHome,
                  title: AppStrings.guest,
                  imagePath: AppImagesAssets.sWelcomeGuest,
         textStyle: const AppTextStyle().w600.bodyLarge16.copyWith(
            color: AppColors.textColor2,
          ),                );
            }
          },
        ),
      ],
    );
  }
}


