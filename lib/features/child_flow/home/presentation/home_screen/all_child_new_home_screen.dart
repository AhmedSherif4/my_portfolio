part of '../../home.dart';

class AllChildNewHomeScreen extends StatefulWidget {
  const AllChildNewHomeScreen({super.key});

  @override
  State<AllChildNewHomeScreen> createState() => _AllChildNewHomeScreenState();
}

class _AllChildNewHomeScreenState extends State<AllChildNewHomeScreen> {
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
              mobile: _AllChildNewPortraitView(
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


class _AllChildNewPortraitView extends StatelessWidget {
  final GlobalKey one;
  final GlobalKey two;
  final GlobalKey three;
  final GlobalKey four;
  final GlobalKey five;
  final Function() showClassroomsDialog;
  final Function() goToMySkillsScreen;

  const _AllChildNewPortraitView({
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
                color: AppColors.textColor6,
                borderRadius: BorderRadius.circular(
                    AppConstants.appBorderRadiusR15.responsiveSize),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIconsAssets.sDropDownMenu,color: AppColors.primaryColor,),
                  AppSize.s6.sizedBoxWidth,
                  Text(
                    getIt<UserLocalDataSource>().getUserData()!.classroomName ??
                        '',
                    style: const AppTextStyle().bodyLarge16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                  ),
                  AppSize.s6.sizedBoxWidth,
                  SvgPicture.asset(AppIconsAssets.sArrowDown,color: AppColors.primaryColor,),
                ],
              ),
            ).paddingBody(top: 0,bottom: 0),
          ),
        ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: PuzzleNewBuilder(
                  one: one,
                  puzzleImagePath: AppImagesAssets.sChildPuzzle,
                ),
              ),
              AppSize.s10.sizedBoxWidth,
              Expanded(
                flex: 5,
                child:AdviceNewItemBuilder(
                  two: two,
                ),
              ),
            ],
          ),
        ),
        const HomeSizedBox(),
        SliverToBoxAdapter(
          child: ChallengeNewItemBuilder(
            three: three,
            five: five,
            routeName: AppReference.childIsPrimary()
                ? AppRoutesNames.rPrimaryChildChallengeScreen
                : AppRoutesNames.rChildChallengeScreen,
            isPrimary: AppReference.childIsPrimary(),
          ).paddingBody(top: 0,bottom: 0).animateRightLeft(duration: const Duration(seconds: 2)),
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
            ).paddingBody(top: 0,bottom: 0),
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
            ).paddingBody(top: 0,bottom: 0).animateBottomToTop(duration: AppConstants.animationTime),
          ),
        ),
        const HomeSizedBox(),
        if (!AppReference.childIsPrimary())
          SliverToBoxAdapter(
            child: ChildSubjectsBuilder(
              userData: getIt<UserLocalDataSource>().getUserData()!,
            ).paddingBody(top: 0,bottom: 0).animateBottomToTop(duration: AppConstants.animationTime),
          ),
        const HomeSizedBox(),
        if (AppReference.childIsPrimary())
           SliverToBoxAdapter(child: const PrimaryChildSubjectsBuilder().paddingBody(top: 0,bottom: 0)),
        const HomeSizedBox(),
      ],
    ).paddingBody();
  }
}

class PuzzleNewBuilder extends StatelessWidget {
  final GlobalKey one;
  final String puzzleImagePath;

