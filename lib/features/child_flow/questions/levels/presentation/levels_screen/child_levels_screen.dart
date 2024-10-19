part of '../../levels.dart';

class ChildLevelsScreen extends StatelessWidget {
  final DataToGoQuestions data;

  const ChildLevelsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LevelsBloc>()
        ..add(GetAllLevels(
          ParameterGoToQuestions(
            subjectId: data.subjectId,
            stageId: data.stageId,
            classRoomId: data.classRoomId,
            termId: data.termId,
            systemId: data.systemId,
            pathId: data.pathId,
          ),
        )),
      child: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rLessonScreen,
              arguments: data);
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderForTermsAndLevelsAndGroup(backTo: () {
                  RouteManager.rPushNamedAndRemoveUntil(
                      context: context,
                      rName: AppRoutesNames.rLessonScreen,
                      arguments: data);
                }),
                AppSize.s26.sizedBoxHeight,
                BaseContainerHaveTextAndImage(
                  title: data.subjectName,
                  notHaveImage: data.notHaveImage,
                  description: AppStrings.generalQuestions,
                  imageUrl: data.imgUrl,
                  width: AppReference.deviceWidth(context),
                  height: AppReference.deviceHeight(context) *
                      0.11.responsiveHeightRatio,
                ).animateSlideTopToNormal(duration: AppConstants.animationTime),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      AppSize.s20.sizedBoxHeight,
                      SizedBox(
                        height: AppReference.deviceHeight(context) *
                            0.09.responsiveHeightRatio,
                        width: AppReference.deviceWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                AppStrings.myLevels,
                                style: AppReference
                                    .themeData.textTheme.titleMedium,
                              ),
                            ),
                            const Expanded(
                              child: CurrentLevelBuilder(),
                            ),
                          ],
                        ),
                      ),
                      AppSize.s30.sizedBoxHeight,
                      ChildLevelBuilder(data: data),
                    ],
                  )),
                )
              ],
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}

class ChildLevelBuilder extends StatelessWidget {
  final DataToGoQuestions data;

  const ChildLevelBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelsBloc, LevelsState>(
      builder: (context, state) {
        switch (state.levelsStates) {
          case RequestStates.loading:
            return const Expanded(child: LoadingShimmerList());
          case RequestStates.loaded:
            if (state.levels.isEmpty) {
              return const EmptyListWidgets(message: AppStrings.noLevelsNow);
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LockWidgets(
                    lockWidget: ChildLevelItem(
                        level: state.levels[index],
                        onTap: () {
                          final data = this.data.copyWith(
                              levelId: state.levels[index].id,
                              levelName: state.levels[index].name,
                              levelColor: state.levels[index].itemColor);

                          RouteManager.rPushNamed(
                            context: context,
                            rName: AppRoutesNames.rChildCollectionsScreen,
                            arguments: data,
                          );
                        },
                        index: index),
                    isLocked: QuestionSharedFunction.checkIsLock(
                      index: index,
                      userQuestionPoints: index == 0
                          ? state.levels[index].userPoints
                          : state.levels[index - 1].userPoints,
                      skipQuestionPoints: index == 0
                          ? state.levels[index].skipPoints
                          : state.levels[index - 1].skipPoints,
                    ),
                    textLock: AppStrings.skipPreviousLevel,
                  ).animateRightLeft(
                      duration: AppConstants.animationTime,
                      isFromStart: false);
                },
                separatorBuilder: (context, index) =>
                    AppSize.s16.sizedBoxHeight,
                itemCount: state.levels.length,
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.levelsErrorMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class ChildLevelItem extends StatelessWidget {
  final LevelAndCollectionEntity level;
  final Function() onTap;
  final int index;

  const ChildLevelItem({
    super.key,
    required this.level,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        height: AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.p10.responsiveSize,
            horizontal: AppPadding.p20.responsiveSize),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(AppConstants.appPaddingR20.responsiveSize),
          color: HexColor.fromHex(level.itemColor.isEmpty
              ? AppConstants.primaryColorHexCode
              : level.itemColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              level.name,
              style: const AppTextStyle().s15.titleSmall18,
            ),
            if (QuestionSharedFunction.checkIsFirstItem(
                  index: index,
                ) ||
                QuestionSharedFunction.isCompleted(
                  userQuestionPoints: level.userPoints,
                  skipQuestionPoints: level.skipPoints,
                ))
              Text(
                AppStrings.startNow,
                style: AppTextStyle.bodySmall12,
              ),
          ],
        ),
      ),
    );
  }
}
