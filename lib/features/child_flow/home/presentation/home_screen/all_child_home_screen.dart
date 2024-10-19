part of '../../home.dart';

class AllChildHomeScreen extends StatefulWidget {
  const AllChildHomeScreen({super.key});

  @override
  State<AllChildHomeScreen> createState() => _AllChildHomeScreenState();
}

class _AllChildHomeScreenState extends State<AllChildHomeScreen> {
  late final GlobalKey _one;
  late final GlobalKey _two;
  late final GlobalKey _three;
  late final GlobalKey _four;
  late final GlobalKey _five;

  @override
  void didChangeDependencies() async {
    _one = GlobalKey();
    _two = GlobalKey();
    _three = GlobalKey();
    _four = GlobalKey();
    _five = GlobalKey();
    await getIt<BaseLocalDataSource>()
        .getDataFromLocal<bool>(labelKey: AppKeys.showcaseViewed)
        .then((isShowcaseViewed) {
      if (isShowcaseViewed == null || !isShowcaseViewed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // isShowcaseViewed.log();
          ShowCaseWidget.of(context).startShowCase(
            [
              _one,
              _two,
              _three,
              _five,
              _four,
            ],
          );
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if ((state.getPuzzleAndAdviceState == RequestStates.initial) ||
            state.getPuzzleAndAdviceState == RequestStates.loading) {
          return const HomeLoadingWidget();
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<HomeBloc>(context).refreshHome();
            },
            child: ResponsiveWidgetForTablet(
              mobile: _AllChildPortraitView(
                one: _one,
                two: _two,
                three: _three,
                four: _four,
                five: _five,
                showClassroomsDialog: _showClassroomsDialog,
                goToMySkillsScreen: _goToMySkillsScreen,
              ),
              tablet: OrientationItem(
                  portraitWidget: _AllChildPortraitView(
                    one: _one,
                    two: _two,
                    three: _three,
                    four: _four,
                    five: _five,
                    showClassroomsDialog: _showClassroomsDialog,
                    goToMySkillsScreen: _goToMySkillsScreen,
                  ),
                  landscapeWidget: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: HomeHeaderForAllChild(),
                      ),
                      SliverToBoxAdapter(
                        child: AppSize.s32.sizedBoxHeight,
                      ),
                      const HomeSizedBox(),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: AppReference.deviceWidth(context) * 0.45,
                              height: AppReference.deviceHeight(context) * 0.42,
                              child: Column(
                                children: [
                                  PuzzleBuilder(
                                    one: _one,
                                    puzzleImagePath:
                                        AppImagesAssets.sChildPuzzle,
                                  ),
                                  const Spacer(),
                                  const TextWithImageWidget(
                                    label: AppStrings.adviceOfDay,
                                    imagePath: AppImagesAssets.sAdvice,
                                  ).animateRightLeft(
                                      duration: const Duration(seconds: 2)),
                                  AppSize.s16.sizedBoxHeight,
                                  AdviceItemBuilder(two: _two).animateRightLeft(
                                      duration: AppConstants.animationTime),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: AppReference.deviceWidth(context) * 0.45,
                              height: AppReference.deviceHeight(context) * 0.42,
                              child: Column(
                                children: [
                                  ChallengeItemBuilder(
                                    three: _three,
                                    five: _five,
                                    routeName: AppReference.childIsPrimary()
                                        ? AppRoutesNames
                                            .rPrimaryChildChallengeScreen
                                        : AppRoutesNames.rChildChallengeScreen,
                                    isPrimary: AppReference.childIsPrimary(),
                                  ).animateRightLeft(
                                      duration: const Duration(seconds: 2)),
                                  AppSize.s16.sizedBoxHeight,
                                  if (!BlocProvider.of<GlobalBloc>(context)
                                      .state
                                      .appVersionModel
                                      .inReview2)
                                    CustomInkWell(
                                      onTap: () {

                                        _goToMySkillsScreen();
                                      },
                                      child: Container(
                                        width:
                                            AppReference.deviceWidth(context),
                                        height: AppReference.deviceIsTablet
                                            ? AppReference.deviceHeight(
                                                    context) *
                                                0.07.responsiveHeightRatio
                                            : AppReference.deviceHeight(
                                                    context) *
                                                0.12.responsiveHeightRatio,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppConstants.appBorderRadiusR15
                                                  .responsiveSize),
                                          gradient: const LinearGradient(
                                            begin:
                                                AlignmentDirectional.topStart,
                                            end: AlignmentDirectional
                                                .bottomCenter,
                                            colors: [
                                              Color(0xFFFFD7AB),
                                              Color(0xFFFAF1E7),
                                            ], // Replace with your desired colors
                                          ),
                                        ),
                                        child: LayoutBuilder(
                                            builder: (context, constrains) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    constrains.maxWidth * 0.21,
                                                child: SvgPicture.asset(
                                                  AppImagesAssets.sNafes,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constrains.maxWidth * 0.02,
                                              ),
                                              SizedBox(
                                                width:
                                                    constrains.maxWidth * 0.65,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        AppStrings.skills,
                                                        style: const AppTextStyle()
                                                            .s14
                                                            .w600
                                                            .titleMedium20
                                                            .copyWith(
                                                                color: const Color(
                                                                    0xffB55F05)),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        AppStrings
                                                            .skillsDescription,
                                                        style: const AppTextStyle()
                                                            .s10
                                                            .w400
                                                            .titleMedium20
                                                            .copyWith(
                                                                color: const Color(
                                                                    0xffB55F05)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constrains.maxWidth * 0.07,
                                                child: const Icon(
                                                  Icons.arrow_forward,
                                                  color: Color(0xff1B3D6F),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HomeSizedBox(),
                      SliverToBoxAdapter(
                        child: Showcase(
                          key: _four,
                          tooltipPosition: TooltipPosition.top,
                          tooltipPadding:
                              EdgeInsets.all(AppPadding.p10.responsiveSize),
                          description: AppStrings.showCaseFour,
                          child: const TextWithImageWidget(
                            label: AppStrings.childSubjects,
                            imagePath: AppImagesAssets.sBook,
                          ).animateBottomToTop(
                              duration: AppConstants.animationTime),
                        ),
                      ),
                      const HomeSizedBox(),
                      if (!AppReference.childIsPrimary())
                        SliverToBoxAdapter(
                          child: ChildSubjectsBuilder(
                            userData:
                                getIt<UserLocalDataSource>().getUserData()!,
                          ).animateBottomToTop(
                              duration: AppConstants.animationTime),
                        ),
                      const HomeSizedBox(),
                      if (AppReference.childIsPrimary())
                        const SliverToBoxAdapter(
                          child: PrimaryChildSubjectsBuilder(),
                        ),
                    ],
                  ).paddingBody()),
            ),
          );
        }
      },
    );
  }

  void _goToMySkillsScreen() {
    if (!AppReference.userIsGuest()) {
      RouteManager.rPushNamedAndRemoveUntil(
        context: context,
        rName: AppRoutesNames.rFailsSkillsScreen,
        arguments: GetFailsSkillsWithQuestionsParameters(
          subjectId:
          context.read<SharedSubjectsBloc>().state.subjects.first.subjectId,
          subjects: context.read<SharedSubjectsBloc>().state.subjects,
          childId: getIt<UserLocalDataSource>().getUserData()!.userId,
          fromStatic: false
        ),
      );
    } else {
      AppReference.guestDialogMustLogin(context);
    }
  }

  void _showClassroomsDialog() {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return const _MoveBetweenClassroomsDialog();
        });
  }
}

class HomeSizedBox extends StatelessWidget {
  const HomeSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: AppSize.s16.sizedBoxHeight);
  }
}

