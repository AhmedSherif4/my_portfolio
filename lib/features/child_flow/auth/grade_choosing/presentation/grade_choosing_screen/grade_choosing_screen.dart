part of '../../grade_choosing.dart';

class GradeChoosingScreen extends StatefulWidget {
  final bool fromUpdateData;

  const GradeChoosingScreen({
    super.key,
    this.fromUpdateData = false,
  });

  @override
  State<GradeChoosingScreen> createState() => _GradeChoosingScreenState();
}

class _GradeChoosingScreenState extends State<GradeChoosingScreen> {
  List<StudyingModel> studyingData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                  widget.fromUpdateData
                      ? RouteManager.rPushNamedAndRemoveUntil(
                          context: context,
                          rName: AppRoutesNames.rHomeLayoutView,
                          arguments: getIt<UserLocalDataSource>().getUserData(),
                        )
                      : RouteManager.rPushNamedAndRemoveUntil(
                          context: context,
                          rName: AppRoutesNames.rChildAddParentWays,
                          arguments: false,
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
            child: ResponsiveWidgetForTablet(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(widget.fromUpdateData)
                  const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextBackButton()),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FittedBox(
                      child: Text(
                        AppStrings.gradeChoosingTitle,
                        style: const AppTextStyle().balooBhaijaan2.displaySmall28,
                      ),
                    ),
                  ),
                  AppSize.s40.sizedBoxHeight,
                  OrientationItem(
                    portraitWidget: Column(
                      children: [
                        const ChooseGradeImage(),
                        AppSize.s20.sizedBoxHeight,
                        const ChooseGradeView(),
                      ],
                    ),
                    landscapeWidget: const Row(
                      children: [
                        Expanded(flex: 2, child: ChooseGradeView()),
                        Expanded(child: ChooseGradeImage()),
                      ],
                    ),
                  ),
                  45.0.sizedBoxHeight,
                  BlocSelector<GradeChoosingBloc, GradeChoosingState, List<StudyingModel>>(selector: (state){
                    return state.terms;
                  }, builder: (context, selectedState) {
                // Build your widget tree based on the selected state.
                // This builder will only be called when the selected state changes.
                return selectedState.isEmpty  || selectedState.first.id == -1 ? const SizedBox.shrink() :  DefaultButtonWidget(
                  label: AppStrings.done,
                  onPressed: () {

                    context.read<GradeChoosingBloc>().add(
                      GradeChoosingSubmittedEvent(
                        parameters: GradeChoosingParameters(
                          systemId: context.read<GradeChoosingBloc>()
                              .state.currentSystem.id,
                            stageId: context.read<GradeChoosingBloc>()
                                .state.currentStage.id,
                            classRoomId: context.read<GradeChoosingBloc>().state
                                .currentClassRoom
                                .id,
                            termId: context.read<GradeChoosingBloc>()
                                .state.currentTerm
                                .id,
                          pathId: context
                            .read<GradeChoosingBloc>().state.currentPath.id,),
                      ),
                    );
                  },
                );
                      },),

                ],
              ),
              tablet: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: AppReference.deviceHeight(context)*0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: FittedBox(
                              child: Text(
                                AppStrings.gradeChoosingTitle,
                                style: const AppTextStyle().balooBhaijaan2.s18.w600.displaySmall28,
                              ),
                            ),
                          ),
                          AppSize.s10.sizedBoxHeight,

                          const ChooseGradeImage(),
                        ],
                      ),
                    ),
                  ),
                  AppSize.s20.sizedBoxWidth,

                  Expanded(
                    flex: 2,
                    // width: AppReference.deviceWidth(context)*0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(widget.fromUpdateData)
                          const Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextBackButton()),
                        AppSize.s30.sizedBoxHeight,
                        const ChooseGradeView(),
                        BlocSelector<GradeChoosingBloc, GradeChoosingState, List<StudyingModel>>(selector: (state){
                          return state.terms;
                        }, builder: (context, selectedState) {
                          // Build your widget tree based on the selected state.
                          // This builder will only be called when the selected state changes.
                          return selectedState.isEmpty  || selectedState.first.id == -1 ? const SizedBox.shrink() :  DefaultButtonWidget(
                            label: AppStrings.done,
                            onPressed: () {

                              context.read<GradeChoosingBloc>().add(
                                GradeChoosingSubmittedEvent(
                                  parameters: GradeChoosingParameters(
                                    systemId: context.read<GradeChoosingBloc>()
                                        .state.currentSystem.id,
                                    stageId: context.read<GradeChoosingBloc>()
                                        .state.currentStage.id,
                                    classRoomId: context.read<GradeChoosingBloc>().state
                                        .currentClassRoom
                                        .id,
                                    termId: context.read<GradeChoosingBloc>()
                                        .state.currentTerm
                                        .id,
                                    pathId: context
                                        .read<GradeChoosingBloc>().state.currentPath.id,),
                                ),
                              );
                            },
                          );
                        },),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).paddingBody(),
      ),
    );
  }
}

