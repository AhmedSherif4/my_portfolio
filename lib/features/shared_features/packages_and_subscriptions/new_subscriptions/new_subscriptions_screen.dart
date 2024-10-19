import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../core/base_widgets/loading_shimmer_widget.dart';
import '../../../../../../core/shared_widget/button_widget.dart';
import '../../../../../../core/shared_widget/default_drop_down_button.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_constants.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../shared_features/subscriptions_and_packages/widgets/header_widget.dart';
import '../../../shared_logic/classrooms_logic/classrooms_logic.dart';
import '../../../shared_logic/classrooms_logic/data/models/studying_model.dart';
import '../domain/entity/subject_subscriptions_entity.dart';

class NewSubscriptionsScreen extends StatefulWidget {
  final UserEntity? childData;

  const NewSubscriptionsScreen({
    super.key,
    this.childData,
  });

  @override
  State<NewSubscriptionsScreen> createState() => _NewSubscriptionsScreenState();
}

class _NewSubscriptionsScreenState extends State<NewSubscriptionsScreen> {

  @override
  void initState() {
    BlocProvider.of<GradeChoosingBloc>(context).fromSubscription=true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarSubscriptionsWidget(
              title: AppStrings.subscriptions,
              isNotHomeSub: AppReference.userIsChild() ? false : true,
              childID: getIt<UserLocalDataSource>().getUserData()?.userId,
            ),
            AppSize.s30.sizedBoxHeight,
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                    builder: (context,state) {

                      if(state.getClassRoomsState == RequestStates.loaded){
                        return Container(
                          width: (AppReference.deviceIsTablet &&
                              !AppReference.isPortrait(context))
                              ? AppReference.deviceWidth(context) * 0.4
                              : null,
                          padding:
                          EdgeInsets.all(AppPadding.p20.responsiveSize),
                          // margin: EdgeInsets.all(AppPadding.p40.responsiveSize),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(AppConstants
                                  .appBorderRadiusR20.responsiveHeight)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "اشتراك جديد",
                                  style: const AppTextStyle()
                                      .balooBhaijaan2
                                      .w500
                                      .black
                                      .titleLarge22,
                                ),
                                AppSize.s40.sizedBoxHeight,
                                BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                                    builder: (context, state) {
                                      switch (state.getSystemState) {
                                        case RequestStates.loading:
                                          return LoadingShimmerStructure(
                                            height: 40.responsiveHeight,
                                          );
                                        case RequestStates.loaded:
                                          if ((context
                                              .read<GradeChoosingBloc>()
                                              .state
                                              .getStagesState ==
                                              RequestStates.loaded) &&
                                              state.haveSystem == false) {
                                            return const SizedBox.shrink();
                                          } else {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "اختر نظام التعليم",
                                                  style: const AppTextStyle()
                                                      .balooBhaijaan2
                                                      .w500
                                                      .black
                                                      .bodyMedium14,
                                                ),
                                                AppSize.s10.sizedBoxHeight,
                                                DefaultDropDownButton<StudyingModel>(
                                                  studyingData: state.systems,
                                                  selectedItem: state.currentSystem,
                                                  displayText: (system) => system.name,
                                                  onChange: (value) {
                                                    state.currentSystem == value
                                                        ? null
                                                        : context
                                                        .read<GradeChoosingBloc>()
                                                        .add(ChangeSystemEvent(value!));
                                                    // selectedStage = value as StudyingModel;
                                                  },
                                                ),
                                                AppSize.s20.sizedBoxHeight,
                                              ],
                                            );
                                          }
                                        default:
                                          return const SizedBox();
                                      }
                                    }),
                                BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                                    builder: (context, state) {
                                      switch (state.getStagesState) {
                                        case RequestStates.loading:
                                          return LoadingShimmerStructure(
                                            height: 40.responsiveHeight,
                                          );
                                        case RequestStates.loaded:
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "اختر المرحلة",
                                                style: const AppTextStyle()
                                                    .balooBhaijaan2
                                                    .w500
                                                    .black
                                                    .bodyMedium14,
                                              ),
                                              AppSize.s10.sizedBoxHeight,
                                              DefaultDropDownButton<StudyingModel>(
                                                studyingData: state.stages,
                                                selectedItem: state.currentStage,
                                                displayText: (stages) => stages.name,
                                                onChange: (value) {
                                                  state.currentStage == value
                                                      ? null
                                                      : context
                                                      .read<GradeChoosingBloc>()
                                                      .add(ChangeStageEvent(value!));
                                                  // selectedStage = value as StudyingModel;
                                                },
                                              ),
                                            ],
                                          );
                                        default:
                                          return const SizedBox();
                                      }
                                    }),
                                AppSize.s20.sizedBoxHeight,
                                BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                                    builder: (context, state) {
                                      switch (state.getClassRoomsState) {
                                        case RequestStates.loading:
                                          return LoadingShimmerStructure(
                                            height: 40.responsiveHeight,
                                          );
                                        case RequestStates.loaded:
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "اختر الصف",
                                                style: const AppTextStyle()
                                                    .balooBhaijaan2
                                                    .w500
                                                    .black
                                                    .bodyMedium14,
                                              ),
                                              AppSize.s10.sizedBoxHeight,
                                              DefaultDropDownButton<StudyingModel>(
                                                studyingData: state.classRooms,
                                                selectedItem: state.currentClassRoom,
                                                displayText: (classroom) => classroom.name,
                                                onChange: (value) {
                                                  state.currentClassRoom == value
                                                      ? null
                                                      : context
                                                      .read<GradeChoosingBloc>()
                                                      .add(
                                                      ChangeClassRoomEvent(value!));
                                                  // selectedStage = value as StudyingModel;
                                                },
                                              ),
                                            ],
                                          );
                                        default:
                                          return const SizedBox();
                                      }
                                    }),
                                AppSize.s20.sizedBoxHeight,
                                BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                                    builder: (context, state) {
                                      switch (state.getPathsState) {
                                        case RequestStates.loading:
                                          return LoadingShimmerStructure(
                                            height: 40.responsiveHeight,
                                          );
                                        case RequestStates.loaded:
                                          return state.paths.isEmpty
                                              ? const SizedBox.shrink()
                                              : Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "اختر المسار",
                                                style: const AppTextStyle()
                                                    .balooBhaijaan2
                                                    .w500
                                                    .black
                                                    .bodyMedium14,
                                              ),
                                              AppSize.s10.sizedBoxHeight,
                                              DefaultDropDownButton<StudyingModel>(
                                                studyingData: state.paths,
                                                selectedItem: state.currentPath,
                                                displayText: (path) => path.name,
                                                onChange: (value) {
                                                  context
                                                      .read<GradeChoosingBloc>()
                                                      .add(ChangePathEvent(value!));
                                                  // selectedStage = value as StudyingModel;
                                                },
                                              ),
                                            ],
                                          );
                                        default:
                                          return const SizedBox();
                                      }
                                    }),
                                AppSize.s20.sizedBoxHeight,

                                BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                                    builder: (context, state) {
                                      if(state.getClassRoomsState == RequestStates.loaded){
                                        if(state.currentClassRoom.paths!.isNotEmpty){
                                          if(state.getPathsState == RequestStates.loaded){
                                            return DefaultButtonWidget(
                                              label: AppStrings.next,
                                              onPressed: () {
                                                RouteManager.rPushNamed(
                                                  context: context,
                                                  rName: AppRoutesNames
                                                      .rTermSubscriptionsScreen,
                                                  arguments:
                                                  SubjectSubscriptionsInputs(
                                                    classRoomId: context
                                                        .read<GradeChoosingBloc>()
                                                        .state
                                                        .currentClassRoom
                                                        .id,
                                                    pathId: context
                                                        .read<
                                                        GradeChoosingBloc>()
                                                        .state
                                                        .currentPath
                                                        .id ==
                                                        -1
                                                        ? 0
                                                        : context
                                                        .read<
                                                        GradeChoosingBloc>()
                                                        .state
                                                        .currentPath
                                                        .id,
                                                    childId: widget.childData?.userId ??
                                                        getIt<UserLocalDataSource>()
                                                            .getUserData()!
                                                            .userId,
                                                  ),
                                                );
                                              },
                                            );
                                          }else{
                                            return const SizedBox.shrink();
                                          }
                                        }
                                      }
                                      return DefaultButtonWidget(
                                        label: AppStrings.next,
                                        onPressed: () {
                                          RouteManager.rPushNamed(
                                            context: context,
                                            rName: AppRoutesNames
                                                .rTermSubscriptionsScreen,
                                            arguments:
                                            SubjectSubscriptionsInputs(
                                              classRoomId: context
                                                  .read<GradeChoosingBloc>()
                                                  .state
                                                  .currentClassRoom
                                                  .id,
                                              pathId: context
                                                  .read<
                                                  GradeChoosingBloc>()
                                                  .state
                                                  .currentPath
                                                  .id ==
                                                  -1
                                                  ? 0
                                                  : context
                                                  .read<
                                                  GradeChoosingBloc>()
                                                  .state
                                                  .currentPath
                                                  .id,
                                              childId: widget.childData?.userId ??
                                                  getIt<UserLocalDataSource>()
                                                      .getUserData()!
                                                      .userId,
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ]),
                        );
                      }else if(
                      state.getStagesState == RequestStates.loading||
                      state.getTermsState == RequestStates.loading
                          || state.getClassRoomsState == RequestStates.loading
                          || state.getSystemState == RequestStates.loading
                      ){
                        return const LoadingShimmerList();
                      }else {
                        return const SizedBox.shrink();
                      }
                    }
                  ),
                ),
              ),
            ),
          ],
        ).paddingBody(),
      ),
    );
  }
}
