part of '../../simulated_plans.dart';

class SimulatedExamsScreen extends StatelessWidget {
  final SimulatedSubjectData simulatedSubjectData;

  const SimulatedExamsScreen({
    super.key, required this.simulatedSubjectData,
  });

  @override
  Widget build(BuildContext context) {
    print("gfjkgkdfg${simulatedSubjectData.childId}");
    print("gfjkgkdfg${simulatedSubjectData.simulatedPlans.id}");

    return BlocProvider(
      create: (context) =>  getIt<SimulatedBloc>()..add(
          GetSimulatedExamsEvent(
              simulatedExamQuestionsAnswersInputs: SimulatedExamQuestionsAnswersInputs(examId: simulatedSubjectData.simulatedPlans.examsData[simulatedSubjectData.index!].id, childId: simulatedSubjectData.childId))),
      child: Scaffold(
        body: SafeArea(
            child: Container(
              height: AppReference.deviceHeight(context),
              width: AppReference.deviceWidth(context),
              decoration: BoxDecoration(
                  image: AppReference.childIsPrimary()
                      ? const DecorationImage(
                    image: AssetImage(AppImagesAssets.sPrimaryChildBackground),
                    fit: BoxFit.fill,
                  )
                      : null),
              child:  _ExamsScreenForNafess(simulatedSubjectData: simulatedSubjectData,),
            )),
      ),
    );
  }
}

class _ExamsScreenForNafess extends StatelessWidget {
  final SimulatedSubjectData simulatedSubjectData;
  const _ExamsScreenForNafess({
    required this.simulatedSubjectData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         HeaderForMore(
          title: simulatedSubjectData.simulatedPlans.name,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: BlocBuilder<SimulatedBloc, SimulatedState>(
              builder: (context, state) {
                switch (state.getSimulatedExamsState) {
                  case RequestStates.loading:
                    return const LoadingShimmerList();
                  case RequestStates.loaded:
                    return Column(
                      children: [
                        CustomInkWell(
                          onTap: () {
                            showDialog(context: context,
                                builder: (dialogContext)=> SimulatedTimeDialog(
                                  onPressedNo: (){
                                  RouteManager.rPushReplacementNamed(
                                    context: context,
                                    rName: AppRoutesNames.rSimulatedQuestionScreen,
                                    arguments:SimulatedSubjectData(
                                      simulatedPlans: simulatedSubjectData.simulatedPlans,
                                      childId: simulatedSubjectData.childId,
                                      index: simulatedSubjectData.index,
                                      simulatedQuestionEntity:state.simulatedExam.simulatedQuestionEntity,
                                      duration:state.simulatedExam.duration,
                                      piece:state.simulatedExam.piece,
                                      playDuration: false
                                    )
                                  );
                                },onPressedYes: (){
                                  RouteManager.rPushReplacementNamed(
                                    context: context,
                                    rName: AppRoutesNames.rSimulatedQuestionScreen,
                                    arguments:SimulatedSubjectData(
                                      simulatedPlans: simulatedSubjectData.simulatedPlans,
                                      childId: simulatedSubjectData.childId,
                                      index: simulatedSubjectData.index,
                                      simulatedQuestionEntity:state.simulatedExam.simulatedQuestionEntity,
                                      duration:state.simulatedExam.duration,
                                      piece:state.simulatedExam.piece,
                                      playDuration: true,
                                    )
                                  );
                                },));

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.s20.responsiveWidth),
                            width: AppReference.deviceWidth(context),
                            height: AppReference.deviceHeight(context) *
                                0.08.responsiveHeightRatio,
                            decoration: BoxDecoration(
                              color: AppColors.primary3,
                              borderRadius: BorderRadius.circular(
                                  AppConstants.appBorderRadiusR25.responsiveSize),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIconsAssets.sExam4,
                                ),
                                AppSize.s10.sizedBoxWidth,
                                Text(
                                  "الاختبار",
                                  style: const AppTextStyle()
                                      .s14
                                      .w500
                                      .titleMedium20
                                      .copyWith(
                                    color: AppColors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "ابدأ الأن !",
                                      style: const AppTextStyle()
                                          .s10
                                          .w600
                                          .titleMedium20
                                          .copyWith(
                                        color: AppColors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.white,
                                      size: AppSize.s16.responsiveSize,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppSize.s20.sizedBoxHeight,
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIconsAssets.sPreviousTime,
                              // width: 50.responsiveWidth,
                              height: AppReference.deviceHeight(context) *
                                  0.03.responsiveHeightRatio,
                            ),
                            AppSize.s10.sizedBoxWidth,
                            Flexible(
                              child: Text(
                                "نتائج سابقة",
                                style: AppTextStyle.titleSmall18,
                              ),
                            ),
                          ],
                        ),
                        AppSize.s20.sizedBoxHeight,
                         OrientationItem(
                            portraitWidget: _SimulatedExamsPortraitView(simulatedFullExamEntity: state.simulatedExam,),
                            landscapeWidget: _SimulatedExamsLandscapeView(simulatedFullExamEntity: state.simulatedExam,))
                      ],
                    );
                  case RequestStates.error:
                    return CustomErrorWidget(
                        errorMessage: state.getSimulatedExamsMessage);

                  default:
                    return const SizedBox();
                }
              },
            ).paddingBody(),
          ),
        )
        // simulated header
      ],
    );
  }
}

