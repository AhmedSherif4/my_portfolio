part of '../challenge_screen.dart';

class ChildChallengeScreen extends StatefulWidget {
  final DataToGoExams dataToGoExams;

  const ChildChallengeScreen({
    super.key,
    required this.dataToGoExams,
  });

  @override
  State<ChildChallengeScreen> createState() => _ChildChallengeScreenState();
}

class _ChildChallengeScreenState extends State<ChildChallengeScreen> {

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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                 HeaderForTermsAndLevelsAndGroup(
                   backTo: (){
        if(widget.dataToGoExams.fromSubscription!) {
          _backScreen(context);
        }else{
          _backToHomeScreen(context);
        }
                   },
                 ),
                const _TextWidget(),
                Align(
                  alignment: Alignment.centerRight,
                  child: const _ChildChallengeTitleWidget()
                      .animateScaleNFadeHorizontal(),
                ),
                BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                  builder: (context, state) {
                    return switch(state.getSubjectsState){
                      RequestStates.loading => const LoadingShimmerList(),
                      RequestStates.loaded => ResponsiveWidgetForTablet(
                        mobile: OrientationItem(portraitWidget: Column(children: [
                          // CustomInkWell(
                          //   onTap: (){
                          //     _goToExam(state.subjects);
                          //   },
                          //   child: const ChildCardChallengeWidget(
                          //     title: AppStrings.exams,
                          //     description:
                          //     AppStrings.downloadTheTestsAndDeliverThemToUsWithEase,
                          //     image: AppImagesAssets.sExamAdultChallenge,
                          //   ),
                          // ).animateRightLeft(),
                          CustomInkWell(
                            onTap: (){
                              if (!AppReference.userIsGuest()) {
                                _goToRandomExam(state.subjects);
                              } else {
                                AppReference.guestDialogMustLogin(context);
                              }
                            },
                            child: const ChildCardChallengeWidget(
                              title: AppStrings.randomExamTitle,
                              description:
                              AppStrings.randomExamDescription,
                              image: AppIconsAssets.sRandomExams,
                            ),
                          ).animateRightLeft(),
                          if(AppReference.childIsMiddle())
                          CustomInkWell(
                            onTap: (){
                              _goToNafees();
                            },
                            child: const ChildCardChallengeWidget(
                              title: "الاختبارات المحاكية لنافس",
                              description:"درِّب نفسك على اختبارات محاكية لاختبارات التحصيلي",
                              image: AppImagesAssets.sNafes,
                            ).paddingBody(),
                          ),
                          if(!AppReference.childIsMiddle())
                            CustomInkWell(
                              onTap: (){
                                _goToNafeesSecondry();
                              },
                              child: const ChildCardChallengeWidget(
                              title: "الاختبارات المحاكية للقدرات والتحصيلي",
                              description:"درِّب نفسك على اختبارات محاكية لاختبارات التحصيلي",
                              image: AppImagesAssets.sSimulated22,
                                                        ).paddingBody(),
                            ),
                        ]), landscapeWidget: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // Expanded(
                                  //     child:CustomInkWell(
                                  //       onTap: (){
                                  //         _goToExam(state.subjects);
                                  //       },
                                  //       child: const ChildCardChallengeWidget(
                                  //         title: AppStrings.exams,
                                  //         description:
                                  //         AppStrings.downloadTheTestsAndDeliverThemToUsWithEase,
                                  //         image: AppImagesAssets.sExamAdultChallenge,
                                  //       ),
                                  //     )),
                                 AppSize.s10.sizedBoxWidth,
                                  Expanded(
                                    child:  CustomInkWell(
                                      onTap: (){
                                        _goToRandomExam(state.subjects);
                                      },
                                      child: const ChildCardChallengeWidget(
                                        title: AppStrings.randomExamTitle,
                                        description:
                                        AppStrings.randomExamDescription,
                                        image: AppImagesAssets.sExamAdultChallenge,
                                      ),

                                    ),),
                                  AppSize.s10.sizedBoxWidth,

                                  if(AppReference.childIsMiddle())
                                    Expanded(
                                      child: CustomInkWell(
                                        onTap: (){
                                          _goToNafees();
                                        },
                                        child: const ChildCardChallengeWidget(
                                          title: "الاختبارات المحاكية لنافس",
                                          description:"درِّب نفسك على اختبارات محاكية لاختبارات التحصيلي",
                                          image: AppImagesAssets.sNafes,
                                        ).paddingBody(),
                                      ),
                                    ),
                                  if(!AppReference.childIsMiddle())
                                    Expanded(
                                      child: CustomInkWell(
                                        onTap: (){
                                          _goToNafeesSecondry();
                                        },
                                        child: const ChildCardChallengeWidget(
                                          title: "الاختبارات المحاكية للقدرات والتحصيلي",
                                          description:"درِّب نفسك على اختبارات محاكية لاختبارات التحصيلي",
                                          image: AppImagesAssets.sNafes,
                                        ).paddingBody(),
                                      ),
                                    ),

                                ]),
                          ],
                        )),
                        tablet:  Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    // Expanded(
                                    //     child:CustomInkWell(
                                    //       onTap: (){
                                    //         _goToExam(state.subjects);
                                    //       },
                                    //       child: const ChildCardChallengeWidget(
                                    //         title: AppStrings.exams,
                                    //         description:
                                    //         AppStrings.downloadTheTestsAndDeliverThemToUsWithEase,
                                    //         image: AppImagesAssets.sExamAdultChallenge,
                                    //       ),
                                    //     )),

                                    Expanded(
                                      child:  CustomInkWell(
                                        onTap: (){
                                          _goToRandomExam(state.subjects);
                                        },
                                        child: const ChildCardChallengeWidget(
                                          title: AppStrings.randomExamTitle,
                                          description:
                                          AppStrings.randomExamDescription,
                                          image: AppImagesAssets.sExamAdultChallenge,
                                        ),
                                      ),),
                                    AppSize.s10.sizedBoxWidth,
                                    if(AppReference.childIsMiddle())
                                      Expanded(
                                        child: CustomInkWell(
                                          onTap: (){
                                            _goToNafees();
                                          },
                                          child: const ChildCardChallengeWidget(
                                            title: "الاختبارات المحاكية لنافس",
                                            description:"درِّب نفسك على اختبارات محاكية لاختبارات التحصيلي",
                                            image: AppImagesAssets.sNafes,
                                          ).paddingBody(),
                                        ),
                                      ),
                                    if(!AppReference.childIsMiddle())
                                      Expanded(
                                        child: CustomInkWell(
                                          onTap: (){
                                            _goToNafeesSecondry();
                                          },
                                          child: const ChildCardChallengeWidget(
                                            title: "الاختبارات المحاكية للقدرات والتحصيلي",
                                            description:"درِّب نفسك على اختبارات محاكية لاختبارات التحصيلي",
                                            image: AppImagesAssets.sNafes,
                                          ).paddingBody(),
                                        ),
                                      ),

                                  ]),

                                ],
                          ),
                        ),

                      RequestStates.error => CustomErrorWidget(errorMessage: state.getSubjectsStateMessage),
                      _ => const SizedBox(),
                    };
                  },
                ),

              ],
            ),
          ).paddingBody(),
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
    final newDataToGoExams = widget.dataToGoExams.copyWith(subjects:subjects );
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rChildExamsScreen,
      arguments: newDataToGoExams ,
    );
  }

  void _goToNafees() {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rNafeesPlanScreen,
      arguments: widget.dataToGoExams.user.userId,
    );
  }


  void _goToNafeesSecondry() {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rSimulatedExamsScreen,
      arguments: widget.dataToGoExams.user.userId,
    );
  }



  void _goToRandomExam(subjects) {
    final newDataToGoRandomExams = widget.dataToGoExams.copyWith(subjects:subjects );
    RouteManager.rPushNamedAndRemoveUntil(
      context: context,
      rName: AppRoutesNames.rChildRandomExamsScreen,
      arguments: newDataToGoRandomExams,
    );
  }
}