class _AllChildPortraitView extends StatelessWidget {
  final GlobalKey one;
  final GlobalKey two;
  final GlobalKey three;
  final GlobalKey four;
  final GlobalKey five;
  final Function() showClassroomsDialog;
  final Function() goToMySkillsScreen;

  const _AllChildPortraitView({
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.showClassroomsDialog,
    required this.goToMySkillsScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: HomeHeaderForAllChild(),
        ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: CustomInkWell(
            onTap: () {
              showClassroomsDialog();
            },
            child: Container(
              height: AppReference.deviceHeight(context) *
                  0.05.responsiveHeightRatio,
              alignment: AlignmentDirectional.centerStart,
              padding: EdgeInsets.symmetric(
                  horizontal: 15.responsiveWidth, vertical: 5.responsiveHeight),
              decoration: BoxDecoration(
                color: AppColors.primaryColor2,
                borderRadius: BorderRadius.circular(
                    AppConstants.appBorderRadiusR15.responsiveSize),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIconsAssets.sDropDownMenu),
                  AppSize.s6.sizedBoxWidth,
                  Text(
                    getIt<UserLocalDataSource>().getUserData()!.classroomName ??
                        '',
                    style: const AppTextStyle().bodyLarge16.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                  AppSize.s6.sizedBoxWidth,
                  SvgPicture.asset(AppIconsAssets.sArrowDown),
                ],
              ),
            ),
          ),
        ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: PuzzleBuilder(
            one: one,
            puzzleImagePath: AppImagesAssets.sChildPuzzle,
          ),
        ),
        // SliverToBoxAdapter(
        //   child:                       Text('2𝑦−1≤|𝑥+4| ∅  (5−3𝑖)^3=?  𝟑/𝟒   𝟓𝒙^𝟐+𝟑𝟎𝟎=   𝑚∠1+𝑚∠2=180 ∼𝑝∨∼𝑞, ∼𝑝∧𝑞  (−4)/(−2)   ∼𝑝∧𝑞 , ∼(𝑝∧𝑞)  𝑦+5=(−7)/3 𝑥+7/3' ),
        //
        // ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: const TextWithImageWidget(
            label: AppStrings.adviceOfDay,
            imagePath: AppImagesAssets.sAdvice,
          ).animateRightLeft(duration: const Duration(seconds: 2)),
        ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: AdviceItemBuilder(two: two)
              .animateRightLeft(duration: AppConstants.animationTime),
        ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: ChallengeItemBuilder(
            three: three,
            five: five,
            routeName: AppReference.childIsPrimary()
                ? AppRoutesNames.rPrimaryChildChallengeScreen
                : AppRoutesNames.rChildChallengeScreen,
            isPrimary: AppReference.childIsPrimary(),
          ).animateRightLeft(duration: const Duration(seconds: 2)),
        ),
        const HomeSizedBox(),
        if (!BlocProvider.of<GlobalBloc>(context)
            .state
            .appVersionModel
            .inReview2)
          SliverToBoxAdapter(
            child: CustomInkWell(
              onTap: () {
                goToMySkillsScreen();
              },
              child: Container(
                width: AppReference.deviceWidth(context),
                height: AppReference.deviceHeight(context) *
                    0.12.responsiveHeightRatio,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadiusR15.responsiveSize),
                  gradient: AppGradientColors.skillsGradient,
                ),
                child: LayoutBuilder(builder: (context, constrains) {
                  return Row(
                    children: [
                      SizedBox(
                        width: constrains.maxWidth * 0.21,
                        child: SvgPicture.asset(
                          AppImagesAssets.sNafes,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        width: constrains.maxWidth * 0.02,
                      ),
                      SizedBox(
                        width: constrains.maxWidth * 0.65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                !AppReference.childIsPrimary()? "الفاقد التعليمي" : AppStrings.skills,
                                style: const AppTextStyle()
                                    .s14
                                    .w600
                                    .titleMedium20
                                    .copyWith(color: const Color(0xffB55F05)),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                !AppReference.childIsPrimary()?'تابع نمو مهاراتك خطوة بخطوة': AppStrings.skillsDescription,
                                style: const AppTextStyle()
                                    .s10
                                    .w400
                                    .titleMedium20
                                    .copyWith(color: const Color(0xffB55F05)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: constrains.maxWidth * 0.07,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColors.secondaryColor4,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: Showcase(
            key: four,
            tooltipPosition: TooltipPosition.top,
            tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
            description: AppStrings.showCaseFour,
            child: const TextWithImageWidget(
              label: AppStrings.childSubjects,
              imagePath: AppImagesAssets.sBook,
            ).animateBottomToTop(duration: AppConstants.animationTime),
          ),
        ),
        const HomeSizedBox(),
        if (!AppReference.childIsPrimary())
          SliverToBoxAdapter(
            child: ChildSubjectsBuilder(
              userData: getIt<UserLocalDataSource>().getUserData()!,
            ).animateBottomToTop(duration: AppConstants.animationTime),
          ),
        const HomeSizedBox(),
        if (AppReference.childIsPrimary())
          const SliverToBoxAdapter(child: PrimaryChildSubjectsBuilder()),
        const HomeSizedBox(),
      ],
    ).paddingBody();
  }
}
