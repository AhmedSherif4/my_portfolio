part of '../../../statics.dart';


class LevelStaticsScreen extends StatelessWidget {
  final GetStaticsParam levelParameters;

  const LevelStaticsScreen({super.key, required this.levelParameters});

  @override
  Widget build(BuildContext context) {
    List<LevelAndCollectionEntity> allLevels = [];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<LevelsBloc>()
              ..add(GetAllLevels(
                ParameterGoToQuestions(
                  systemId: levelParameters.systemId,
                  subjectId: levelParameters.subjectId!,
                  stageId: levelParameters.stageId,
                  classRoomId: levelParameters.classRoomId,
                  termId: levelParameters.termId,
                  pathId: levelParameters.pathId ?? 0,
                ),
              ))),
        BlocProvider(
          create: (context) => getIt<StaticsLevelBloc>(),
        ),
      ],
      child: BlocListener<LevelsBloc, LevelsState>(
        listener: (context, state) {
          if (state.levelsStates == RequestStates.loaded) {
            if(state.levels.isNotEmpty){
            allLevels = state.levels;
            final data = levelParameters.copyWith(
              levelId: state.levels.first.id,
            );
            BlocProvider.of<StaticsLevelBloc>(context).add(
              GetLevelStaticsEvent(
                levelStaticsParam: data,
              ),
            );
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderForMore(
                      title: 'تقارير المستويات', notFirst: true),
                  AppSize.s40.sizedBoxHeight,
                  BlocBuilder<LevelsBloc, LevelsState>(
                    builder: (context, state) {
                      switch (state.levelsStates) {
                        case RequestStates.loading:
                          return LoadingShimmerList(
                            height: 50.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          if (state.levels.isNotEmpty) {
                            return StudyingDropDownForLessonsinStaticsScreen(
                              allLevels: allLevels,
                              levelParameters: levelParameters,
                            );
                          } else {
                            return SizedBox(
                              height: AppReference.deviceHeight(context) * 0.4,
                              child: const Center(
                                child: EmptyListWidgets(
                                    message: 'لا يوجد مستويات الآن'),
                              ),
                            );
                          }
                        case RequestStates.error:
                          return CustomErrorWidget(
                              errorMessage: state.levelsErrorMessage);
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                  50.sizedBoxHeight,
                  BlocBuilder<StaticsLevelBloc, StaticsLevelState>(
                    builder: (context, state) {
                      switch (state.levelStaticsStates) {
                        case RequestStates.loading:
                          return LoadingShimmerList(
                            height: 100.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          if (state.levelStatics!.groupData.isEmpty ||
                              allLevels.isEmpty) {
                            return SizedBox(
                              height: AppReference.deviceHeight(context) * 0.4,
                              child: const Center(
                                child: EmptyListWidgets(
                                    message: 'لا يوجد تقارير لهذا المستوى الآن'),
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                BaseChartWidget(
                                  title: 'عدد مرات دخول أسئلة المجموعات',
                                  xTitle: 'رقم المجموعة',
                                  yTitle: 'عدد المرات',
                                  dataSource: context
                                      .read<StaticsLevelBloc>()
                                      .attemptsForCharts,
                                  yMax: state.levelStatics!.maxAttempts,
                                  type: ChartType.attemptsLinear,
                                  xMax: context
                                          .read<StaticsLevelBloc>()
                                          .state
                                          .levelStatics!
                                          .groupData
                                          .length -
                                      1,
                                ),
                                30.sizedBoxHeight,
                                BaseChartWidget(
                                  title: 'درجات المجموعات',
                                  xTitle: 'رقم المجموعة',
                                  yTitle: 'الدرجة',
                                  dataSource: context
                                      .read<StaticsLevelBloc>()
                                      .pointForCharts,
                                  yMax: state.levelStatics!.maxPoint,
                                  type: ChartType.pointColumn,
                                  xMax: context
                                          .read<StaticsLevelBloc>()
                                          .state
                                          .levelStatics!
                                          .groupData
                                          .length -
                                      1,
                                ),
                                30.sizedBoxHeight,
                                BaseChartWidget(
                                  title: 'الوقت المستغرق في حل المجموعات',
                                  xTitle: 'رقم المجموعة',
                                  yTitle: 'ثانية',
                                  dataSource: context
                                      .read<StaticsLevelBloc>()
                                      .timeForCharts,
                                  yMax: state.levelStatics!.maxTime,
                                  type: ChartType.timeArea,
                                  xMax: context
                                          .read<StaticsLevelBloc>()
                                          .state
                                          .levelStatics!
                                          .groupData
                                          .length -
                                      1,
                                ),
                                30.sizedBoxHeight,
                              ],
                            );
                          }
                        case RequestStates.error:
                          return CustomErrorWidget(
                              errorMessage: state.levelStaticsErrorMessage);
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}

class StudyingDropDownForLessonsinStaticsScreen extends StatefulWidget {
  final GetStaticsParam levelParameters;
  final List<LevelAndCollectionEntity> allLevels;

  const StudyingDropDownForLessonsinStaticsScreen(
      {super.key, required this.levelParameters, required this.allLevels});

  @override
  State<StudyingDropDownForLessonsinStaticsScreen> createState() => _StudyingDropDownForStaticsScreenState();
}

class _StudyingDropDownForStaticsScreenState extends State<StudyingDropDownForLessonsinStaticsScreen> {
  late LevelAndCollectionEntity item;

  @override
  void initState() {
    super.initState();
    item = widget.allLevels.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio ,
      width: AppReference.deviceWidth(context) * 0.6,
      child: DefaultDropDownButton<LevelAndCollectionEntity>(
        studyingData: widget.allLevels,
        selectedItem: item,
        onChange: (selectedLevel) {
          setState(() {
            item = selectedLevel!;
          });
          final updateData = widget.levelParameters.copyWith(
            levelId: item.id,
          );
          context.read<StaticsLevelBloc>().add(
                GetLevelStaticsEvent(
                  levelStaticsParam: updateData,
                ),
              );
        },
        displayText: (level) => level.name,
      ),
    );
  }
}
