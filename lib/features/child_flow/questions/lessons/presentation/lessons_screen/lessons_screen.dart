part of '../../lessons.dart';

class LessonsScreen extends StatefulWidget {
  final DataToGoQuestions data;

  const LessonsScreen({super.key, required this.data});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  void initState() {
    super.initState();
    AppAnalytics.viewLessonScreenLogEvent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LessonsBloc>()
        ..add(
          widget.data.subjectsHaveUnits
              ? GetAllLessonsByUnitsEvent(
                  ParameterGoToQuestions(
                    subjectId: widget.data.subjectId,
                    stageId: widget.data.stageId,
                    classRoomId: widget.data.classRoomId,
                    termId: widget.data.termId,
                    systemId: widget.data.systemId,
                    pathId: widget.data.pathId,
                  ),
                )
              : GetAllLessonsEvent(
                  ParameterGoToQuestions(
                    subjectId: widget.data.subjectId,
                    stageId: widget.data.stageId,
                    classRoomId: widget.data.classRoomId,
                    termId: widget.data.termId,
                    systemId: widget.data.systemId,
                    pathId: widget.data.pathId,
                  ),
                ),
        ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (widget.data.termId ==
              getIt<UserLocalDataSource>().getUserData()!.termId) {
            RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rHomeLayoutView,
              arguments: getIt<UserLocalDataSource>().getUserData(),
            );
          } else {
            RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rLessonOrLevelScreen,
              arguments: DataToGoQuestions(
                  subjectId: widget.data.subjectId,
                  notHaveImage: widget.data.notHaveImage,
                  isGeneralQuestions: false,
                  imgUrl: widget.data.imgUrl,
                  subjectName: widget.data.subjectName,
                  isPrimary:
                      widget.data.stageId == 1 || widget.data.stageId == 4
                          ? true
                          : false,
                  subjectsHaveUnits: widget.data.subjectHaveUnits,
                  stageId: widget.data.stageId,
                  classRoomId: widget.data.classRoomId,
                  termId: widget.data.termId,
                  systemId: widget.data.systemId,
                  pathId: widget.data.pathId,
                  subjects: widget.data.subjects),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: OrientationItem(
              portraitWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeaderForLessons(widget: widget),
                  AppSize.s16.sizedBoxHeight,
                  SizedBox(
                    width: AppReference.deviceIsTablet
                        ? AppReference.deviceWidth(context) * 0.75
                        : AppReference.deviceWidth(context),
                    height: AppReference.deviceIsTablet
                        ? AppReference.deviceHeight(context) *
                            0.1.responsiveHeightRatio
                        : AppReference.deviceHeight(context) *
                            0.14.responsiveHeightRatio,
                    child: BaseContainerHaveTextAndImage(
                      title: widget.data.subjectName,
                      notHaveImage: widget.data.notHaveImage,
                      description: AppStrings.myLessons,
                      imageUrl: widget.data.imgUrl,
                      width: AppReference.deviceWidth(context),
                      height: AppReference.deviceHeight(context) *
                          0.14.responsiveHeightRatio,
                    ).animateSlideTopToNormal(
                        duration: AppConstants.animationTime),
                  ),
                  AppSize.s16.sizedBoxHeight,
                  SizedBox(
                    width: AppReference.deviceIsTablet
                        ? AppReference.deviceWidth(context) * 0.75
                        : AppReference.deviceWidth(context),
                    child: GeneralQuestionsButton(
                      goToLevelScreen: () {
                        final updateTypeOfQuestion =
                            widget.data.copyWith(isGeneralQuestions: true);
                        widget.data.isPrimary
                            ? RouteManager.rPushNamedAndRemoveUntil(
                                context: context,
                                rName: AppRoutesNames.rPrimaryLevelScreen,
                                arguments: updateTypeOfQuestion,
                              )
                            : RouteManager.rPushNamedAndRemoveUntil(
                                context: context,
                                rName: AppRoutesNames.rChildLevelScreen,
                                arguments: updateTypeOfQuestion,
                              );
                      },
                    ).animateSlideTopToNormal(
                        duration: AppConstants.animationTime),
                  ),

                  AppSize.s20.sizedBoxHeight,
                  LessonBuilder(data: widget.data),
                ],
              ),
              landscapeWidget:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeaderForLessons(widget: widget),
                  AppSize.s16.sizedBoxHeight,
                  SizedBox(
                    width: AppReference.deviceIsTablet
                        ? AppReference.deviceWidth(context) * 0.75
                        : AppReference.deviceWidth(context),
                    height: AppReference.deviceIsTablet
                        ? AppReference.deviceHeight(context) *
                        0.1.responsiveHeightRatio
                        : AppReference.deviceHeight(context) *
                        0.14.responsiveHeightRatio,
                    child: BaseContainerHaveTextAndImage(
                      title: widget.data.subjectName,
                      notHaveImage: widget.data.notHaveImage,
                      description: AppStrings.myLessons,
                      imageUrl: widget.data.imgUrl,
                      width: AppReference.deviceWidth(context),
                      height: AppReference.deviceHeight(context) *
                          0.14.responsiveHeightRatio,
                    ).animateSlideTopToNormal(
                        duration: AppConstants.animationTime),
                  ),
                  AppSize.s16.sizedBoxHeight,
                  SizedBox(
                    width: AppReference.deviceIsTablet
                        ? AppReference.deviceWidth(context) * 0.75
                        : AppReference.deviceWidth(context),
                    child: GeneralQuestionsButton(
                      goToLevelScreen: () {
                        final updateTypeOfQuestion =
                        widget.data.copyWith(isGeneralQuestions: true);
                        widget.data.isPrimary
                            ? RouteManager.rPushNamedAndRemoveUntil(
                          context: context,
                          rName: AppRoutesNames.rPrimaryLevelScreen,
                          arguments: updateTypeOfQuestion,
                        )
                            : RouteManager.rPushNamedAndRemoveUntil(
                          context: context,
                          rName: AppRoutesNames.rChildLevelScreen,
                          arguments: updateTypeOfQuestion,
                        );
                      },
                    ).animateSlideTopToNormal(
                        duration: AppConstants.animationTime),
                  ),

                  AppSize.s20.sizedBoxHeight,
                  LessonBuilder(data: widget.data),
                ],
              )
              // Column(
              //   children: [
              //     _HeaderForLessons(widget: widget),
              //     Expanded(
              //       child: CustomScrollView(
              //         slivers: [
              //           SliverToBoxAdapter(
              //             child:AppSize.s16.sizedBoxHeight,
              //           ),
              //           SliverToBoxAdapter(
              //             child:SizedBox(
              //               width: AppReference.deviceIsTablet
              //                   ? AppReference.deviceWidth(context) * 0.75
              //                   : AppReference.deviceWidth(context),
              //               height: AppReference.deviceIsTablet
              //                   ? AppReference.deviceHeight(context) *
              //                   0.1.responsiveHeightRatio
              //                   : AppReference.deviceHeight(context) *
              //                   0.14.responsiveHeightRatio,
              //               child: BaseContainerHaveTextAndImage(
              //                 title: widget.data.subjectName,
              //                 notHaveImage: widget.data.notHaveImage,
              //                 description: AppStrings.myLessons,
              //                 imageUrl: widget.data.imgUrl,
              //                 width: AppReference.deviceWidth(context),
              //                 height: AppReference.deviceHeight(context) *
              //                     0.14.responsiveHeightRatio,
              //               ).animateSlideTopToNormal(
              //                   duration: AppConstants.animationTime),
              //             ),
              //           ),
              //           SliverToBoxAdapter(
              //             child:AppSize.s16.sizedBoxHeight,
              //           ),
              //           SliverToBoxAdapter(
              //             child:SizedBox(
              //               width: AppReference.deviceIsTablet
              //                   ? AppReference.deviceWidth(context) * 0.75
              //                   : AppReference.deviceWidth(context),
              //               child: GeneralQuestionsButton(
              //                 goToLevelScreen: () {
              //                   final updateTypeOfQuestion =
              //                   widget.data.copyWith(isGeneralQuestions: true);
              //                   widget.data.isPrimary
              //                       ? RouteManager.rPushNamedAndRemoveUntil(
              //                     context: context,
              //                     rName: AppRoutesNames.rPrimaryLevelScreen,
              //                     arguments: updateTypeOfQuestion,
              //                   )
              //                       : RouteManager.rPushNamedAndRemoveUntil(
              //                     context: context,
              //                     rName: AppRoutesNames.rChildLevelScreen,
              //                     arguments: updateTypeOfQuestion,
              //                   );
              //                 },
              //               ).animateSlideTopToNormal(
              //                   duration: AppConstants.animationTime),
              //             ),
              //           ),
              //           SliverToBoxAdapter(
              //             child:AppSize.s16.sizedBoxHeight,
              //           ),
              //           SliverFillRemaining(
              //              fillOverscroll: false,
              //              hasScrollBody: true,
              //             child:LessonBuilder(data: widget.data),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}