class ChooseGradeImage extends StatelessWidget {
  const ChooseGradeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImagesAssets.sReadingGlassesBro,
      width: AppReference.deviceWidth(context) * 0.85,
      height: AppReference.deviceHeight(context) * 0.13.responsiveHeightRatio,
    );
  }
}

class ChooseGradeView extends StatelessWidget {
  const ChooseGradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
            builder: (context, state) {
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
                          .read<GradeChoosingBloc>()
                          .add(ChangeSystemEvent(value!));
                  // selectedStage = value as StudyingModel;
                },
              );
            default:
              return const SizedBox();
          }
        }),
        45.0.sizedBoxHeight,
        BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
            builder: (context, state) {
          switch (state.getStagesState) {
            case RequestStates.loading:
              return LoadingShimmerStructure(
                height: 40.responsiveHeight,
              );
            case RequestStates.loaded:
              return DefaultDropDownButton<StudyingModel>(
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
              );
            default:
              return const SizedBox();
          }
        }),
        45.0.sizedBoxHeight,
        BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
            builder: (context, state) {
          switch (state.getClassRoomsState) {
            case RequestStates.loading:
              return LoadingShimmerStructure(
                height: 40.responsiveHeight,
              );
            case RequestStates.loaded:
              return DefaultDropDownButton<StudyingModel>(
                studyingData: state.classRooms,
                selectedItem: state.currentClassRoom,
                displayText: (classroom) => classroom.name,
                onChange: (value) {
                  state.currentClassRoom == value
                      ? null
                      : context
                          .read<GradeChoosingBloc>()
                          .add(ChangeClassRoomEvent(value!));
                  // selectedStage = value as StudyingModel;
                },
              );
            default:
              return const SizedBox();
          }
        }),
        45.0.sizedBoxHeight,
        BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
            builder: (context, state) {
          switch (state.getTermsState) {
            case RequestStates.loading:
              return LoadingShimmerStructure(
                height: 40.responsiveHeight,
              );
            case RequestStates.loaded:
              return DefaultDropDownButton<StudyingModel>(
                studyingData: state.terms,
                selectedItem: state.currentTerm,
                displayText: (term) => term.name,
                onChange: (value) {
                  context
                      .read<GradeChoosingBloc>()
                      .add(ChangeTermEvent(value!));
                  // selectedStage = value as StudyingModel;
                },
              );
            default:
              return const SizedBox();
          }
        }),
        45.0.sizedBoxHeight,
        BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
            builder: (context, state) {
          switch (state.getPathsState) {
            case RequestStates.loading:
              return LoadingShimmerStructure(
                height: 40.responsiveHeight,
              );
            case RequestStates.loaded:
              return state.paths.isEmpty ? const SizedBox.shrink() : DefaultDropDownButton<StudyingModel>(
                studyingData: state.paths,
                selectedItem: state.currentPath,
                displayText: (path) => path.name,
                onChange: (value) {
                  context
                      .read<GradeChoosingBloc>()
                      .add(ChangePathEvent(value!));
                  // selectedStage = value as StudyingModel;
                },
              );
            default:
              return const SizedBox();
          }
        }),
      ],
    );
  }
}
