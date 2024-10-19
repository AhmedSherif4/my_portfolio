import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/header_for_terms_levels_collections.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/features/child_flow/questions/collections/collections.dart';
import 'package:my_portfolio/features/child_flow/questions/collections/presentation/collections_widgets/level_name_widget.dart';
import 'package:my_portfolio/features/child_flow/questions/collections/presentation/collections_widgets/primary/collection_builder.dart';
import 'package:my_portfolio/features/child_flow/questions/collections/presentation/collections_widgets/view_play_image.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/resources/app_constants.dart';
import '../../../../../../config/resources/app_values.dart';
import '../../../../../../my_app/app_analytics.dart';
import '../../../shared/data/go_to_questions_data.dart';

class PrimaryCollectionsScreen extends StatelessWidget {
  final DataToGoQuestions data;

  const PrimaryCollectionsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    AppAnalytics.viewGroupScreenLogEvent();
    return BlocProvider(
      create: (context) => getIt<CollectionsBloc>()
        ..add(
          GetCollectionsEvent(
            parameters: ParameterGoToQuestions(
              subjectId: data.subjectId,
              stageId: data.stageId,
              classRoomId: data.classRoomId,
              termId: data.termId,
              levelId: data.levelId,
              systemId: data.systemId,
              pathId: data.pathId,
            ),
          ),
        ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rPrimaryLevelScreen,
              arguments: data);
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderForTermsAndLevelsAndGroup(backTo: () {
                  RouteManager.rPushNamedAndRemoveUntil(
                      context: context,
                      rName: AppRoutesNames.rPrimaryLevelScreen,
                      arguments: data);
                }),
                ResponsiveWidgetForTablet(
                  mobile: OrientationItem(
                    portraitWidget: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppSize.s26.sizedBoxHeight,
                            LevelNameWidgetInCollectionScreen(
                              currentLevel: data.levelName,
                              levelColor: data.levelColor,
                            ),
                            AppSize.s20.sizedBoxHeight,
                            NullableNetworkImage(
                              imagePath: data.levelImage,
                              notHaveImage: data.levelImageNotFound,
                              width: AppReference.deviceWidth(context) * 0.8,
                              height: AppReference.deviceHeight(context) *
                                  0.18.responsiveHeightRatio,
                              fit: BoxFit.contain,
                            ),
                            AppSize.s20.sizedBoxHeight,
                            const ViewPlayImage().animateRotate(
                                duration: AppConstants.animationTime),
                            PrimaryChildCollectionBuilder(data: data),
                          ],
                        ),
                      ),
                    ),
                    landscapeWidget:Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: AppReference.deviceWidth(context) * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NullableNetworkImage(
                                  imagePath: data.levelImage,
                                  notHaveImage: data.levelImageNotFound,
                                  width: AppReference.deviceWidth(context) * 0.8,
                                  height: AppReference.deviceHeight(context) *
                                      0.18.responsiveHeightRatio,
                                  fit: BoxFit.contain,
                                ),
                                AppSize.s20.sizedBoxHeight,
                                const ViewPlayImage().animateRotate(
                                    duration: AppConstants.animationTime),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              width: AppReference.deviceWidth(context) * 0.4,
                              child: Column(
                                children: [
                                  AppSize.s26.sizedBoxHeight,
                                  LevelNameWidgetInCollectionScreen(
                                    currentLevel: data.levelName,
                                    levelColor: data.levelColor,
                                  ),
                                  AppSize.s20.sizedBoxHeight,
                                  PrimaryChildCollectionBuilder(data: data),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) ,
                  ),
                  tablet: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppReference.deviceWidth(context) * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NullableNetworkImage(
                                imagePath: data.levelImage,
                                notHaveImage: data.levelImageNotFound,
                                width: AppReference.deviceWidth(context) * 0.8,
                                height: AppReference.deviceHeight(context) *
                                    0.18.responsiveHeightRatio,
                                fit: BoxFit.contain,
                              ),
                              AppSize.s20.sizedBoxHeight,
                              const ViewPlayImage().animateRotate(
                                  duration: AppConstants.animationTime),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            width: AppReference.deviceWidth(context) * 0.4,
                            child: Column(
                              children: [
                                AppSize.s26.sizedBoxHeight,
                                LevelNameWidgetInCollectionScreen(
                                  currentLevel: data.levelName,
                                  levelColor: data.levelColor,
                                ),
                                AppSize.s20.sizedBoxHeight,
                                PrimaryChildCollectionBuilder(data: data),
                              ],
                            ),
                          ),
                        ),
                      ],
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
