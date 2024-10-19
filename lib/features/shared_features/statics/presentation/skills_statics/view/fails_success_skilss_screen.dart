part of '../../../statics.dart';


class FailSuccessSkillsScreen extends StatefulWidget {
  final GetFailsSkillsWithQuestionsParameters getFailsSkillsWithQuestionsParameters;

  const FailSuccessSkillsScreen({super.key, required this.getFailsSkillsWithQuestionsParameters});

  @override
  State<FailSuccessSkillsScreen> createState() =>
      _FailSuccessSkillsScreenState();
}

class _FailSuccessSkillsScreenState extends State<FailSuccessSkillsScreen> {
  SkillType skillType = SkillType.success;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SkillStaticsBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 HeaderForMore(
                  title: AppReference.childIsPrimary()? 'المهارات الضعيفة / المفقودة':"الفاقد التعليمي",
                  notFirst: true,
                ),
                20.sizedBoxHeight,
                Container(
                  padding: EdgeInsets.all(AppSize.s10.responsiveSize),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor2,
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR20.responsiveSize),
                  ),
                  child: Center(
                      child: Text(widget.getFailsSkillsWithQuestionsParameters.failQuestions!.skills,
                          style: const AppTextStyle()
                              .balooBhaijaan2
                              .w500
                              .white
                              .bodyMedium14)),
                ),
                20.sizedBoxHeight,
                Row(
                  children: [
                    Text("الاسئلة",
                        style:
                            const AppTextStyle().balooBhaijaan2.w600.bodyLarge16),
                    AppSize.s6.sizedBoxWidth,
                    const Icon(Icons.error,
                        color: AppColors.primaryColor, size: 20),
                  ],
                ),
                AppSize.s20.sizedBoxHeight,
                BlocListener<SkillStaticsBloc, SkillStaticsState>(
                  listener: (context, state) {
                    switch (state.failsSkillsQuestionsStates) {
                      case RequestStates.loading:
                        showLoadingDialog(context);
                        break;
                      case RequestStates.error:
                        Navigator.pop(context);
                        showSnackBar(
                            description: state.failsSkillsQuestionsErrorMessage,
                            state: ToastStates.error,
                            context: context);
                        break;
                      case RequestStates.loaded:
                        // Navigator.pop(context);
                        break;
                      default:
                    }
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: AppSize.s12.responsiveSize,
                            backgroundColor:
                                AppColors.primaryColor2.withOpacity(.5),
                            child: Center(
                              child: CircleAvatar(
                                radius: AppSize.s8.responsiveSize,
                                backgroundColor: AppColors.primaryColor2,
                                child: Icon(Icons.circle,
                                    color: AppColors.primaryColor2,
                                    size: AppSize.s8.responsiveSize),
                              ),
                            ),
                          ),
                          AppSize.s10.sizedBoxWidth,
                          Expanded(
                            child: Container(
                                padding:
                                    EdgeInsets.all(AppPadding.p20.responsiveSize),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(AppConstants
                                      .appBorderRadiusR20.responsiveSize),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        widget.getFailsSkillsWithQuestionsParameters.failQuestions!.questions[index].questionText??"",
                                        style:
                                            const AppTextStyle()
                                                .blue
                                                .s16
                                                .bodyMedium14
                                                .copyWith(fontFamily: 'NewFont'),

                                        textAlign: TextAlign.center),
                                    if (AppReference.userIsChild()) ...[
                                      AppSize.s20.sizedBoxHeight,
                                      DefaultButtonWidget(
                                          textVerticalPadding: 2,
                                          frontIcon: AppIconsAssets.sRefresh,
                                          label: "حل السؤال مرةً أخرى",
                                          onPressed: () {
                                            RouteManager.rPushReplacementNamed(
                                              context: context,
                                              rName: AppRoutesNames
                                                  .rSkillsQuestionScreen,
                                              arguments: widget.getFailsSkillsWithQuestionsParameters
                                              ,
                                            );
                                          })
                                    ]
                                  ],
                                )),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        AppSize.s20.sizedBoxHeight,
                    itemCount: widget.getFailsSkillsWithQuestionsParameters.failQuestions!.questions.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                )
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }
}
