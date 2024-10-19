import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/extensions/color_extension.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/core/base_widgets/loading_shimmer_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/base_container_have_text_and_image.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/header_for_terms_levels_collections.dart';
import 'package:my_portfolio/core/shared_widget/text_with_background_color.dart';
import 'package:my_portfolio/core/shared_widget/text_with_image.dart';
import 'package:my_portfolio/features/child_flow/questions/levels/levels.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/resources/app_values.dart';
import '../../../../../../config/routes/routes_names.dart';
import '../../../shared/data/go_to_question_parameter.dart';
import '../../../shared/data/go_to_questions_data.dart';
import '../levels_widgets/level_builder.dart';

class PrimaryChildLevelsScreen extends StatelessWidget {
  final DataToGoQuestions data;

  const PrimaryChildLevelsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LevelsBloc>()
        ..add(GetAllLevels(
          ParameterGoToQuestions(
            subjectId: data.subjectId,
            stageId: data.stageId,
            classRoomId: data.classRoomId,
            termId: data.termId,
            systemId: data.systemId,
            pathId: data.pathId,
          ),
        )),
      child: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          final newData = data.copyWith(isGeneralQuestions: false);
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rLessonScreen,
              arguments: newData);
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderForTermsAndLevelsAndGroup(backTo: () {
                  final newData = data.copyWith(isGeneralQuestions: false);
                  RouteManager.rPushNamedAndRemoveUntil(
                      context: context,
                      rName: AppRoutesNames.rLessonScreen,
                      arguments: newData);
                }),
                AppSize.s26.sizedBoxHeight,
                Expanded(
                  child: SingleChildScrollView(
                    child: ResponsiveWidgetForTablet(
                      mobile: OrientationItem(
                        portraitWidget: Column(
                          children: [
                            BaseContainerHaveTextAndImage(
                              title: data.subjectName,
                              notHaveImage: data.notHaveImage,
                              description: AppStrings.generalQuestions,
                              imageUrl: data.imgUrl,
                              width: AppReference.deviceIsTablet ? AppReference.deviceWidth(context) * 0.5:AppReference.deviceWidth(context),
                              height: AppReference.deviceIsTablet ? AppReference.deviceHeight(context) *
                                  0.08.responsiveHeightRatio:AppReference.deviceHeight(context) *
                                  0.11.responsiveHeightRatio,
                            ).animateSlideTopToNormal(duration: AppConstants.animationTime),
                            AppSize.s20.sizedBoxHeight,
                            SizedBox(
                              height: AppReference.deviceHeight(context) *
                                  0.08.responsiveHeightRatio,
                              width: AppReference.deviceWidth(context),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: TextWithImageWidget(
                                      label: AppStrings.myLevels,
                                      imagePath: AppImagesAssets.sGrowthLevel,
                                    ),
                                  ).animateRightLeft(duration: AppConstants.animationTime),
                                  const Expanded(
                                    child: CurrentLevelBuilder(),
                                  ).animateRightLeft(isFromStart: false,duration: AppConstants.animationTime),
                                ],
                              ),
                            ),
                            AppSize.s20.sizedBoxHeight,
                            LevelBuilder(dataToGoQuestions: data),
                          ],
                        ),
                        landscapeWidget: Column(
                          children: [
                            SizedBox(
                              width: AppReference.deviceWidth(context)*.9,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: BaseContainerHaveTextAndImage(
                                      title: data.subjectName,
                                      notHaveImage: data.notHaveImage,
                                      description: AppStrings.generalQuestions,
                                      imageUrl: data.imgUrl,
                                      width: AppReference.deviceIsTablet ? AppReference.deviceWidth(context) * 0.4:AppReference.deviceWidth(context),
                                      height: AppReference.deviceIsTablet ? AppReference.deviceHeight(context) *
                                          0.08.responsiveHeightRatio:AppReference.deviceHeight(context) *
                                          0.11.responsiveHeightRatio,
                                    ).animateSlideTopToNormal(duration: AppConstants.animationTime),
                                  ),
                                  AppSize.s40.sizedBoxWidth,
                                  const Expanded(
                                    flex: 2,
                                    child: TextWithImageWidget(
                                      label: AppStrings.myLevels,
                                      imagePath: AppImagesAssets.sGrowthLevel,
                                    ),
                                  ),
                                  AppSize.s20.sizedBoxWidth,
                                  const Expanded(child: CurrentLevelBuilder())
                                ],
                              ),
                            ),
                            AppSize.s40.sizedBoxHeight,
                            SizedBox(
                                width: AppReference.deviceWidth(context)*.8,
                                child: LevelBuilder(dataToGoQuestions: data)),
                          ],
                        ),
                      ),
                      tablet: Column(
                        children: [
                          SizedBox(
                            width: AppReference.deviceWidth(context)*.9,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: BaseContainerHaveTextAndImage(
                                    title: data.subjectName,
                                    notHaveImage: data.notHaveImage,
                                    description: AppStrings.generalQuestions,
                                    imageUrl: data.imgUrl,
                                    width: AppReference.deviceIsTablet ? AppReference.deviceWidth(context) * 0.4:AppReference.deviceWidth(context),
                                    height: AppReference.deviceIsTablet ? AppReference.deviceHeight(context) *
                                        0.08.responsiveHeightRatio:AppReference.deviceHeight(context) *
                                        0.11.responsiveHeightRatio,
                                  ).animateSlideTopToNormal(duration: AppConstants.animationTime),
                                ),
                                AppSize.s40.sizedBoxWidth,
                                const Expanded(
                                  flex: 2,
                                  child: TextWithImageWidget(
                                    label: AppStrings.myLevels,
                                    imagePath: AppImagesAssets.sGrowthLevel,
                                  ),
                                ),
                                AppSize.s20.sizedBoxWidth,
                                const Expanded(child: CurrentLevelBuilder())
                              ],
                            ),
                          ),
                          AppSize.s40.sizedBoxHeight,
                          SizedBox(
                              width: AppReference.deviceWidth(context)*.8,
                              child: LevelBuilder(dataToGoQuestions: data)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}

class CurrentLevelBuilder extends StatelessWidget {
  const CurrentLevelBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelsBloc, LevelsState>(
      builder: (context, state) {
        switch (state.levelsStates) {
          case RequestStates.loading:
            return LoadingShimmerStructure(
              height: 40.responsiveHeight,
            );
          case RequestStates.loaded:
            if (state.levels.isEmpty) {
              return  const Text("لا يوجد مستويات");
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppStrings.currentLevel,
                    style: const AppTextStyle().balooBhaijaan2.w700.bodySmall12,
                  ),
                   TextWithBackGroundColor(
                                       horizontalPadding: 0,
                                       verticalPadding: 5,
                                       isOneLine: true,
                                       textColor: AppColors.white,
                                       fontSize: AppFontSize.sp10.responsiveFontSize,
                                       text: state.currentLevel != null
                     ? state.currentLevel!.name
                     : '',
                     backgroundColor: HexColor.fromHex(state.currentLevel != null
                     ? state.currentLevel!.itemColor
                     : AppConstants.primaryColorHexCode),
                                     ),
                ],
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.levelsErrorMessage);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