class _SimulatedExamsPortraitView extends StatelessWidget {
  final SimulatedFullExamEntity simulatedFullExamEntity;
  const _SimulatedExamsPortraitView({
   required this.simulatedFullExamEntity,
  });

  @override
  Widget build(BuildContext context) {
    return simulatedFullExamEntity.simulatedExamResults.isEmpty ? const EmptyListWidgets(message: "لم تقم بحل اختبارات حتى الأن") : ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  _SimulatedExamsWidget(
          name: simulatedFullExamEntity.name,
          totalQuestions: simulatedFullExamEntity.questionsCount,
          simulatedExamResults: simulatedFullExamEntity.simulatedExamResults[index],
        );
      },
      separatorBuilder: (context, index) => 5.sizedBoxHeight,
      itemCount: simulatedFullExamEntity.simulatedExamResults.length,
    );
  }
}

class _SimulatedExamsWidget extends StatelessWidget {
  final SimulatedExamResults simulatedExamResults;
  final int totalQuestions;
  final String name;
  const _SimulatedExamsWidget({
    super.key, required this.simulatedExamResults, required this.totalQuestions, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
        onTap: AppReference.userIsChild() ? () {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rSimulatedAnswerBuildScreen,
            arguments: simulatedExamResults
            );
        } : () {},
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: AppPadding.p10.responsiveSize,
          ),
          padding: EdgeInsets.all(
            AppPadding.p10.responsiveSize,
          ),
          width: AppReference.deviceIsTablet
              ? AppReference.deviceWidth(context) * 0.4
              : AppReference.deviceWidth(context) * 0.8,
          height: AppReference.deviceHeight(context) *
              0.14.responsiveHeightRatio,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
                AppConstants.appBorderRadiusR20.responsiveSize),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppReference.themeData.textTheme.titleSmall!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        //"الدرجة ${state.randomExams[index].degree} من ${state.randomExams[index].questionsNumber}",
                        "الدرجة ${simulatedExamResults.trueAnswersCount} من $totalQuestions",
                        style: AppReference.themeData.textTheme.bodyMedium!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor3,
                        ),
                      ),
                      Text(
                        simulatedExamResults.date.toString().substring(0, 10),
                        style: AppReference.themeData.textTheme.bodyMedium!
                            .copyWith(
                          color: AppColors.textColor3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.15,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.white,
                    size: 30.responsiveSize,
                  ),
                ),
              ],
            );
          }),
        )).animateRightLeft();
  }
}

class _SimulatedExamsLandscapeView extends StatelessWidget {
  final SimulatedFullExamEntity simulatedFullExamEntity;
  const _SimulatedExamsLandscapeView({
    super.key, required this.simulatedFullExamEntity,
  });

  @override
  Widget build(BuildContext context) {
    return simulatedFullExamEntity.simulatedExamResults.isEmpty ? const EmptyListWidgets(message: "لم تقم بحل اختبارات حتى الأن") :GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppConstants.appPaddingR20,
        crossAxisSpacing: AppConstants.appPaddingR20,
        childAspectRatio: 5 / 2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _SimulatedExamsWidget(
          name: simulatedFullExamEntity.name,
          totalQuestions: simulatedFullExamEntity.questionsCount,
          simulatedExamResults: simulatedFullExamEntity.simulatedExamResults[index],
        );
      },
      itemCount: simulatedFullExamEntity.simulatedExamResults.length,
    );
  }
}