class _HeaderForLessons extends StatelessWidget {
  const _HeaderForLessons({
    super.key,
    required this.widget,
  });

  final LessonsScreen widget;

  @override
  Widget build(BuildContext context) {
    return HeaderForTermsAndLevelsAndGroup(
      withTitle: false,
      withRank: false,
      backTo: widget.data.termId ==
              getIt<UserLocalDataSource>().getUserData()!.termId
          ? () {
              RouteManager.rPushNamedAndRemoveUntil(
                  context: context,
                  rName: AppRoutesNames.rHomeLayoutView,
                  arguments:
                      getIt<UserLocalDataSource>().getUserData());
            }
          : () {
              RouteManager.rPushNamedAndRemoveUntil(
                context: context,
                rName: AppRoutesNames.rLessonOrLevelScreen,
                arguments: DataToGoQuestions(
                    subjectId: widget.data.subjectId,
                    notHaveImage: widget.data.notHaveImage,
                    isGeneralQuestions: false,
                    imgUrl: widget.data.imgUrl,
                    subjectName: widget.data.subjectName,
                    isPrimary: widget.data.stageId == 1 ||
                            widget.data.stageId == 4
                        ? true
                        : false,
                    subjectsHaveUnits: widget.data.subjectHaveUnits,
                    stageId: widget.data.stageId,
                    classRoomId: widget.data.classRoomId,
                    termId: widget.data.termId,
                    systemId: widget.data.systemId,
                    pathId: widget.data.pathId,
                    subjects: widget.data.subjects),
              );
            },
      userData: getIt<UserLocalDataSource>().getUserData()!,
    );
  }
}
