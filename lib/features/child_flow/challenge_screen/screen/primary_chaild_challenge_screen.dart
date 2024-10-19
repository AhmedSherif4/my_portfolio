part of '../challenge_screen.dart';

class PrimaryChildChallengeScreen extends StatefulWidget {
  final DataToGoExams dataToGoExams;

  const PrimaryChildChallengeScreen({
    super.key,
    required this.dataToGoExams,
  });

  @override
  State<PrimaryChildChallengeScreen> createState() =>
      _PrimaryChildChallengeScreenState();
}
class _PrimaryChildChallengeScreenState
    extends State<PrimaryChildChallengeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:(value){
        if(widget.dataToGoExams.fromSubscription!) {
          _backScreen(context);
        }else{
        _backToHomeScreen(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            height: AppReference.deviceHeight(context),
            width: AppReference.deviceWidth(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AppImagesAssets.sPrimaryChildBackground),
              fit: BoxFit.fill,
            )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                   HeaderForTermsAndLevelsAndGroup(title: AppStrings.exams,
                   backTo: (){
                     if(widget.dataToGoExams.fromSubscription??false) {
                        _backScreen(context);
                     }else{
                       _backToHomeScreen(context);
                     }
                   },
                   ),
                  const TextWithRocketWidget(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: const PrimaryChallengeTitleWidget()
                        .animateScaleNFadeHorizontal(),
                  ),
                  BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                    builder: (context, state) {
                      return switch (state.getSubjectsState) {
                        RequestStates.loading => const LoadingShimmerList(),
                        RequestStates.loaded => ResponsiveWidgetForTablet(
                            mobile: OrientationItem(
                                portraitWidget: Column(children: [
                                  // _PrimaryChildButtonGoToExam(
                                  //     primaryChildButtonGoToExamOnTap: () {
                                  //   _goToExam(state.subjects);
                                  // }),
                                  _PrimaryChildButtonGoToRandomExam(
                                      primaryChildButtonGoToRandomExamOnTap: () {
                                        if (!AppReference.userIsGuest()) {
                                          _goToRandomExam(state.subjects);
                                        } else {
                                          AppReference.guestDialogMustLogin(context);
                                        }
                                  }),
                                  _PrimaryChildButtonGoToNafees(
                                      primaryChildButtonGoToNafeesonTap:
                                          _goToNafees),
                                ]),
                                landscapeWidget: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // Expanded(child:
                                          //     _PrimaryChildButtonGoToExam(
                                          //         primaryChildButtonGoToExamOnTap:
                                          //             () {
                                          //   _goToExam(state.subjects);
                                          // })),
                                          Expanded(
                                            child: _PrimaryChildButtonGoToRandomExam(
                                                primaryChildButtonGoToRandomExamOnTap:
                                                    () {
                                              _goToRandomExam(state.subjects);
                                            }),
                                          ),
                                          AppSize.s10.sizedBoxWidth,
                                          Expanded(
                                              child: _PrimaryChildButtonGoToNafees(
                                                  primaryChildButtonGoToNafeesonTap:
                                                  _goToNafees)),

                                        ]),
                                  ],
                                )),
                            tablet: OrientationItem(
                              portraitWidget: Column(
                                children: [
                                  // _PrimaryChildButtonGoToExam(
                                  //     primaryChildButtonGoToExamOnTap: () {
                                  //   _goToExam(state.subjects);
                                  // }),
                                  _PrimaryChildButtonGoToRandomExam(
                                      primaryChildButtonGoToRandomExamOnTap: () {
                                    _goToRandomExam(state.subjects);
                                  }),
                                  _PrimaryChildButtonGoToNafees(
                                      primaryChildButtonGoToNafeesonTap:
                                          _goToNafees),
                                ],
                              ),
                              landscapeWidget: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Expanded(child:
                                        //     _PrimaryChildButtonGoToExam(
                                        //         primaryChildButtonGoToExamOnTap:
                                        //             () {
                                        //   _goToExam(state.subjects);
                                        // })),
                                        Expanded(
                                          child: _PrimaryChildButtonGoToRandomExam(
                                              primaryChildButtonGoToRandomExamOnTap:
                                                  () {
                                            _goToRandomExam(state.subjects);
                                          }),
                                        ),
                                        AppSize.s10.sizedBoxWidth,
                                        Expanded(
                                            child: _PrimaryChildButtonGoToNafees(
                                                primaryChildButtonGoToNafeesonTap:
                                                _goToNafees)),

                                      ]),
                                ],
                              ),
                            ),
                          ),
                        RequestStates.error => CustomErrorWidget(
                            errorMessage: state.getSubjectsStateMessage),
                        _ => const SizedBox(),
                      };
                    },
                  ),
                ],
              ).paddingBody(),
            ),
          ),
        ),
      ),
    );

  }
  _backToHomeScreen(context){
    RouteManager.rPushNamedAndRemoveUntil(context: context, rName: AppRoutesNames.rHomeLayoutView);
  }
  _backScreen(context){
    RouteManager.rPushNamedAndRemoveUntil(
      context: context,
      rName: AppRoutesNames
          .rLessonOrLevelScreen,
      arguments: widget.dataToGoExams.dataToGoQuestions,
    );  }
  void _goToExam(subjects) {
    final newDataToGoExams = widget.dataToGoExams.copyWith(subjects: subjects);
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rChildExamsScreen,
      arguments: newDataToGoExams,
    );
  }

  void _goToNafees() {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rNafeesPlanScreen,
      arguments: widget.dataToGoExams.user.userId,
    );
  }

  void _goToRandomExam(subjects) {
    final newDataToGoRandomExams =
        widget.dataToGoExams.copyWith(subjects: subjects);
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rPrimaryChildRandomExamsScreen,
      arguments: newDataToGoRandomExams,
    );
  }
}