  const PuzzleNewBuilder(
      {super.key, required this.one, required this.puzzleImagePath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.getPuzzleAndAdviceState) {
          case RequestStates.loading:
            return LoadingShimmerStructure(
              height: 100.responsiveHeight,
            );
          case RequestStates.loaded:
            return Showcase(
              key: one,
              tooltipPosition: TooltipPosition.bottom,
              tooltipPadding: EdgeInsets.all(10.responsiveSize),
              targetPadding: EdgeInsets.all(15.responsiveSize),
              description:
              AppStrings.showCaseOne,
              disableDefaultTargetGestures: true,
              child: PuzzleNewWidget(
                puzzle: state.puzzleAndAdviceEntity.content,
                puzzleImagePath: puzzleImagePath,
                answer1: state.puzzleAndAdviceEntity.select1 ?? '',
                answer2: state.puzzleAndAdviceEntity.select2 ?? '',
                answer3: state.puzzleAndAdviceEntity.select3 ?? '',
                answer4: state.puzzleAndAdviceEntity.select4 ?? '',
                correctAnswer: state.puzzleAndAdviceEntity.correctSelect ?? '',
              ),
            );
          case RequestStates.error:
            return CustomErrorWidget(
                errorMessage: state.puzzleAndAdviceMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class PuzzleNewWidget extends StatelessWidget {
  final String puzzle;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;
  final String puzzleImagePath;

  const PuzzleNewWidget({
    super.key,
    required this.puzzle,
    required this.puzzleImagePath,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => PuzzleDialog(
            message: puzzle,
            answer1: answer1,
            answer2: answer2,
            answer3: answer3,
            answer4: answer4,
            correctAnswer: correctAnswer,
          ),
        );
      },
      child: Container(
        height: (AppReference.deviceIsTablet&&!AppReference.isPortrait(context))?AppReference.deviceHeight(context)*0.25:AppReference.deviceHeight(context) * 0.15.responsiveHeightRatio,
        alignment: AlignmentDirectional.topStart,
        padding: EdgeInsets.all(AppPadding.p14.responsiveSize),
        margin: EdgeInsets.only(right: AppPadding.p10.responsiveSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 15,
              color: AppColors.black.withOpacity(0.15),
            )
          ],
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constrains.maxWidth,
                child: LayoutBuilder(builder: (context, consColumn) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: consColumn.maxHeight * 0.25,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.puzzleDay,
                              style:const AppTextStyle().w600.bodyMedium14,

                            ),
                            AppSize.s10.sizedBoxWidth,
                            SvgPicture.asset(AppImagesAssets.sPrimaryPuzzle,
                            width: 20.responsiveSize,
                            )
                          ],
                        ),
                      ),
                      (consColumn.maxHeight * 0.1).sizedBoxHeight,
                      SizedBox(
                        width: consColumn.maxWidth,
                        height: consColumn.maxHeight * 0.35,
                        child: Align(
                          alignment: AppReference.deviceIsTablet?AlignmentDirectional.center:AlignmentDirectional.topStart,
                          child: Text(
                            puzzle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:const AppTextStyle().w600.bodySmall12,
                          ),
                        ),
                      ),
                      (consColumn.maxHeight * 0.1).sizedBoxHeight,
                      SizedBox(
                        width: consColumn.maxWidth,
                        height: consColumn.maxHeight * 0.15,
                        child: Row(
                          children: [
                            Text(
                              "المزيد",
                              overflow: TextOverflow.ellipsis,
                              style:const AppTextStyle().w600.bodySmall12,
                            ),
                            AppSize.s4.sizedBoxWidth,
                            Icon(Icons.arrow_forward_rounded, size: 12.responsiveSize, color: AppColors.black,),
                          ],
                        ),
                      ),

                    ],
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }

}

class AdviceNewItemBuilder extends StatelessWidget {
  final GlobalKey two;

  const AdviceNewItemBuilder({super.key, required this.two});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.getPuzzleAndAdviceState) {
          case RequestStates.loading:
            return LoadingShimmerStructure(
              height: 20.responsiveHeight,
            );
          case RequestStates.loaded:
            return Showcase(
              key: two,
              tooltipPosition: TooltipPosition.bottom,
              tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
              description: AppStrings.adviceHint,
              disableDefaultTargetGestures: true,
              child: CustomInkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AdviceDialog(
                        message: state.puzzleAndAdviceEntity.advice,
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: AppPadding.p10.responsiveSize),
                    height: (AppReference.deviceIsTablet&&!AppReference.isPortrait(context))?AppReference.deviceHeight(context)*0.25:AppReference.deviceHeight(context) * 0.15.responsiveHeightRatio,
                    alignment: AlignmentDirectional.topStart,
                    padding: EdgeInsets.all(AppPadding.p14.responsiveSize),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR20.responsiveSize),
                      color: AppColors.textColor6,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                          blurRadius: 15,
                          color: AppColors.black.withOpacity(0.15),
                        )
                      ],
                    ),
                    child: LayoutBuilder(builder: (context, constrains) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: constrains.maxWidth,
                            child: LayoutBuilder(builder: (context, consColumn) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: consColumn.maxHeight * 0.25,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppStrings.adviceOfDay,
                                          style:const AppTextStyle().w600.bodyMedium14,
                                        ),
                                        AppSize.s10.sizedBoxWidth,
                                        SvgPicture.asset(AppImagesAssets.sAdvice)
                                      ],
                                    ),
                                  ),
                                  (consColumn.maxHeight * 0.1).sizedBoxHeight,
                                  SizedBox(
                                    width: consColumn.maxWidth,
                                    height: consColumn.maxHeight * 0.35,
                                    child: Align(
                                      alignment: AppReference.deviceIsTablet?AlignmentDirectional.center:AlignmentDirectional.topStart,
                                      child: Text(
                                        state.puzzleAndAdviceEntity.advice,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style:const AppTextStyle().w600.bodySmall12,
                                      ),
                                    ),
                                  ),
                                  (consColumn.maxHeight * 0.1).sizedBoxHeight,
                                  SizedBox(
                                    width: consColumn.maxWidth,
                                    height: consColumn.maxHeight * 0.15,
                                    child: Row(
                                      children: [
                                        Text(
                                          "المزيد",
                                          overflow: TextOverflow.ellipsis,
                                          style:const AppTextStyle().w600.bodySmall12,
                                        ),
                                        AppSize.s4.sizedBoxWidth,
                                        Icon(Icons.arrow_forward_rounded, size: 12.responsiveSize, color: AppColors.black,),
                                      ],
                                    ),
                                  ),

                                ],
                              );
                            }),
                          ),
                        ],
                      );
                    }),
                  )



              ),
            );
          case RequestStates.error:
            return CustomErrorWidget(
                errorMessage: state.puzzleAndAdviceMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}


