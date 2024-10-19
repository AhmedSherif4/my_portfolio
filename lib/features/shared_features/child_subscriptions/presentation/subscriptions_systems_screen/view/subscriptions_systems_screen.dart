import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/extensions/color_extension.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/entity/child_subscriptions_studying_entity.dart';
import 'package:my_portfolio/features/shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view/data_to_go_random_exams.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../../core/services/services_locator.dart';
import '../../../../../../core/base_widgets/loading_shimmer_widget.dart';
import '../../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../../core/shared_widget/button_widget.dart';
import '../../../../../../core/shared_widget/default_drop_down_button.dart';
import '../../../../../../core/shared_widget/empty_list_widget.dart';
import '../../../../../child_flow/exams/exams/data_to_go_exams.dart';
import '../../../../../child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../../../../more/presentation/more_widgets/header_for_more.dart';
import '../../../../statics/statics.dart';
import '../../../../subjects_shared_features/subjects_shared_features.dart';
import '../../../data/models/data_go_to_subscriptions_ques.dart';
import '../view_model/subscription_systems_bloc.dart';
import '../view_model/subscription_systems_event.dart';
import '../view_model/subscription_systems_state.dart';

class SubscriptionsSystemsScreen extends StatefulWidget {
  final DataToGoRandomExams? dataToGoRandomExams;

  const SubscriptionsSystemsScreen({
    super.key,
    this.dataToGoRandomExams,
  });

  @override
  State<SubscriptionsSystemsScreen> createState() =>
      _SubscriptionsSystemsScreenState();
}

