part of '../../../../statics.dart';


class ChildStaticsScreen extends StatefulWidget {
  final GetStaticsParam? getStaticsParam;

  const ChildStaticsScreen({super.key, this.getStaticsParam});

  @override
  State<ChildStaticsScreen> createState() => _ChildStaticsScreenState();
}

class _ChildStaticsScreenState extends State<ChildStaticsScreen> {
  late SubjectsEntity subjectId;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final userData = widget.getStaticsParam != null
            ? widget.getStaticsParam!.userData!
            : getIt<UserLocalDataSource>().getUserData()!;
        context.read<StaticsBloc>()
          ..add(GetTimeInAppEvent(
            timeInAppInputs: TimeInAppInputs(
              startDate: DateTime.now(),
              endDate: DateTime.now().subtract(const Duration(days: 1)),
              childId: userData.userId,
            ),
          ))
          ..add(GetLessonsStaticsEvent(
            lessonsStaticsParam: GetStaticsParam(
              systemId: userData.systemId!,
              stageId: userData.stageId!,
              termId: userData.termId!,
              classRoomId: userData.classroomId!,
              pathId: userData.pathId,
              userData: userData,
            ).copyWith(
              subjectId: BlocProvider.of<SharedSubjectsBloc>(context)
                  .state
                  .subjects
                  .first
                  .subjectId,
            ),
          ))
          ..add(
            GetBestSubjectsEvent(
              bestSubjectsParm: GetStaticsParam(
                systemId: userData.systemId!,
                stageId: userData.stageId!,
                termId: userData.termId!,
                classRoomId: userData.classroomId!,
                pathId: userData.pathId,
              ),
            ),
          );
      },
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ResponsiveWidgetForTablet(
            mobile: _StaticsPortraitView(
              getStaticsParam: widget.getStaticsParam,
              goToLevelsScreen: _goToLevelsScreen,
              goToSkillsScreen: _goToSkillsScreen,
              viewChildRanking: _viewChildRanking,
              currentSubject: (sub) {
                subjectId = sub!;
              },
            ),
            tablet: OrientationItem(
              portraitWidget: _StaticsPortraitView(
                getStaticsParam: widget.getStaticsParam,
                goToLevelsScreen: _goToLevelsScreen,
                goToSkillsScreen: _goToSkillsScreen,
                viewChildRanking: _viewChildRanking,
                currentSubject: (sub) {
                  subjectId = sub!;
                },
              ),
              landscapeWidget: _StaticsLandscapeView(
                getStaticsParam: widget.getStaticsParam,
                goToLevelsScreen: _goToLevelsScreen,
                goToSkillsScreen: _goToSkillsScreen,
                viewChildRanking: _viewChildRanking,
                currentSubject: (sub) {
                  subjectId = sub!;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _viewChildRanking() {
    if (!AppReference.userIsGuest()) {
      RouteManager.rPushNamed(
        context: context,
        rName: AppRoutesNames.rRankScreen,
        arguments: RankData(
          stageId: widget.getStaticsParam?.stageId ??
              getIt<UserLocalDataSource>().getUserData()!.stageId!,
          systemId: widget.getStaticsParam?.systemId ??
              getIt<UserLocalDataSource>().getUserData()!.systemId!,
          pathId: widget.getStaticsParam?.pathId ??
              getIt<UserLocalDataSource>().getUserData()!.pathId!,
          classroomId: widget.getStaticsParam?.classRoomId ??
              getIt<UserLocalDataSource>().getUserData()!.classroomId!,
          termId: widget.getStaticsParam?.termId ??
              getIt<UserLocalDataSource>().getUserData()!.termId!,
          className: widget.getStaticsParam?.classRoomName ??
              getIt<UserLocalDataSource>().getUserData()!.classroomName,
          // point: widget.getStaticsParam?.classRoomName ?? getIt<UserLocalDataSource>().getUserData()!.classroomName,
          childId: widget.getStaticsParam?.childId ??
              getIt<UserLocalDataSource>().getUserData()!.userId,
        ),
      );
    } else {
      AppReference.guestDialogMustLogin(context);
    }
  }

  void _goToSkillsScreen() {
    if (!AppReference.userIsGuest()) {
      if (widget.getStaticsParam != null) {
        final data = widget.getStaticsParam!.copyWith(
          subjectId: subjectId.subjectId,
          subjectName: subjectId.subjectName,
          isLesson: true,
        );
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rFailsSkillsScreen,
          arguments: GetFailsSkillsWithQuestionsParameters(
            fromStatic: true,
            subjectId: data.subjectId!,
            childId: data.childId,
            subjects: data.allSubjects,
          ),
        );
      } else {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rFailsSkillsScreen,
          arguments: GetFailsSkillsWithQuestionsParameters(
            fromStatic: false,
            subjectId: subjectId.subjectId,
            childId: 0,
            subjects: context.read<SharedSubjectsBloc>().state.subjects,
          ),
        );
      }    } else {
      AppReference.guestDialogMustLogin(context);
    }
  }

  void _goToLevelsScreen() {
    if (!AppReference.userIsGuest()) {
      if (widget.getStaticsParam != null) {
        final data = widget.getStaticsParam!.copyWith(
          subjectId: subjectId.subjectId,
          subjectName: subjectId.subjectName,
          isLesson: false,
        );
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rLevelStaticsScreen,
          arguments: data,
        );
      } else {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rLevelStaticsScreen,
          arguments: GetStaticsParam(
            systemId: getIt<UserLocalDataSource>().getUserData()!.systemId!,
            stageId: getIt<UserLocalDataSource>().getUserData()!.stageId!,
            termId: getIt<UserLocalDataSource>().getUserData()!.termId!,
            classRoomId: getIt<UserLocalDataSource>().getUserData()!.classroomId!,
            pathId: getIt<UserLocalDataSource>().getUserData()!.pathId,
            subjectId: subjectId.subjectId,
            subjectName: subjectId.subjectName,
            isLesson: false,
          ),
        );
      }    } else {
      AppReference.guestDialogMustLogin(context);
    }

  }
}

