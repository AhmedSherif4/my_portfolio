part of '../../free_subjects_subscriptions.dart';

class FreeSubjectsSubscriptionsScreen extends StatelessWidget {
  final UserEntity userData;
  const FreeSubjectsSubscriptionsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarSubscriptionsWidget(
                childID:userData.userId ,
              ),
              SizedBox(
                width: AppReference.deviceIsTablet?AppReference.deviceWidth(context)*0.4:AppReference.deviceWidth(context),
                child: Column(
                  children: [

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        AppStrings.subjectSubscription,
                        style: const AppTextStyle().w600.s15.gray.bodyLarge16,
                      ),
                    ),
                    45.0.sizedBoxHeight,
                    BlocBuilder<FreeSubjectsSubscriptionsBloc,
                        FreeSubjectsSubscriptionsState>(builder: (context, state) {
                      switch (state.getSystemState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          return DefaultDropDownButton<StudyingModel>(
                            studyingData: state.systems,
                            selectedItem: state.currentSystem,
                            displayText: (system) => system.name,
                            onChange: (value) {
                              state.currentSystem == value
                                  ? null
                                  : context
                                      .read<FreeSubjectsSubscriptionsBloc>()
                                      .add(ChangeSystemFreeSubjectsEvent(value!));
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
                    45.0.sizedBoxHeight,
                    BlocBuilder<FreeSubjectsSubscriptionsBloc,
                        FreeSubjectsSubscriptionsState>(builder: (context, state) {
                      switch (state.getStagesState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          return DefaultDropDownButton<StudyingModel>(
                            studyingData: state.stages,
                            selectedItem: state.currentStage,
                            displayText: (stage) => stage.name,
                            onChange: (value) {
                              state.currentStage == value
                                  ? null
                                  : context
                                      .read<FreeSubjectsSubscriptionsBloc>()
                                      .add(ChangeStageFreeSubjectsEvent(value!));
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
                    45.0.sizedBoxHeight,
                    BlocBuilder<FreeSubjectsSubscriptionsBloc,
                        FreeSubjectsSubscriptionsState>(builder: (context, state) {
                      switch (state.getClassRoomsState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          return DefaultDropDownButton<StudyingModel>(
                            studyingData: state.classRooms,
                            displayText: (classRooms) => classRooms.name,
                            selectedItem: state.currentClassRoom,
                            onChange: (value) {
                              state.currentClassRoom == value
                                  ? null
                                  : context
                                      .read<FreeSubjectsSubscriptionsBloc>()
                                      .add(ChangeClassRoomFreeSubjectsEvent(value!));
                              // selectedStage = value as StudyingModel;
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
                    45.0.sizedBoxHeight,
                    BlocBuilder<FreeSubjectsSubscriptionsBloc,
                        FreeSubjectsSubscriptionsState>(builder: (context, state) {
                      switch (state.getTermsState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          return DefaultDropDownButton<StudyingModel>(
                            studyingData: state.terms,
                            displayText: (terms) => terms.name,
                            selectedItem: state.currentTerm,
                            onChange: (value) {
                              context
                                  .read<FreeSubjectsSubscriptionsBloc>()
                                  .add(ChangeTermFreeSubjectsEvent(value!));
                              // selectedStage = value as StudyingModel;
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
                    45.0.sizedBoxHeight,
                    BlocBuilder<FreeSubjectsSubscriptionsBloc,
                        FreeSubjectsSubscriptionsState>(builder: (context, state) {
                      switch (state.getPathsState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          return DefaultDropDownButton<StudyingModel>(
                            studyingData: state.paths,
                            displayText: (paths) => paths.name,
                            selectedItem: state.currentPath,
                            onChange: (value) {
                              context
                                  .read<FreeSubjectsSubscriptionsBloc>()
                                  .add(ChangePathFreeSubjectsEvent(value!));
                              // selectedStage = value as StudyingModel;
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
                    10.sizedBoxHeight,
                    BlocSelector<FreeSubjectsSubscriptionsBloc, FreeSubjectsSubscriptionsState, Tuple2<bool, dynamic>>(
                      selector: (state) {
                        return Tuple2(state.getTermsState == RequestStates.loaded, state.getPathsState);
                      },
                      builder: (context, tuple) {
                        if (tuple.init && tuple.value2 == RequestStates.initial) {
                          return DefaultButtonWidget(
                            label: AppStrings.toSubjects,
                            onPressed: () {
                              RouteManager.rPushNamed(
                                context: context,
                                rName: AppRoutesNames.rSubjectsSubscriptionScreen,
                                arguments: GoToSubjectData(
                                  getSubjectsParameters: ParameterGoToQuestions(
                                    systemId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentSystem.id,
                                    stageId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentStage.id,
                                    classRoomId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentClassRoom.id,
                                    termId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentTerm.id,
                                    pathId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentPath.id,
                                  ),
                                ).copyWith(
                                  userData: userData,
                                ),
                              );
                            },
                          );
                        }
                        else if (tuple.init && tuple.value2  == RequestStates.loaded) {
                          if (BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.getPathsState == RequestStates.loaded) {
                            return DefaultButtonWidget(
                              label: AppStrings.toSubjects,
                              onPressed: () {
                                RouteManager.rPushNamed(
                                  context: context,
                                  rName: AppRoutesNames.rSubjectsSubscriptionScreen,
                                  arguments: GoToSubjectData(
                                    getSubjectsParameters: ParameterGoToQuestions(
                                      systemId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentSystem.id,
                                      stageId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentStage.id,
                                      classRoomId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentClassRoom.id,
                                      termId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentTerm.id,
                                      pathId: BlocProvider.of<FreeSubjectsSubscriptionsBloc>(context).state.currentPath.id,
                                    ),
                                  ).copyWith(
                                    userData: userData,
                                  ),
                                );
                              },
                            );
                          } else {
                            return LoadingShimmerStructure(height: 50.responsiveHeight,);
                          }
                        }
                        return Container();
                      },
                    )
                    ,
                  ],
                ),
              ),
            ],
          ),
        ),
      ).paddingBody(),
    );
  }
}
