part of '../../nafees_plans.dart';

class NafeeseExamsScreen extends StatelessWidget {
  final NafeesSubjectData nafeesSubjectData;

  const NafeeseExamsScreen({
    super.key, required this.nafeesSubjectData,
  });

  @override
  Widget build(BuildContext context) {
    print("gfjkgkdfg${nafeesSubjectData.childId}");
    print("gfjkgkdfg${nafeesSubjectData.nafeesPlans.id}");

    return BlocProvider(
      create: (context) =>  getIt<NafeesBloc>()..add(
          GetNafeesExamsEvent(
              nafeesExamQuestionsAnswersInputs: NafeesExamQuestionsAnswersInputs(examId: nafeesSubjectData.nafeesPlans.examsData[nafeesSubjectData.index!].id, childId: nafeesSubjectData.childId))),
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
              child:  _ExamsScreenForNafess(nafeesSubjectData: nafeesSubjectData,),
            )),
      ),
    );
  }
}

class _ExamsScreenForNafess extends StatelessWidget {
  final NafeesSubjectData nafeesSubjectData;
  const _ExamsScreenForNafess({
    required this.nafeesSubjectData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         HeaderForMore(
          title: nafeesSubjectData.nafeesPlans.name,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: BlocBuilder<NafeesBloc, NafeesState>(
              builder: (context, state) {
                switch (state.getNafeesExamsState) {
                  case RequestStates.loading:
                    return const LoadingShimmerList();
                  case RequestStates.loaded:
                    return Column(
                      children: [
                        CustomInkWell(
                          onTap: () {
                            showDialog(context: context,
                                builder: (dialogContext)=> NafeesTimeDialog(
                                  onPressedNo: (){
                                  RouteManager.rPushReplacementNamed(
                                    context: context,
                                    rName: AppRoutesNames.rNafeesQuestionScreen,
                                    arguments:NafeesSubjectData(
                                      nafeesPlans: nafeesSubjectData.nafeesPlans,
                                      childId: nafeesSubjectData.childId,
                                      index: nafeesSubjectData.index,
                                      nafeesQuestionEntity:state.nafeesExam.nafeesQuestionEntity,
                                      duration:state.nafeesExam.duration,
                                      piece:state.nafeesExam.piece,
                                      playDuration: false
                                    )
                                  );
                                },onPressedYes: (){
                                  RouteManager.rPushReplacementNamed(
                                    context: context,
                                    rName: AppRoutesNames.rNafeesQuestionScreen,
                                    arguments:NafeesSubjectData(
                                      nafeesPlans: nafeesSubjectData.nafeesPlans,
                                      childId: nafeesSubjectData.childId,
                                      index: nafeesSubjectData.index,
                                      nafeesQuestionEntity:state.nafeesExam.nafeesQuestionEntity,
                                      duration:state.nafeesExam.duration,
                                      piece:state.nafeesExam.piece,
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
                            portraitWidget: _NafeesExamsPortraitView(nafeesFullExamEntity: state.nafeesExam,),
                            landscapeWidget: _NafeesExamsLandscapeView(nafeesFullExamEntity: state.nafeesExam,))
                      ],
                    );
                  case RequestStates.error:
                    return CustomErrorWidget(
                        errorMessage: state.getNafeesExamsMessage);

                  default:
                    return const SizedBox();
                }
              },
            ).paddingBody(),
          ),
        )
        // nafees header
      ],
    );
  }
}

class _NafeesExamsPortraitView extends StatelessWidget {
  final NafeesFullExamEntity nafeesFullExamEntity;
  const _NafeesExamsPortraitView({
   required this.nafeesFullExamEntity,
  });

  @override
  Widget build(BuildContext context) {
    return nafeesFullExamEntity.nafeesExamResults.isEmpty ? const EmptyListWidgets(message: "لم تقم بحل اختبارات حتى الأن") : ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  _NafeesExamsWidget(
          name: nafeesFullExamEntity.name,
          totalQuestions: nafeesFullExamEntity.questionsCount,
          nafeesExamResults: nafeesFullExamEntity.nafeesExamResults[index],
        );
      },
      separatorBuilder: (context, index) => 5.sizedBoxHeight,
      itemCount: nafeesFullExamEntity.nafeesExamResults.length,
    );
  }
}

class _NafeesExamsWidget extends StatelessWidget {
  final NafeesExamResults nafeesExamResults;
  final int totalQuestions;
  final String name;
  const _NafeesExamsWidget({
    super.key, required this.nafeesExamResults, required this.totalQuestions, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
        onTap: AppReference.userIsChild() ? () {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rNafeesAnswerBuildScreen,
            arguments: nafeesExamResults
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
                        "الدرجة ${nafeesExamResults.trueAnswersCount} من $totalQuestions",
                        style: AppReference.themeData.textTheme.bodyMedium!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor3,
                        ),
                      ),
                      Text(
                        nafeesExamResults.date.toString().substring(0, 10),
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

class _NafeesExamsLandscapeView extends StatelessWidget {
  final NafeesFullExamEntity nafeesFullExamEntity;
  const _NafeesExamsLandscapeView({
    super.key, required this.nafeesFullExamEntity,
  });

  @override
  Widget build(BuildContext context) {
    return nafeesFullExamEntity.nafeesExamResults.isEmpty ? const EmptyListWidgets(message: "لم تقم بحل اختبارات حتى الأن") :GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppConstants.appPaddingR20,
        crossAxisSpacing: AppConstants.appPaddingR20,
        childAspectRatio: 5 / 2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _NafeesExamsWidget(
          name: nafeesFullExamEntity.name,
          totalQuestions: nafeesFullExamEntity.questionsCount,
          nafeesExamResults: nafeesFullExamEntity.nafeesExamResults[index],
        );
      },
      itemCount: nafeesFullExamEntity.nafeesExamResults.length,
    );
  }
}
