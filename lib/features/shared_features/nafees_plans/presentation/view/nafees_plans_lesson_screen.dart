part of '../../nafees_plans.dart';


class NafeesLessonScreen extends StatelessWidget {

  const NafeesLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppAnalytics.viewNafeesScreenLogEvent();
    return BlocProvider(
      lazy: false,
      create: (context) => getIt<NafeesBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HeaderForTermsAndLevelsAndGroup(),
              AppSize.s26.sizedBoxHeight,
              SizedBox(
                width:AppReference.deviceIsTablet? AppReference.deviceWidth(context)*.75: AppReference.deviceWidth(context),
                height: AppReference.deviceIsTablet? AppReference.deviceHeight(context) *
                    0.1.responsiveHeightRatio:AppReference.deviceHeight(context) *
                    0.14.responsiveHeightRatio,
                child: BaseContainerHaveTextAndImage(
                  title: "nafeesSubject.name",
                  notHaveImage: false,
                  description: 'دروسي',
                  imageUrl: "nafeesSubject.img",
                  width: AppReference.deviceWidth(context),
                  height: AppReference.deviceHeight(context) *
                      0.14.responsiveHeightRatio,
                ).animateSlideTopToNormal(duration: AppConstants.animationTime),
              ),
              AppSize.s20.sizedBoxHeight,
              Expanded(
                child: BlocBuilder<NafeesBloc, NafeesState>(
                  builder: (context, state) {
                    switch (state.getNafeesExamsState) {
                      case RequestStates.loading:
                        return const LoadingShimmerList();
                      case RequestStates.loaded:
                        if (state.nafeesExam.nafeesQuestionEntity.isEmpty) {
                          return EmptyLessonWidget(
                            onRefresh: () {
                              _refreshLessonWithoutUnits(context);
                            },
                          );
                        } else {
                          return   (AppReference.deviceIsTablet && !AppReference.isPortrait(context))?
                              GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 30,
                                childAspectRatio: 14/2,
                              ),
                                itemBuilder: (context, index) {
                                  return LessonItemWidget(
                                    isLock: false,
                                    fromNafees: true,
                                    onTap: () {
                                      final updateDataWithLessonId =
                                      const DataToGoQuestions(
                                          imgUrl: '',
                                          notHaveImage: true,
                                          subjectName: '',
                                          stageId: 0,
                                          classRoomId: 0,
                                          termId: 0,
                                          subjectId: 0,
                                          isPrimary: true,
                                          systemId: 0)
                                          .copyWith(
                                          isFromNafees: true,
                                          lessonId: 0);
                                          // lessonId: state
                                          //     .nafeesLessonsSubjectsPlans[index]
                                          //     .id);
                                      RouteManager.rPushNamed(
                                          context: context,
                                          rName: AppRoutesNames.rQuestionsScreen,
                                          arguments: updateDataWithLessonId);
                                    },
                                    imagePath: "state.nafeesLessonsSubjectsPlans[index].image",
                                    notHaveImage: false,
                                    isCompleted: false,
                                    lessonName: "",
                                    description:AppStrings.noDescription,
                                  );
                                },
                                itemCount: 3,

                              )
                              :ListView.separated(
                            itemBuilder: (context, index) {
                              return LessonItemWidget(
                                isLock: false,
                                fromNafees: true,
                                onTap: () {
                                  final updateDataWithLessonId =
                                      const DataToGoQuestions(
                                          imgUrl: '',
                                          notHaveImage: true,
                                          subjectName: '',
                                          stageId: 0,
                                          classRoomId: 0,
                                          termId: 0,
                                          subjectId: 0,
                                          isPrimary: true,
                                          systemId: 0)
                                          .copyWith(
                                              isFromNafees: true,
                                              lessonId: 0);
                                  RouteManager.rPushNamed(
                                      context: context,
                                      rName: AppRoutesNames.rQuestionsScreen,
                                      arguments: updateDataWithLessonId);
                                },
                                imagePath: "state.nafeesLessonsSubjectsPlans[index].image",
                                notHaveImage: false,
                                isCompleted: false,
                                lessonName: "",
                                description:AppStrings.noDescription,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                AppSize.s16.sizedBoxHeight,
                            itemCount: 3,
                          );
                        }
                      case RequestStates.error:
                        return CustomErrorWidget(
                            errorMessage:
                               " state.getNafeesLessonsSubjectsPlansMessage");
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ).paddingBody(),
      ),
    );
  }

  void _refreshLessonWithoutUnits(context) {
    // BlocProvider.of<NafeesBloc>(context).add(
    //   GetNafeesLessonsEvent(
    //     nafeesSubjectId: nafeesSubject.id,
    //   ),
    // );
  }
}