class _SubscriptionsSystemsScreenState
    extends State<SubscriptionsSystemsScreen> {
  @override
  void initState() {
    context.read<SubscriptionSystemsBloc>().childData =
        widget.dataToGoRandomExams!.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: AppReference.userIsChild() ? false : true,
          onPopInvoked: (value) {
            if (!value) {
              RouteManager.rPushNamedAndRemoveUntil(
                  context: context,
                  rName: AppRoutesNames.rHomeLayoutView,
                  arguments: getIt<UserLocalDataSource>().getUserData());
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderForMore(
                  title: AppStrings.availableSubscription,
                  onBack: AppReference.userIsChild()
                      ? () {
                          RouteManager.rPushNamedAndRemoveUntil(
                              context: context,
                              rName: AppRoutesNames.rHomeLayoutView,
                              arguments:
                                  getIt<UserLocalDataSource>().getUserData());
                        }
                      : null,
                ),
                BlocBuilder<SubscriptionSystemsBloc, SubscriptionSystemsState>(
                    builder: (context, state) {
                 if (state.getTermsState == RequestStates.loading ||
                          state.getClassRoomsState == RequestStates.loading ||
                          state.getSystemState == RequestStates.loading ||
                          state.getStagesState == RequestStates.loading) {
                        return const LoadingShimmerList();
                      } else if(state.getSystemState == RequestStates.error){
                        return const CustomErrorWidget(errorMessage: "حدثت مشكلة برجاء المحاولة مرة اخرى");
                      }
                 else{
                         return state.systems.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                200.sizedBoxHeight,
                                const EmptyListWidgets(
                                    message: AppStrings.notSubscribed),
                              ],
                            )
                          : SizedBox(
                              width: (AppReference.deviceIsTablet &&
                                      !AppReference.isPortrait(context))
                                  ? AppReference.deviceWidth(context) * 0.4
                                  : AppReference.deviceWidth(context),
                              child: Column(
                                children: [
                                  if ((context
                                              .read<SubscriptionSystemsBloc>()
                                              .state
                                              .getStagesState ==
                                          RequestStates.loaded) &&
                                      state.haveSystem == true)
                                    DefaultDropDownButton<
                                        ChildSubscriptionsStudyingEntity>(
                                      studyingData: state.systems,
                                      selectedItem: state.currentSystem,
                                      displayText: (system) => system.name,
                                      onChange: (value) {
                                        state.currentSystem == value
                                            ? null
                                            : context
                                                .read<SubscriptionSystemsBloc>()
                                                .add(ChangeSystemEvent(value!));
                                      },
                                    ),
                                  45.0.sizedBoxHeight,
                                  BlocBuilder<SubscriptionSystemsBloc,
                                          SubscriptionSystemsState>(
                                      builder: (context, state) {
                                    switch (state.getStagesState) {
                                      case RequestStates.loading:
                                        return LoadingShimmerStructure(
                                          height: 40.responsiveHeight,
                                        );
                                      case RequestStates.loaded:
                                        return DefaultDropDownButton<
                                            ChildSubscriptionsStudyingEntity>(
                                          studyingData: state.stages,
                                          selectedItem: state.currentStage,
                                          displayText: (stage) => stage.name,
                                          onChange: (value) {
                                            state.currentStage == value
                                                ? null
                                                : context
                                                    .read<
                                                        SubscriptionSystemsBloc>()
                                                    .add(ChangeStagesEvent(
                                                        value!));
                                          },
                                        );
                                      default:
                                        return const SizedBox();
                                    }
                                  }),
                                  45.0.sizedBoxHeight,
                                  BlocBuilder<SubscriptionSystemsBloc,
                                          SubscriptionSystemsState>(
                                      builder: (context, state) {
                                    switch (state.getClassRoomsState) {
                                      case RequestStates.loading:
                                        return LoadingShimmerStructure(
                                          height: 40.responsiveHeight,
                                        );
                                      case RequestStates.loaded:
                                        return DefaultDropDownButton<
                                            ChildSubscriptionsStudyingEntity>(
                                          studyingData: state.classRooms,
                                          displayText: (classRooms) =>
                                              classRooms.name,
                                          selectedItem: state.currentClassRoom,
                                          onChange: (value) {
                                            state.currentClassRoom == value
                                                ? null
                                                : context
                                                    .read<
                                                        SubscriptionSystemsBloc>()
                                                    .add(ChangeClassRoomEvent(
                                                        value!));
                                          },
                                        );
                                      default:
                                        return const SizedBox();
                                    }
                                  }),
                                  45.0.sizedBoxHeight,
                                  BlocBuilder<SubscriptionSystemsBloc,
                                          SubscriptionSystemsState>(
                                      builder: (context, state) {
                                    switch (state.getTermsState) {
                                      case RequestStates.loading:
                                        return LoadingShimmerStructure(
                                          height: 40.responsiveHeight,
                                        );
                                      case RequestStates.loaded:
                                        return DefaultDropDownButton<
                                            ChildSubscriptionsStudyingEntity>(
                                          studyingData: state.terms,
                                          displayText: (terms) => terms.name,
                                          selectedItem: state.currentTerm,
                                          onChange: (value) {
                                            context
                                                .read<SubscriptionSystemsBloc>()
                                                .add(ChangeTermEvent(value!));
                                          },
                                        );
                                      default:
                                        return const SizedBox();
                                    }
                                  }),
                                  45.0.sizedBoxHeight,
                                  BlocBuilder<SubscriptionSystemsBloc,
                                          SubscriptionSystemsState>(
                                      builder: (context, state) {
                                    switch (state.getPathsState) {
                                      case RequestStates.loading:
                                        return LoadingShimmerStructure(
                                          height: 40.responsiveHeight,
                                        );
                                      case RequestStates.loaded:
                                        return DefaultDropDownButton<
                                            ChildSubscriptionsStudyingEntity>(
                                          studyingData: state.paths,
                                          displayText: (paths) => paths.name,
                                          selectedItem: state.currentPath,
                                          onChange: (value) {
                                            context
                                                .read<SubscriptionSystemsBloc>()
                                                .add(ChangePathEvent(value!));
                                          },
                                        );
                                      default:
                                        return const SizedBox();
                                    }
                                  }),
                                  10.sizedBoxHeight,
                                  BlocListener<SharedSubjectsBloc,
                                      SharedSubjectsState>(
                                    listener: (context, sharedSubjectState) {
                                      switch (
                                          sharedSubjectState.getSubjectsState) {
                                        case RequestStates.loading:
                                          showLoadingDialog(context);
                                        case RequestStates.loaded:
                                          Navigator.pop(context);
                                          final tempPara = GetStaticsParam(
                                            stageId: BlocProvider.of<
                                                        SubscriptionSystemsBloc>(
                                                    context)
                                                .state
                                                .currentStage
                                                .id,
                                            termId: BlocProvider.of<
                                                        SubscriptionSystemsBloc>(
                                                    context)
                                                .state
                                                .currentTerm
                                                .id,
                                            classRoomId: BlocProvider.of<
                                                        SubscriptionSystemsBloc>(
                                                    context)
                                                .state
                                                .currentClassRoom
                                                .id,
                                            systemId: 0,
                                            userData: widget
                                                .dataToGoRandomExams!.user,
                                            classRoomName: BlocProvider.of<
                                                        SubscriptionSystemsBloc>(
                                                    context)
                                                .state
                                                .currentClassRoom
                                                .name,
                                            points: widget.dataToGoRandomExams!
                                                .user.points
                                                .toString(),
                                            childId: widget.dataToGoRandomExams!
                                                .user.userId,
                                            // pathId: widget.dataToGoRandomExams!.user.pathId,
                                          ).copyWith(
                                            isLesson: false,
                                            pathId: BlocProvider.of<
                                                        SubscriptionSystemsBloc>(
                                                    context)
                                                .state
                                                .currentPath
                                                .id,
                                            allSubjects:
                                                sharedSubjectState.subjects,
                                            subjectId: sharedSubjectState
                                                .subjects[0].subjectId,
                                          );
                                          if (widget.dataToGoRandomExams!
                                              .isRandomExam) {
                                            state.subjects.log();

                                            if (!AppReference.userIsChild()) {
                                              RouteManager.rPushNamed(
                                                  context: context,
                                                  rName: state.currentStage
                                                                  .id ==
                                                              1 ||
                                                          state.currentStage
                                                                  .id ==
                                                              4
                                                      ? AppRoutesNames
                                                          .rPrimaryChildRandomExamsScreen
                                                      : AppRoutesNames
                                                          .rChildRandomExamsScreen,
                                                  arguments: widget
                                                      .dataToGoRandomExams!
                                                      .dataToGoExams!
                                                      .copyWith(
                                                          subjects:
                                                              sharedSubjectState
                                                                  .subjects));
                                            }
                                          } else {
                                            RouteManager.rPushNamed(
                                              context: context,
                                              rName:
                                                  AppRoutesNames.rStaticsScreen,
                                              arguments: tempPara,
                                            );
                                          }
                                        case RequestStates.error:
                                          Navigator.pop(context);
                                          showSnackBar(
                                              description: sharedSubjectState
                                                  .getSubjectsStateMessage,
                                              state: ToastStates.error,
                                              context: context);
                                        default:
                                      }
                                    },
                                    child: BlocSelector<
                                        SubscriptionSystemsBloc,
                                        SubscriptionSystemsState,
                                        Tuple2<bool, dynamic>>(
                                      selector: (state) {
                                        return Tuple2(
                                            state.getTermsState ==
                                                RequestStates.loaded,
                                            state.getPathsState);
                                      },
                                      builder: (context, tuple) {
                                        if (tuple.init &&
                                            tuple.value2 ==
                                                RequestStates.initial) {
                                          return DefaultButtonWidget(
                                            label: widget.dataToGoRandomExams!
                                                    .isRandomExam
                                                ? "إلى الاختبارات الذاتية"
                                                : AppReference.userIsChild()
                                                    ? AppStrings.toSubjects
                                                    : AppStrings.toStatics,
                                            onPressed: () {
                                              if (AppReference.userIsChild()) {
                                                RouteManager
                                                    .rPushNamedAndRemoveUntil(
                                                  context: context,
                                                  rName: AppRoutesNames
                                                      .rSubscriptionsSubjectsScreen,
                                                  arguments:
                                                      DataGoToSubscriptionsQuestions(
                                                    systemId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentSystem
                                                        .id,
                                                    stageId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentStage
                                                        .id,
                                                    classRoomId: BlocProvider
                                                            .of<SubscriptionSystemsBloc>(
                                                                context)
                                                        .state
                                                        .currentClassRoom
                                                        .id,
                                                    termId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentTerm
                                                        .id,
                                                    classRoomName: BlocProvider
                                                            .of<SubscriptionSystemsBloc>(
                                                                context)
                                                        .state
                                                        .currentClassRoom
                                                        .name,
                                                    points: widget
                                                        .dataToGoRandomExams!
                                                        .user
                                                        .points
                                                        .toString(),
                                                    pathId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentPath
                                                        .id,
                                                  ),
                                                );
                                              } else {
                                                BlocProvider.of<
                                                            SharedSubjectsBloc>(
                                                        context)
                                                    .add(GetSharedSubjectsEvent(
                                                        parameter:
                                                            ParameterGoToQuestions(
                                                  systemId: BlocProvider.of<
                                                              SubscriptionSystemsBloc>(
                                                          context)
                                                      .state
                                                      .currentSystem
                                                      .id,
                                                  stageId: BlocProvider.of<
                                                              SubscriptionSystemsBloc>(
                                                          context)
                                                      .state
                                                      .currentStage
                                                      .id,
                                                  classRoomId: BlocProvider.of<
                                                              SubscriptionSystemsBloc>(
                                                          context)
                                                      .state
                                                      .currentClassRoom
                                                      .id,
                                                  termId: BlocProvider.of<
                                                              SubscriptionSystemsBloc>(
                                                          context)
                                                      .state
                                                      .currentTerm
                                                      .id,
                                                  pathId: BlocProvider.of<
                                                              SubscriptionSystemsBloc>(
                                                          context)
                                                      .state
                                                      .currentPath
                                                      .id,
                                                  subjectType:
                                                      SubjectType.subscriptions,
                                                ).copyWith(
                                                  userId: widget
                                                      .dataToGoRandomExams!
                                                      .user
                                                      .userId,
                                                )));
                                              }
                                            },
                                          );
                                        } else if (tuple.init &&
                                            tuple.value2 ==
                                                RequestStates.loaded) {
                                          if (BlocProvider.of<
                                                          SubscriptionSystemsBloc>(
                                                      context)
                                                  .state
                                                  .getPathsState ==
                                              RequestStates.loaded) {
                                            return DefaultButtonWidget(
                                              label: widget.dataToGoRandomExams!
                                                      .isRandomExam
                                                  ? "إلى الاختبارات الذاتية"
                                                  : AppReference.userIsChild()
                                                      ? AppStrings.toSubjects
                                                      : AppStrings.toStatics,
                                              onPressed: () {
                                                if (AppReference
                                                    .userIsChild()) {
                                                  RouteManager
                                                      .rPushNamedAndRemoveUntil(
                                                    context: context,
                                                    rName: AppRoutesNames
                                                        .rSubscriptionsSubjectsScreen,
                                                    arguments:
                                                        DataGoToSubscriptionsQuestions(
                                                      systemId: BlocProvider.of<
                                                                  SubscriptionSystemsBloc>(
                                                              context)
                                                          .state
                                                          .currentSystem
                                                          .id,
                                                      stageId: BlocProvider.of<
                                                                  SubscriptionSystemsBloc>(
                                                              context)
                                                          .state
                                                          .currentStage
                                                          .id,
                                                      classRoomId: BlocProvider
                                                              .of<SubscriptionSystemsBloc>(
                                                                  context)
                                                          .state
                                                          .currentClassRoom
                                                          .id,
                                                      termId: BlocProvider.of<
                                                                  SubscriptionSystemsBloc>(
                                                              context)
                                                          .state
                                                          .currentTerm
                                                          .id,
                                                      classRoomName: BlocProvider
                                                              .of<SubscriptionSystemsBloc>(
                                                                  context)
                                                          .state
                                                          .currentClassRoom
                                                          .name,
                                                      points: widget
                                                          .dataToGoRandomExams!
                                                          .user
                                                          .points
                                                          .toString(),
                                                      pathId: BlocProvider.of<
                                                                  SubscriptionSystemsBloc>(
                                                              context)
                                                          .state
                                                          .currentPath
                                                          .id,
                                                    ),
                                                  );
                                                } else {
                                                  BlocProvider.of<
                                                              SharedSubjectsBloc>(
                                                          context)
                                                      .add(
                                                          GetSharedSubjectsEvent(
                                                              parameter:
                                                                  ParameterGoToQuestions(
                                                    stageId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentStage
                                                        .id,
                                                    classRoomId: BlocProvider
                                                            .of<SubscriptionSystemsBloc>(
                                                                context)
                                                        .state
                                                        .currentClassRoom
                                                        .id,
                                                    termId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentTerm
                                                        .id,
                                                    pathId: BlocProvider.of<
                                                                SubscriptionSystemsBloc>(
                                                            context)
                                                        .state
                                                        .currentPath
                                                        .id,
                                                    subjectType: SubjectType
                                                        .subscriptions,
                                                  ).copyWith(
                                                    userId: widget
                                                        .dataToGoRandomExams!
                                                        .user
                                                        .userId,
                                                  )));
                                                }
                                              },
                                            );
                                          } else {
                                            return LoadingShimmerStructure(
                                              height: 50.responsiveHeight,
                                            );
                                          }
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                  }
                }),
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }
}