class _LessonTriesChartWidget extends StatelessWidget {
  final int yMax;
  const _LessonTriesChartWidget({
    required this.yMax,
  });

  @override
  Widget build(BuildContext context) {
    return BaseChartWidget(
      title: AppStrings.lessonIntoTime,
      xTitle: 'رقم الدرس',
      yTitle: 'عدد المرات',
      dataSource: context.read<StaticsBloc>().attemptsForCharts,
      yMax: yMax,
      type: ChartType.attemptsLinear,
      xMax:
          context.read<StaticsBloc>().state.lessonsStatics!.lessonsData.length -
              1,
    );
  }
}

class _LessonTimeChartWidget extends StatelessWidget {
  const _LessonTimeChartWidget();

  @override
  Widget build(BuildContext context) {
    return BaseChartWidget(
      title: 'الوقت المستغرق في حل الدروس',
      xTitle: 'رقم الدرس',
      yTitle: 'ثانية',
      dataSource: context.read<StaticsBloc>().timeForCharts,
      type: ChartType.timeArea,
    );
  }
}

class _LessonScoreChartWidget extends StatelessWidget {
  final int yMax;
  const _LessonScoreChartWidget({
    required this.yMax,
  });

  @override
  Widget build(BuildContext context) {
    return BaseChartWidget(
      title: 'درجات الدروس',
      xTitle: 'رقم الدرس',
      yTitle: 'الدرجة',
      dataSource: context.read<StaticsBloc>().pointForCharts,
      yMax: yMax,
      type: ChartType.pointColumn,
      xMax:
          context.read<StaticsBloc>().state.lessonsStatics!.lessonsData.length -
              1,
    );
  }
}

class _MyCurrentPointsWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  const _MyCurrentPointsWidget({this.height, this.width, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p44.responsiveSize),
      height: height ?? AppSize.s100.responsiveSize,
      decoration: BoxDecoration(
        gradient: AppGradientColors.pointsGradient,
        borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "نقاطي الحالية",
                style:
                    const AppTextStyle().balooBhaijaan2.w800.white.bodyMedium14,
              ),
              Text(
                title,
                style: const AppTextStyle()
                    .balooBhaijaan2
                    .w600
                    .white
                    .displayMedium30,
              )
            ],
          ),
          SvgPicture.asset(AppIconsAssets.skenz),
        ],
      ),
    );
  }
}

