part of '../../nafees_plans.dart';


// class NafeesStaticsData extends Equatable {
//   final List<NafeesSubjectsPlanEntity> subjects;
//   final int childId;
//
//   const NafeesStaticsData({
//     required this.subjects,
//     required this.childId,
//   });
//
//   @override
//   List<Object> get props => [subjects, childId];
// }
class NafeesStaticsScreen extends StatefulWidget {
 // final NafeesStaticsData nafeesStaticsData;

  // const NafeesStaticsScreen({super.key, required this.nafeesStaticsData});
  const NafeesStaticsScreen({super.key});

  @override
  State<NafeesStaticsScreen> createState() => _NafeesStaticsScreenState();
}

class _NafeesStaticsScreenState extends State<NafeesStaticsScreen> {
  // late NafeesSubjectsPlanEntity subjectItem;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   subjectItem = widget.nafeesStaticsData.subjects[0];
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StaticsBloc>()
        ..add(
          GetLessonsStaticsEvent(
            lessonsStaticsParam: const GetStaticsParam(
              systemId: 0,
              stageId: 0,
              termId: 0,
              classRoomId: 0,
            ).copyWith(
              // subjectId: widget.nafeesStaticsData.subjects[0].id,
              // childId: widget.nafeesStaticsData.childId,
              fromNafees: true,
            ),
          ),
        ),
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeaderForMore(title: AppStrings.staticsTitle),
                  AppSize.s20.sizedBoxHeight,
                  // Align(
                  //   alignment: AlignmentDirectional.topStart,
                  //   child: SizedBox(
                  //     width: AppReference.deviceWidth(context) * 0.8,
                  //     child: Builder(
                  //       builder: (context) {
                  //         return DefaultDropDownButton<NafeesSubjectsPlanEntity>(
                  //           studyingData: widget.nafeesStaticsData.subjects,
                  //           selectedItem: subjectItem,
                  //           onChange: (selectedSubject) {
                  //             setState(() {
                  //               subjectItem = selectedSubject!;
                  //             });
                  //
                  //               BlocProvider.of<StaticsBloc>(context).add(
                  //                 GetLessonsStaticsEvent(
                  //                   lessonsStaticsParam: GetStaticsParam(
                  //                     systemId: 0,
                  //                     stageId:0,
                  //                     termId: 0,
                  //                     classRoomId: 0,
                  //                     subjectId: subjectItem.id,
                  //                   ).copyWith(fromNafees: true),
                  //                 ),
                  //               );
                  //
                  //           },
                  //           displayText: (subject) => subject.name,
                  //         );
                  //       }
                  //     ),
                  //   ),
                  // ),
                  AppSize.s30.sizedBoxHeight,
                  BlocBuilder<StaticsBloc, StaticsState>(
                    builder: (context, state) {
                      switch (state.lessonsStaticsStates) {
                        case RequestStates.loading:
                          return LoadingShimmerList(
                            height: 100.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          if (state.lessonsStatics!.lessonsData.isEmpty) {
                            return const EmptyListWidgets(
                                message: AppStrings.noStaticsNow);
                          } else {
                            return Column(
                              children: [
                                AppSize.s20.sizedBoxHeight,

                                LessonsProgressCircleIndicator(
                                  totalLessons:
                                      state.lessonsStatics?.totalLessons ?? 0,
                                  finishedLessons:
                                      state.lessonsStatics?.finishLessons ?? 0,
                                ),
                                AppSize.s40.sizedBoxHeight,
                                BaseChartWidget(
                                  title: AppStrings.lessonIntoTime,
                                  xTitle: 'رقم الدرس',
                                  yTitle: 'عدد المرات',
                                  dataSource: context
                                      .read<StaticsBloc>()
                                      .attemptsForCharts,
                                  yMax: state.lessonsStatics!.maxAttempts,
                                  type: ChartType.attemptsLinear,
                                  xMax: context
                                          .read<StaticsBloc>()
                                          .state
                                          .lessonsStatics!
                                          .lessonsData
                                          .length -
                                      1,
                                ),
                                AppSize.s40.sizedBoxHeight,
                                BaseChartWidget(
                                  title: 'درجات الدروس',
                                  xTitle: 'رقم الدرس',
                                  yTitle: 'الدرجة',
                                  dataSource: context
                                      .read<StaticsBloc>()
                                      .pointForCharts,
                                  yMax: state.lessonsStatics!.maxPoint,
                                  type: ChartType.pointColumn,
                                  xMax: context
                                          .read<StaticsBloc>()
                                          .state
                                          .lessonsStatics!
                                          .lessonsData
                                          .length -
                                      1,
                                ),
                                AppSize.s30.sizedBoxHeight,
                                BaseChartWidget(
                                  title: 'الوقت المستغرق في حل الدروس',
                                  xTitle: 'رقم الدرس',
                                  yTitle: 'ثانية',
                                  dataSource:
                                      context.read<StaticsBloc>().timeForCharts,
                                  yMax: state.lessonsStatics!.maxTime ~/ 60,
                                  type: ChartType.timeArea,
                                  xMax: context
                                          .read<StaticsBloc>()
                                          .state
                                          .lessonsStatics!
                                          .lessonsData
                                          .length -
                                      1,
                                ),
                              ],
                            );
                          }
                        case RequestStates.error:
                          return CustomErrorWidget(
                              errorMessage: state.lessonsStaticsErrorMessage);
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                  AppSize.s20.sizedBoxHeight,
                ],
              ).paddingBody(),
            ),
          ),
        ),
      ),
    );
  }
}