class _PrimaryChildButtonGoToExam extends StatelessWidget {
  final Function() primaryChildButtonGoToExamOnTap;

  const _PrimaryChildButtonGoToExam(
      {required this.primaryChildButtonGoToExamOnTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: primaryChildButtonGoToExamOnTap,
      child: const PrimaryCardChallengeWidget(
        colorOfBody: AppColors.primaryColor,
        colorOfBorder: AppColors.primary2,
        title: AppStrings.exams,
        description:
            AppStrings.challengeYourFriendsInTheSameClassToIncreaseYourPoints,
        image: AppImagesAssets.sExamChallenge,
      ),
    ).animateRightLeft();
  }
}

class _PrimaryChildButtonGoToNafees extends StatelessWidget {
  final Function() primaryChildButtonGoToNafeesonTap;

  const _PrimaryChildButtonGoToNafees(
      {required this.primaryChildButtonGoToNafeesonTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: primaryChildButtonGoToNafeesonTap,
      child: const PrimaryCardChallengeWidget(
        colorOfBody: AppColors.primaryColor,
        colorOfBorder: AppColors.primary2,
        title: "اختبارات المحاكية لنافس",
        description: "درِّب نفسك على اختبارات محاكية لاختبارات نافس",
        image: AppImagesAssets.sNafes,
      ).animateRightLeft(),
    );
  }
}

class _PrimaryChildButtonGoToRandomExam extends StatelessWidget {
  final Function() primaryChildButtonGoToRandomExamOnTap;

  const _PrimaryChildButtonGoToRandomExam(
      {required this.primaryChildButtonGoToRandomExamOnTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: primaryChildButtonGoToRandomExamOnTap,
      child: const PrimaryCardChallengeWidget(
        colorOfBody: AppColors.primaryColor,
        colorOfBorder: AppColors.primary2,
        title: AppStrings.randomExamTitle,
        description: AppStrings.randomExamDescription,
        image: AppIconsAssets.sRandomExams,
      ),
    ).animateRightLeft();
  }
}