class _StaticsPortraitView extends StatelessWidget {
  final GetStaticsParam? getStaticsParam;
  final Function(SubjectsEntity?) currentSubject;
  final Function() viewChildRanking;
  final Function() goToSkillsScreen;
  final Function() goToLevelsScreen;
  const _StaticsPortraitView(
      {required this.getStaticsParam,
      required this.currentSubject,
      required this.viewChildRanking,
      required this.goToSkillsScreen,
      required this.goToLevelsScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (AppReference.userIsChild())
          HomeHeaderForAllChild(userData: getStaticsParam?.userData),
        if (!AppReference.userIsChild())
          SizedBox(
            width: double.infinity,
            height: AppReference.deviceIsTablet
                ? AppReference.deviceHeight(context) *
                    0.045.responsiveHeightRatio
                : AppReference.deviceHeight(context) *
                    0.06.responsiveHeightRatio,
            child: LayoutBuilder(builder: (context, constrains) {
              return Row(
                children: [
                  SvgPicture.asset(
                    AppImagesAssets.sLogoWithoutName,
                    height: constrains.maxHeight * 0.8,
                    fit: BoxFit.contain,
                  ),
                  AppSize.s6.sizedBoxWidth,
                  SizedBox(
                    width: AppReference.deviceIsTablet
                        ? AppReference.deviceWidth(context) * 0.2
                        : AppReference.deviceWidth(context) * 0.5,
                    child: LayoutBuilder(builder: (context, consColumn) {
                      return SizedBox(
                        height: consColumn.maxHeight * 0.5,
                        width: consColumn.maxWidth,
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: FittedBox(
                            child: Text(
                              getStaticsParam?.userData != null
                                  ? getStaticsParam!.userData!.name
                                      .split(' ')
                                      .first
                                  : getIt<UserLocalDataSource>()
                                      .getUserData()!
                                      .name
                                      .split(' ')
                                      .first,
                              textAlign: TextAlign.start,
                              style: AppReference
                                  .themeData.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            }),
          ),
        AppSize.s20.sizedBoxHeight,
        ChildInfoWidgetForStatics(
          userData: getStaticsParam != null
              //&& !AppReference.userIsChild()
              ? getStaticsParam!.userData!
                  .copyWith(classroomName: getStaticsParam!.classRoomName)
              : getIt<UserLocalDataSource>().getUserData()!,
        ).animateSlideTopToNormal(duration: AppConstants.animationTime),
        AppSize.s24.sizedBoxHeight,
        DefaultButtonWidget(
            buttonColor: AppColors.primaryColor2,
            borderColor: Colors.transparent,
            isExpanded: true,
            frontIcon: AppIconsAssets.sStaticsNew,
            label: AppReference.userIsChild() ? "رؤية ترتيبي" : "رؤية ترتيب الطالب ",
            onPressed: () {

              viewChildRanking();
            }),
        AppSize.s24.sizedBoxHeight,
        // if(AppReference.userIsChild()&&)
        _MyCurrentPointsWidget(
          title: getStaticsParam != null
              ? getStaticsParam!.points ?? '0'
              : getIt<UserLocalDataSource>().getUserData()!.points.toString(),
        ),
        AppSize.s24.sizedBoxHeight,
        SizedBox(
          height: AppReference.deviceIsTablet
              ? AppReference.deviceHeight(context) *
                  (0.25.responsiveHeightRatio)
              : AppReference.deviceHeight(context) *
                  (0.19.responsiveHeightRatio),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TotalTimeInAppBuilder(
                  childId: getStaticsParam != null
                      ? getStaticsParam!.userData!.userId
                      : getIt<UserLocalDataSource>().getUserData()!.userId,
                ).animateRightLeft(duration: AppConstants.animationTime),
              ),
              AppSize.s10.sizedBoxWidth,
              Expanded(
                child: FinishedSubjectWidget(
                  staticsParam: getStaticsParam,
                ).animateRightLeft(
                    isFromStart: false, duration: AppConstants.animationTime),
              ),
            ],
          ),
        ),
        AppSize.s20.sizedBoxHeight,
        Align(
          alignment: AlignmentDirectional.topStart,
          child: SizedBox(
            width: AppReference.deviceWidth(context) * 0.8,
            child: StudyingDropDownForStaticsScreen(
              lessonParameters: getStaticsParam,
              currentSubject: currentSubject,
            ),
          ),
        ),
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
                      LessonsProgressCircleIndicator(
                        totalLessons: state.lessonsStatics?.totalLessons ?? 0,
                        finishedLessons:
                            state.lessonsStatics?.finishLessons ?? 0,
                      ),
                      AppSize.s20.sizedBoxHeight,
                      _LessonTriesChartWidget(
                        yMax: state.lessonsStatics!.maxAttempts,
                      ),
                      AppSize.s30.sizedBoxHeight,
                      _LessonScoreChartWidget(
                        yMax: state.lessonsStatics!.maxPoint,
                      ),
                      AppSize.s30.sizedBoxHeight,
                      const _LessonTimeChartWidget(),
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
        AppSize.s30.sizedBoxHeight,
        StaticButton(
          title: AppReference.childIsPrimary()? 'المهارات الضعيفة / المفقودة':"الفاقد التعليمي",
          imagePath: AppImagesAssets.sStaticArrow,
          onTap: () {
            goToSkillsScreen();
          },
        ),
        AppSize.s20.sizedBoxHeight,
        StaticButton(
          title: AppStrings.levelStatics,
          imagePath: AppImagesAssets.sStaticLevel,
          onTap: () {
            goToLevelsScreen();
          },
        ),
        40.sizedBoxHeight,
        Align(
          alignment: AlignmentDirectional.topStart,
          child: UnderLinedText(
            text: AppStrings.bestSubjects,
            lineColor: AppColors.primaryColor,
            style: AppTextStyle.titleSmall18.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        15.sizedBoxHeight,
        const FinishSubjectsPercentageBuilder(),
        AppSize.s20.sizedBoxHeight,
      ],
    ).paddingBody();
  }
}

class _StaticsLandscapeView extends StatelessWidget {
  final GetStaticsParam? getStaticsParam;
  final Function(SubjectsEntity?) currentSubject;
  final Function() viewChildRanking;
  final Function() goToSkillsScreen;
  final Function() goToLevelsScreen;
  const _StaticsLandscapeView(
      {required this.getStaticsParam,
      required this.currentSubject,
      required this.viewChildRanking,
      required this.goToSkillsScreen,
      required this.goToLevelsScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (AppReference.userIsChild())
          HomeHeaderForAllChild(userData: getStaticsParam?.userData),
        if (!AppReference.userIsChild())
          SizedBox(
            width: double.infinity,
            height: AppReference.deviceIsTablet
                ? AppReference.deviceHeight(context) *
                    0.045.responsiveHeightRatio
                : AppReference.deviceHeight(context) *
                    0.06.responsiveHeightRatio,
            child: LayoutBuilder(builder: (context, constrains) {
              return Row(
                children: [
                  SvgPicture.asset(
                    AppImagesAssets.sLogoWithoutName,
                    height: constrains.maxHeight * 0.8,
                    fit: BoxFit.contain,
                  ),
                  AppSize.s6.sizedBoxWidth,
                  SizedBox(
                    width: AppReference.deviceIsTablet
                        ? AppReference.deviceWidth(context) * 0.2
                        : AppReference.deviceWidth(context) * 0.5,
                    child: LayoutBuilder(builder: (context, consColumn) {
                      return SizedBox(
                        height: consColumn.maxHeight * 0.5,
                        width: consColumn.maxWidth,
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: FittedBox(
                            child: Text(
                              getStaticsParam?.userData != null
                                  ? getStaticsParam!.userData!.name
                                      .split(' ')
                                      .first
                                  : getIt<UserLocalDataSource>()
                                      .getUserData()!
                                      .name
                                      .split(' ')
                                      .first,
                              textAlign: TextAlign.start,
                              style: AppReference
                                  .themeData.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            }),
          ),
        AppSize.s20.sizedBoxHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppReference.deviceWidth(context) * 0.28,
              height: AppReference.deviceHeight(context) * .2,
              child: ChildInfoWidgetForStatics(
                userData: getStaticsParam != null
                    ? getStaticsParam!.userData!
                        .copyWith(classroomName: getStaticsParam!.classRoomName)
                    : getIt<UserLocalDataSource>().getUserData()!,
              ).animateSlideTopToNormal(duration: AppConstants.animationTime),
            ),
            SizedBox(
              width: AppReference.deviceWidth(context) * 0.15,
              height: AppReference.deviceHeight(context) * .2,
              child: TotalTimeInAppBuilder(
                childId: getStaticsParam != null
                    ? getStaticsParam!.userData!.userId
                    : getIt<UserLocalDataSource>().getUserData()!.userId,
              ).animateRightLeft(duration: AppConstants.animationTime),
            ),
            SizedBox(
              width: AppReference.deviceWidth(context) * 0.15,
              height: AppReference.deviceHeight(context) * .2,
              child: FinishedSubjectWidget(
                staticsParam: getStaticsParam,
              ).animateRightLeft(
                  isFromStart: false, duration: AppConstants.animationTime),
            ),
            _MyCurrentPointsWidget(
              height: AppReference.deviceHeight(context) * .2,
              width: AppReference.deviceWidth(context) * 0.3,
              title: getStaticsParam?.points.toString() ??
                  getIt<UserLocalDataSource>().getUserData()!.points.toString(),
            ),
          ],
        ),
        AppSize.s30.sizedBoxHeight,
        SizedBox(
          width: AppReference.deviceWidth(context) * 0.3,
          child: Column(
            children: [
              DefaultButtonWidget(
                  buttonColor: AppColors.primaryColor2,
                  borderColor: Colors.transparent,
                  isExpanded: true,
                  frontIcon: AppIconsAssets.sStaticsNew,
                  label: AppReference.userIsChild() ? "رؤية ترتيبي" : "رؤية ترتيب الطالب ",
                  onPressed: () {
                    viewChildRanking();
                  }),
              AppSize.s20.sizedBoxHeight,
              Align(
                alignment: AlignmentDirectional.topStart,
                child: SizedBox(
                  width: AppReference.deviceWidth(context) * 0.8,
                  child: StudyingDropDownForStaticsScreen(
                      lessonParameters: getStaticsParam,
                      currentSubject: currentSubject),
                ),
              ),
              AppSize.s30.sizedBoxHeight,
              BlocBuilder<StaticsBloc, StaticsState>(
                builder: (context, state) {
                  switch (state.lessonsStaticsStates) {
                    case RequestStates.loading:
                      return const LoadingShimmerStructure();
                    case RequestStates.loaded:
                      if (state.lessonsStatics!.lessonsData.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return LessonsProgressCircleIndicator(
                          totalLessons: state.lessonsStatics?.totalLessons ?? 0,
                          finishedLessons:
                              state.lessonsStatics?.finishLessons ?? 0,
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
            ],
          ),
        ),
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
                  return Row(
                    children: [
                      Expanded(
                        child: _LessonTriesChartWidget(
                          yMax: state.lessonsStatics!.maxAttempts,
                        ),
                      ),
                      AppSize.s10.sizedBoxWidth,
                      Expanded(
                        child: _LessonScoreChartWidget(
                          yMax: state.lessonsStatics!.maxPoint,
                        ),
                      ),
                      AppSize.s10.sizedBoxWidth,
                      const Expanded(child:  _LessonTimeChartWidget()),
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
        AppSize.s30.sizedBoxHeight,
        SizedBox(
          height: AppReference.deviceHeight(context) * 0.15,
          child: Row(
            children: [
              Expanded(
                child: StaticButton(
                  title: AppReference.childIsPrimary()? 'المهارات الضعيفة / المفقودة':"الفاقد التعليمي",
                  imagePath: AppImagesAssets.sStaticArrow,
                  onTap: () {
                    goToSkillsScreen();
                  },
                ),
              ),
              AppSize.s60.sizedBoxWidth,
              Expanded(
                child: StaticButton(
                  title: AppStrings.levelStatics,
                  imagePath: AppImagesAssets.sStaticLevel,
                  onTap: () {
                    goToLevelsScreen();
                  },
                ),
              ),
            ],
          ),
        ),
        40.sizedBoxHeight,
        Align(
          alignment: AlignmentDirectional.topStart,
          child: UnderLinedText(
            text: AppStrings.bestSubjects,
            lineColor: AppColors.primaryColor,
            style: AppTextStyle.titleSmall18.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        20.sizedBoxHeight,
        const FinishSubjectsPercentageBuilder(),
      ],
    ).paddingBody();
  }
}
