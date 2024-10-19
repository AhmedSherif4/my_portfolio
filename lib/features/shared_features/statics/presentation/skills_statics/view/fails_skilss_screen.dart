part of '../../../statics.dart';


class FailsSkillsScreen extends StatefulWidget {
  final GetFailsSkillsWithQuestionsParameters subjectsAndChildId;

  const FailsSkillsScreen({super.key, required this.subjectsAndChildId});

  @override
  State<FailsSkillsScreen> createState() => _FailsSkillsScreenState();
}

class _FailsSkillsScreenState extends State<FailsSkillsScreen> {
  late SubjectsEntity subject;
 _goToHome() {
   RouteManager.rPushReplacementNamed(
     context: context,
     rName: AppRoutesNames.rHomeLayoutView,
     arguments: getIt<UserLocalDataSource>().getUserData(),
   );
 }
  @override
  void initState() {
    subject = widget.subjectsAndChildId.subjects!.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if(!value) {
          if(widget.subjectsAndChildId.fromStatic) {
            return;
          }else{
          _goToHome();
          }
        }

      },
      child: BlocProvider(
        create: (context) => getIt<SkillStaticsBloc>()
          ..add(
            GetFailsSkillsEvent(
                failsSkillsParm: GetFailsSkillsWithQuestionsParameters(
                    fromStatic: widget.subjectsAndChildId.fromStatic,
                    subjectId: widget.subjectsAndChildId.subjectId,
                    childId: widget.subjectsAndChildId.childId)),
          ),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   HeaderForMore(
                    title: 'مهاراتى',
                    notFirst: true,
                    onBack: (){
                      if(widget.subjectsAndChildId.fromStatic) {
                        RouteManager.rPopRoute(context);
                      }else{
                        _goToHome();
                      }
                    },
                  ),
                  AppSize.s20.sizedBoxHeight,
                  Row(
                    children: [
                      AppSize.s30.sizedBoxWidth,
                      SvgPicture.asset(AppImagesAssets.sMountaineerCompass),
                    ],
                  ).animateSlideTopToNormal(),
                  AppSize.s20.sizedBoxHeight,
                  Container(
                    padding: EdgeInsets.all(AppSize.s10.responsiveSize),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR20.responsiveSize),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text( AppReference.childIsPrimary()? 'المهارات الضعيفة / المفقودة':"الفاقد التعليمي",
                            style: const AppTextStyle()
                                .balooBhaijaan2
                                .w500
                                .black
                                .bodyMedium14),
                        AppSize.s10.sizedBoxWidth,
                        SvgPicture.asset(AppIconsAssets.sAttention),
                      ],
                    ),
                  ).animateSlideTopToNormal(),
                  AppSize.s16.sizedBoxHeight,

                  StatefulBuilder(
                    builder: (context, subjectsSetState) {
                      return DefaultDropDownButton<SubjectsEntity>(
                        studyingData: widget.subjectsAndChildId.subjects!,
                        displayText: (subject) => subject.subjectName,
                        onChange: (value) {
                          subjectsSetState(() {
                            subject = value!;
                          });
                          context.read<SkillStaticsBloc>()
                              .add(
                            GetFailsSkillsEvent(
                                failsSkillsParm:
                                GetFailsSkillsWithQuestionsParameters(
                                    fromStatic: widget.subjectsAndChildId.fromStatic,
                                    subjectId: subject.subjectId,
                                    childId: widget
                                        .subjectsAndChildId.childId)),
                          );
                          // buildSetState(() {});
                        },
                        selectedItem: subject,
                        color: AppColors.primaryColor2,
                        labelColor: AppColors.primaryColor,
                      ).animateSlideTopToNormal();
                    },
                  ),

                  AppSize.s20.sizedBoxHeight,
                  BlocBuilder<SkillStaticsBloc, SkillStaticsState>(
                      builder: (context, state) {
                        switch (state.failsSkillsStates) {
                          case RequestStates.loading:
                            return LoadingShimmerList(
                              height: 70.responsiveHeight,
                            );
                          case RequestStates.loaded:
                            if (state.failsSkills.isEmpty) {
                              return  EmptyListWidgets(
                                  message: AppReference.childIsPrimary()?'لا يوجد مهارت ضعيفة / مفقودة':"لا يوجد فاقد تعليمي");
                            } else {
                              return ListView.separated(
                                   physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return CustomInkWell(
                                    onTap: () {
                                      RouteManager.rPushNamed(
                                          context: context,
                                          rName:
                                          AppRoutesNames.rFailsSuccessSkillsScreen,
                                          arguments: GetFailsSkillsWithQuestionsParameters(
                                            fromStatic: widget.subjectsAndChildId.fromStatic,
                                            subjectId: widget.subjectsAndChildId.subjectId,
                                            subjects: widget.subjectsAndChildId.subjects,
                                            childId: widget.subjectsAndChildId.childId,
                                            failQuestions: state.failsSkills[index],
                                          )
                                      );
                                    },

                                    child: Container(
                                      padding: EdgeInsets.all(10.responsiveSize),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(AppConstants
                                            .appBorderRadiusR20.responsiveSize),
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              state.failsSkills[index].skills,
                                              style: const AppTextStyle()
                                                  .balooBhaijaan2
                                                  .w500
                                                  .bodyLarge16
                                                  .copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                           Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.primaryColor,
                                            size: AppSize.s16.responsiveSize,
                                          )
                                        ],
                                      ),
                                    ).animateRightLeft(),
                                  );
                                  }, separatorBuilder: (BuildContext context, int index) => AppSize.s10.sizedBoxHeight, itemCount: state.failsSkills.length);
                            }
                          case RequestStates.error:
                            return CustomErrorWidget(
                                errorMessage: state.failsSkillsErrorMessage);
                          default:
                            return const SizedBox();
                        }
                      }),
                ],
              ),

            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}
