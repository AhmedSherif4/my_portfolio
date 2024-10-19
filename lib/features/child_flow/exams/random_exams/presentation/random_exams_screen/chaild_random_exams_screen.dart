part of'../../random_exams.dart';


class ChildRandomExamsScreen extends StatelessWidget {
  final DataToGoExams dataToGoExams;

  const ChildRandomExamsScreen({
    super.key,
    required this.dataToGoExams,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:(value){
        if(!value){
          if(!AppReference.userIsChild()){
            _backToParentChallengeScreen(context);
            return;
          }else{
            _backToChildChallengeScreen(context);
          }}
      },
      child: Scaffold(
        floatingActionButton:
            AppReference.userIsChild() && dataToGoExams.subjects.isNotEmpty
                ? AddNewRandomExamFloatingButton(
                    dataToGoExams: dataToGoExams,
                  )
                : const SizedBox.shrink(),
        body: SafeArea(
          child: Column(
            children: [
               HeaderForTermsAndLevelsAndGroup(
                  backTo: (){
    if(!AppReference.userIsChild()){
    _backToParentChallengeScreen(context);
    }else{
      _backToChildChallengeScreen(context);
    }
                   },
                  title: AppStrings.randomExamTitle),
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
                                RequestStates.loading => const LoadingShimmerList(),
                                RequestStates.loaded => state.randomExams.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: state.randomExams.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CustomInkWell(
                                              onTap: AppReference.userIsChild()
                                                  ? () => RouteManager.rPushNamed(
                                                        context: context,
                                                        rName: AppRoutesNames.rRepeatQuestionScreen,
                                                        arguments:dataToGoExams.copyWith(
                                                          examId:state.randomExams[index].id,
                                                        )
                                                      )
                                                  : () {},
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: AppPadding
                                                      .p20.responsiveHeight,
                                                  horizontal: AppPadding
                                                      .p30.responsiveWidth,
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      AppPadding.p10.responsiveSize,
                                                ),
                                                width: AppReference.deviceWidth(
                                                        context) *
                                                    0.7,
                                                decoration: BoxDecoration(
                                                  color: AppColors.textColor6,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppConstants
                                                              .appBorderRadiusR20
                                                              .responsiveSize),
                                                  // boxShadow: [
                                                  //   AppShadow.filledBoxShadow(),
                                                  // ],
                                                ),
                                                child: LayoutBuilder(builder:
                                                    (context, constraints) {
                                                  return Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            constraints.maxWidth *
                                                                0.75,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
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
                                                                    FontWeight.w700,
                                                                color: AppColors
                                                                    .textColor,
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
                                                                    FontWeight.w700,
                                                                color: AppColors
                                                                    .textColor,
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
                                                                    .textColor,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            constraints.maxWidth *
                                                                0.15,
                                                        child: Icon(
                                                          Icons.arrow_right,
                                                          color:
                                                              AppColors.textColor,
                                                          size: 30.responsiveSize,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              )).animateRightLeft();
                                        })
                                    : const EmptyListWidgets(
                                        message:
                                            AppStrings.noRandamExamsForThisSubject),
                                RequestStates.error => ErrorWidget(
                                    AppStrings.edit,
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
    );
  }
  _backToChildChallengeScreen(context){
    RouteManager.rPushNamedAndRemoveUntil(
      context: context,
      rName: AppRoutesNames.rChildChallengeScreen,
      arguments: dataToGoExams,
    );
  }
  _backToParentChallengeScreen(context){
    RouteManager.rPopRoute(context);
  }
  // _backToParentChallengeScreen(context){
  //   RouteManager.rPushNamedAndRemoveUntil(
  //         context: context,
  //         rName: AppRoutesNames.rSubscriptionsSystemsScreen,
  //         arguments:DataToGoRandomExams(
  //             isRandomExam: true,
  //             dataToGoExams:dataToGoExams.copyWith(
  //                 isParent: true
  //             ),
  //             // DataToGoExams(
  //             //   isPrimary: AppReference.childIsPrimary(),
  //             //   subjects: state.subjects,
  //             //   user: childData,
  //             // ),
  //             user: dataToGoExams.user,
  //             isPrimary: AppReference.childIsPrimary()),
  //   );
  // }
}
