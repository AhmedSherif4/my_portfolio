part of '../../home.dart';

class _MoveBetweenClassroomsDialog extends StatelessWidget {
  const _MoveBetweenClassroomsDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: BlocProvider(
          create: (context) =>
              getIt<GradeChoosingBloc>()..add(GetSystemEvent()),
          child: BlocListener<GradeChoosingBloc, GradeChoosingState>(
            listener: (context, state) {
              switch (state.gradeChoosingSubmittedStates) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.of(context).pop();
                  showSnackBar(
                      description: state.gradeChoosingMessage,
                      state: ToastStates.congrats,
                      context: context);
                  RouteManager.rPushNamedAndRemoveUntil(
                    context: context,
                    rName: AppRoutesNames.rHomeLayoutView,
                    arguments: getIt<UserLocalDataSource>().getUserData(),
                  );

                case RequestStates.error:
                  Navigator.of(context).pop();
                  showSnackBar(
                      description: state.gradeChoosingMessage,
                      state: ToastStates.error,
                      context: context);
                default:
              }
            },
            child: Container(
                padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR20.responsiveHeight)),
                child: SingleChildScrollView(
                  child: BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
  builder: (context, state) {
    if(state.getTermsState == RequestStates.loaded){
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImagesAssets.sChooseClassroom),
                AppSize.s10.sizedBoxWidth,
                Text(
                  "التنقل بين الصفوف",
                  style: const AppTextStyle()
                      .balooBhaijaan2
                      .w500
                      .black
                      .bodyMedium14,
                ),
              ],
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
                  switch (state.getTermsState) {
                    case RequestStates.loading:
                      return LoadingShimmerStructure(
                        height: 40.responsiveHeight,
                      );
                    case RequestStates.loaded:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اختر الفصل الدراسي",
                            style: const AppTextStyle()
                                .balooBhaijaan2
                                .w500
                                .black
                                .bodyMedium14,
                          ),
                          AppSize.s10.sizedBoxHeight,
                          DefaultDropDownButton<StudyingModel>(
                            studyingData: state.terms,
                            selectedItem: state.currentTerm,
                            displayText: (term) => term.name,
                            onChange: (value) {
                              context
                                  .read<GradeChoosingBloc>()
                                  .add(ChangeTermEvent(value!));
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
            BlocSelector<GradeChoosingBloc, GradeChoosingState,
                Tuple2<bool, dynamic>>(
              selector: (state) {
                return Tuple2(
                    state.getTermsState == RequestStates.loaded,
                    state.getPathsState);
              },
              builder: (context, tuple) {
                if (tuple.init &&
                    tuple.value2 == RequestStates.initial) {
                  return DefaultButtonWidget(
                    label: AppStrings.done,
                    onPressed: () {
                      context.read<GradeChoosingBloc>().add(
                        GradeChoosingSubmittedEvent(
                          parameters: GradeChoosingParameters(
                            systemId: context
                                .read<GradeChoosingBloc>()
                                .state
                                .currentSystem
                                .id,
                            stageId: context
                                .read<GradeChoosingBloc>()
                                .state
                                .currentStage
                                .id,
                            classRoomId: context
                                .read<GradeChoosingBloc>()
                                .state
                                .currentClassRoom
                                .id,
                            termId: context
                                .read<GradeChoosingBloc>()
                                .state
                                .currentTerm
                                .id,
                            pathId: context
                                .read<GradeChoosingBloc>()
                                .state
                                .currentPath
                                .id,
                          ),
                        ),
                      );
                    },
                  );
                } else if (tuple.init &&
                    tuple.value2 == RequestStates.loaded) {
                  if (BlocProvider.of<GradeChoosingBloc>(context)
                      .state
                      .getPathsState ==
                      RequestStates.loaded) {
                    return DefaultButtonWidget(
                      label: AppStrings.done,
                      onPressed: () {
                        context.read<GradeChoosingBloc>().add(
                          GradeChoosingSubmittedEvent(
                            parameters: GradeChoosingParameters(
                              systemId: context
                                  .read<GradeChoosingBloc>()
                                  .state
                                  .currentSystem
                                  .id,
                              stageId: context
                                  .read<GradeChoosingBloc>()
                                  .state
                                  .currentStage
                                  .id,
                              classRoomId: context
                                  .read<GradeChoosingBloc>()
                                  .state
                                  .currentClassRoom
                                  .id,
                              termId: context
                                  .read<GradeChoosingBloc>()
                                  .state
                                  .currentTerm
                                  .id,
                              pathId: context
                                  .read<GradeChoosingBloc>()
                                  .state
                                  .currentPath
                                  .id,
                            ),
                          ),
                        );
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
          ]);
    }else if(
        state.getTermsState == RequestStates.loading
    || state.getClassRoomsState == RequestStates.loading
    || state.getSystemState == RequestStates.loading
    || state.getStagesState == RequestStates.loading
    ){
      return const _LoadingMoveClassroomDialog();
    }else {
      return const SizedBox.shrink();
    }
  },
),
                )),
          )),
    );
  }
}

class _LoadingMoveClassroomDialog extends StatelessWidget {
  const _LoadingMoveClassroomDialog();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImagesAssets.sChooseClassroom),
              AppSize.s10.sizedBoxWidth,
              Text(
                "التنقل بين الصفوف",
                style: const AppTextStyle()
                    .balooBhaijaan2
                    .w500
                    .black
                    .bodyMedium14,
              ),
            ],
          ),
          AppSize.s40.sizedBoxHeight,
          LoadingShimmerStructure(
          height: 50.responsiveHeight,
        ),AppSize.s40.sizedBoxHeight,
          LoadingShimmerStructure(
          height: 50.responsiveHeight,
        ),AppSize.s40.sizedBoxHeight,
          LoadingShimmerStructure(
          height: 50.responsiveHeight,
        ),AppSize.s40.sizedBoxHeight,
          LoadingShimmerStructure(
          height: 50.responsiveHeight,
        ),
        ]);
  }
}
