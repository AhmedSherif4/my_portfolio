part of'../../random_exams.dart';


class PrimaryChildRandomExamsScreen extends StatelessWidget {
  final DataToGoExams dataToGoExams;

  const PrimaryChildRandomExamsScreen({
    super.key,
    required this.dataToGoExams,
  });

  @override
  Widget build(BuildContext context) {
    dataToGoExams.user.userId.log();
    return PopScope(
      canPop: false,
      onPopInvoked:(value)  {
        if(!value){
          if(!AppReference.userIsChild()){
   _backToParentChallengeScreen(context);
      return;
    }else{
    _backToPrimaryChildChallengeScreen(context);
   }}
    },
      child: Scaffold(
        floatingActionButton:
        dataToGoExams.subjects.isNotEmpty && AppReference.userIsChild()
            ? AddNewRandomExamFloatingButton(
          dataToGoExams: dataToGoExams,
        )
            : null,
        body: SafeArea(
          child: Container(
            width: AppReference.deviceWidth(context),
            height: AppReference.deviceHeight(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImagesAssets.sPrimaryChildBackground),
                  fit: BoxFit.fill,
                )),
            child: Column(
              children: [
                HeaderForTermsAndLevelsAndGroup(
                  title: AppStrings.randomExamTitle,
                  backTo: () {
    if(!AppReference.userIsChild()){
    _backToParentChallengeScreen(context);
    }else{
      _backToPrimaryChildChallengeScreen(context);
    }
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [


                        const TextWithRocketWidget(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: const PrimaryChallengeTitleWidget()
                              .animateScaleNFadeHorizontal(),
                        ),
                        if (dataToGoExams.subjects.isEmpty)
                          Center(
                              child: Text(
                                AppStrings.notSubscription,
                                style: AppTextStyle.titleLarge22,
                              )),
                        if (dataToGoExams.subjects.isNotEmpty)
                          Column(children: [
                            SubjectsWidget(dataToGoExams: dataToGoExams)
                                .animateFlipVertical(),
                            AppSize.s20.sizedBoxHeight,
                            BlocBuilder<RandomExamsBloc, RandomExamsState>(
                              builder: (context, state) {
                                return switch (state.getRandomExamsRequestState) {
                                  RequestStates.loading =>
                                  const LoadingShimmerList(),
                                  RequestStates.loaded => state
                                      .randomExams.isNotEmpty
                                      ? AppReference.deviceIsTablet &&
                                      !AppReference.isPortrait(context)
                                      ? GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    crossAxisSpacing: 20.responsiveWidth,
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                    AppReference.deviceWidth(
                                        context) /
                                        (AppReference.deviceHeight(
                                            context)) *
                                        1.3,
                                    children: List.generate(
                                      state.randomExams.length,
                                          (index) {
                                        return CustomInkWell(
                                            onTap: () =>
                                                RouteManager.rPushNamedAndRemoveUntil(
                                                  context: context,
                                                  rName: AppRoutesNames
                                                      .rRepeatQuestionScreen,
                                                  arguments: dataToGoExams.copyWith(
                                                    examId: state
                                                        .randomExams[index]
                                                        .id,
                                                  )
                                                ),
                                            child: Container(
                                              margin:
                                              EdgeInsets.symmetric(
                                                vertical: AppPadding
                                                    .p10.responsiveSize,
                                              ),
                                              width: AppReference
                                                  .deviceIsTablet
                                                  ? AppReference
                                                  .deviceWidth(
                                                  context) *
                                                  0.4
                                                  : AppReference
                                                  .deviceWidth(
                                                  context) *
                                                  0.8,
                                              height: AppReference
                                                  .deviceHeight(
                                                  context) *
                                                  0.14.responsiveHeightRatio,
                                              decoration: ShapeDecoration(
                                                color: AppColors
                                                    .primaryColor,
                                                shape:
                                                RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: AppPadding.p6
                                                        .responsiveWidth,
                                                    color: AppColors
                                                        .primary2,
                                                  ),
                                                  borderRadius: BorderRadius
                                                      .circular(AppConstants
                                                      .appBorderRadiusR20
                                                      .responsiveSize),
                                                ),
                                              ),
                                              child: LayoutBuilder(
                                                  builder: (context,
                                                      constraints) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        SizedBox(
                                                          width: constraints
                                                              .maxWidth *
                                                              0.75,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  state
                                                                      .randomExams[
                                                                  index]
                                                                      .name,
                                                                  style: AppReference
                                                                      .themeData
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "الدرجة ${state.randomExams[index].degree} من ${state.randomExams[index].questionsNumber}",
                                                                style: AppReference
                                                                    .themeData
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: AppColors
                                                                      .warningColor,
                                                                ),
                                                              ),
                                                              Text(
                                                                state
                                                                    .randomExams[
                                                                index]
                                                                    .createdAt.substring(0, 10),
                                                                style: AppReference
                                                                    .themeData
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .white,
                                                                ),
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: constraints
                                                              .maxWidth *
                                                              0.15,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_rounded,
                                                            color: AppColors
                                                                .white,
                                                            size: 30
                                                                .responsiveSize,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ));
                                      },
                                    ),
                                  )
                                      : ListView.builder(
                                      itemCount: state.randomExams.length,
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return CustomInkWell(
                                            onTap: AppReference
                                                .userIsChild()
                                                ? () =>
                                                RouteManager.rPushNamedAndRemoveUntil(
                                                  context: context,
                                                  rName: AppRoutesNames
                                                      .rRepeatQuestionScreen,
                                                  arguments: dataToGoExams.copyWith(
                                                    examId: state.randomExams[index].id,
                                                  )

                                                )
                                                : () {},
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: AppPadding
                                                    .p10.responsiveSize,
                                              ),
                                              width:
                                              AppReference
                                                  .deviceIsTablet
                                                  ? AppReference
                                                  .deviceWidth(
                                                  context) *
                                                  0.4
                                                  : AppReference
                                                  .deviceWidth(
                                                  context) *
                                                  0.8,
                                              height: AppReference
                                                  .deviceHeight(
                                                  context) *
                                                  0.14.responsiveHeightRatio,
                                              decoration: ShapeDecoration(
                                                color:
                                                AppColors.primaryColor,
                                                shape:
                                                RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: AppPadding
                                                        .p6.responsiveWidth,
                                                    color:
                                                    AppColors.primary2,
                                                  ),
                                                  borderRadius: BorderRadius
                                                      .circular(AppConstants
                                                      .appBorderRadiusR20
                                                      .responsiveSize),
                                                ),
                                              ),
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                return Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: constraints
                                                          .maxWidth *
                                                          0.75,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              state
                                                                  .randomExams[
                                                              index]
                                                                  .name,
                                                              style: AppReference
                                                                  .themeData
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "الدرجة ${state.randomExams[index].degree} من ${state.randomExams[index].questionsNumber}",
                                                            style: AppReference
                                                                .themeData
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                              color: AppColors
                                                                  .warningColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            state
                                                                .randomExams[
                                                            index]
                                                                .createdAt.substring(0, 10),
                                                            style: AppReference
                                                                .themeData
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              color:
                                                              AppColors
                                                                  .white,
                                                            ),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: constraints
                                                          .maxWidth *
                                                          0.15,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_rounded,
                                                        color:
                                                        AppColors.white,
                                                        size: 30
                                                            .responsiveSize,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            )).animateRightLeft();
                                      })
                                      : Column(
                                        children: [
                                          AppSize.s100.sizedBoxHeight,
                                          const EmptyListWidgets(
                                          message:
                                          AppStrings.noRandamExamsForThisSubject),
                                        ],
                                      ),
                                  RequestStates.error => ErrorWidget(
                                    state.getRandomExamsErrorMessage,
                                  ),
                                  _ => const SizedBox()
                                };
                              },
                            )
                          ]),
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }

  _backToPrimaryChildChallengeScreen(context){
    RouteManager.rPushNamedAndRemoveUntil(
      context: context,
      rName: AppRoutesNames.rPrimaryChildChallengeScreen,
      arguments: dataToGoExams
    );
  }

  _backToParentChallengeScreen(context){
    RouteManager.rPopRoute(context);
  }
  // _backToParentChallengeScreen(context){
  //   RouteManager.rPushNamedAndRemoveUntil(
  //     context: context,
  //     rName: AppRoutesNames.rSubscriptionsSystemsScreen,
  //     arguments:DataToGoRandomExams(
  //         isRandomExam: true,
  //         dataToGoExams:dataToGoExams,
  //         user: dataToGoExams.user,
  //         isPrimary: AppReference.childIsPrimary()),
  //   );
  // }

}