class ChallengeNewWidget extends StatelessWidget {
  final Function() onTap;
  final Color borderColor;
  final Color itemColor;
  final String imagePath;
  final String title;
  final String body;

  const ChallengeNewWidget(
      {super.key,
        required this.onTap,
        required this.borderColor,
        required this.itemColor,
        required this.imagePath,
        required this.title,
        required this.body});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width: AppReference.deviceWidth(context) * 0.5,
        height:  AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
        padding: EdgeInsets.all(AppPadding.p8.responsiveSize),
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR15.responsiveSize),
          border: Border.symmetric(
            horizontal:
            BorderSide(color: borderColor, width: 3.responsiveWidth),
            vertical:
            BorderSide(color: borderColor, width: 1.5.responsiveWidth),
          ),
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return  LayoutBuilder(builder: (context, consRow) {
            return Row(
              children: [
                SizedBox(
                  width: consRow.maxWidth * 0.2,
                  child: SvgPicture.asset(
                    imagePath,
                    alignment: Alignment.center,
                    height: constrains.maxHeight * 0.4,
                    fit: BoxFit.contain,
                  ),
                ),
                (consRow.maxWidth * 0.02).sizedBoxWidth,

                SizedBox(
                  width: consRow.maxWidth * 0.5,
                  child: Text(
                    title,
                    style: const AppTextStyle().white.w700.bodyMedium14
                  ),
                ),
                SizedBox(
                  width: consRow.maxWidth * 0.2,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 16.responsiveSize,
                    color: AppColors.white,
                  )
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}

class ChallengeNewItemBuilder extends StatelessWidget {
  final String routeName;
  final bool isPrimary;
  final GlobalKey three;
  final GlobalKey five;

  const ChallengeNewItemBuilder({
    super.key,
    required this.routeName,
    required this.isPrimary,
    required this.three,
    required this.five,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Showcase(
                key: three,
                tooltipPosition: TooltipPosition.bottom,
                tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
                description: AppStrings.haveExams,
                disableDefaultTargetGestures: true,
                child: ChallengeNewWidget(
                  borderColor: const Color(0x66eec43a).withOpacity(0.8),
                  itemColor: AppColors.primaryColor2,
                  title: AppStrings.challenges,
                  body: AppStrings.chanallegFreind,
                  imagePath: AppImagesAssets.sChallenge,
                  onTap: () {
                    RouteManager.rPushNamedAndRemoveUntil(
                      context: context,
                      rName: routeName,
                      arguments: DataToGoExams(
                        subjects: BlocProvider.of<SharedSubjectsBloc>(context)
                            .state
                            .subjects,
                        user: getIt<UserLocalDataSource>().getUserData()!,
                        isPrimary: isPrimary,
                        fromSubscription: false,
                      ),
                    );
                  },
                ),
              ),
            ),
            AppSize.s20.sizedBoxWidth,
            Expanded(
              child: Showcase(
                key: five,
                tooltipPosition: TooltipPosition.top,
                tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
                description: AppStrings.mySubscriptionShowCase,
                disableDefaultTargetGestures: true,
                child: ChallengeNewWidget(
                  borderColor: const Color(0xffE4CEFF),
                  itemColor: AppColors.secondaryColor,
                  title: AppStrings.mySubscriptions,
                  body: AppStrings.mySubscriptionsBody,
                  imagePath: AppImagesAssets.sSubscriptinoInHome,
                  onTap: () {
                    if (!AppReference.userIsGuest()) {
                      RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                          arguments: DataToGoRandomExams(
                              isRandomExam: false,
                              user: getIt<UserLocalDataSource>().getUserData()!,
                              isPrimary: isPrimary)
                      );
                    } else {
                      AppReference.guestDialogMustLogin(context);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}