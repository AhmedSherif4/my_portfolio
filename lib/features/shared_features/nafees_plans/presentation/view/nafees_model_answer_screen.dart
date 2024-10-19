part of '../../nafees_plans.dart';

class AnswerBuild extends StatefulWidget {
  final NafeesExamResults nafeesExamResults;

  const AnswerBuild({
    super.key, required this.nafeesExamResults,
  });

  @override
  State<AnswerBuild> createState() => AnswerBuildState();
}

class AnswerBuildState extends State<AnswerBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: AppReference.deviceHeight(context) *
                  0.06.responsiveHeightRatio,
              child: LayoutBuilder(builder: (context, constrains) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      AppImagesAssets.sLogoWithoutName,
                      width: constrains.maxWidth * 0.2,
                      height: constrains.maxHeight * 0.7,
                      fit: BoxFit.cover,
                    ),
                    AppSize.s10.sizedBoxWidth,
                    TextWithBackGroundColor(
                      backgroundColor:
                      AppColors.primaryColor.withOpacity(.1),
                      text: "ملخص الاختبار",
                      width: constrains.maxWidth * 0.6,
                      height: constrains.maxHeight * 0.7,
                      verticalPadding: 0,
                      textColor: AppColors.textColor4,
                    ),
                    const Spacer(),
                    TextButtonWidget(
                      text: "حسنا!",
                      textColor: AppColors.primaryColor2,
                      fontSize: AppReference.deviceIsTablet?AppFontSize.sp16:AppFontSize.sp14,
                      onPressed: () {
                        RouteManager.rPopRoute(context);
                      },
                    ),
                  ],
                );
              }),
            ).paddingBody(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10.responsiveSize, vertical: AppPadding.p10.responsiveSize),
              margin: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10.responsiveSize,),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR25.responsiveSize),
                  color: AppColors.white
              ),
              child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIconsAssets.sNafeesResult,
                    ),
                    AppSize.s10.sizedBoxWidth,
                    Text(
                      "نتيجتك هي",
                      style: AppTextStyle().w500.bodyLarge16,
                    ),
                    AppSize.s10.sizedBoxWidth,
                    Text(
                      "${widget.nafeesExamResults.trueAnswersCount}/${widget.nafeesExamResults.trueAnswersCount+widget.nafeesExamResults.falseAnswersCount}",
                      style: AppTextStyle().w500.bodyMedium14,
                    ),
                  ]
              ),

            ),
            AppSize.s20.sizedBoxHeight,
            Expanded(
              child: BlocBuilder<NafeesBloc, NafeesState>(
                builder: (context, state) {
                  switch (state.getNafeesModelAnswersState) {
                    case RequestStates.loaded:
                      return state.nafeesModelAnswers.answers!.isEmpty
                          ? Center(
                        child: Text(
                          'لم تقم بحل هذا الاختبار بعد',
                          style: AppTextStyle.titleSmall18,
                        ),
                      )
                          :       ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.nafeesModelAnswers.answers!.length,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                        AppColors.secondaryColor,
                                        child: Text(
                                            "${index + 1}",
                                            style: const AppTextStyle()
                                                .w600.white
                                                .bodyMedium14),
                                      ),
                                      AppSize.s10.sizedBoxWidth,
                                      QuestionsText(currentQuestion:
                                      state.nafeesModelAnswers.answers![index].nafeesQuestionEntity,
                                      ),
                                    ],
                                  ).paddingBody(),

                                  if (state.nafeesModelAnswers.answers![index].nafeesQuestionEntity.img != null) ...[
                                    QuestionItemForNafees(
                                        currentQuestion:state.nafeesModelAnswers.answers![index].nafeesQuestionEntity),
                                  ],
                                  CustomInkWell(
                                    onTap: () {
                                      showHintOfQuestionsDialog(
                                          context: context,
                                          descriptionText: state.nafeesModelAnswers.answers![index].nafeesQuestionEntity.description,
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          AppIconsAssets.sAdultHint,
                                          width: 25.responsiveSize,
                                          height: 25.responsiveSize,
                                        ),
                                        AppSize.s10.sizedBoxWidth,
                                        Text(
                                          AppStrings.hint,
                                          style: const AppTextStyle().w700.bodyMedium14.copyWith(
                                            fontFamily: 'NewFont',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).paddingBody(),

                                  // Row(
                                  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       // HintWidgetForNafees(currentQuestion: state.nafeesModelAnswers.answers![index].nafeesQuestionEntity,),
                                  //      const Spacer(),
                                  //       Text(
                                  //         "1/1",
                                  //         style: AppTextStyle().w500.bodyLarge16,
                                  //       ),
                                  //       AppSize.s10.sizedBoxWidth,
                                  //       Text(
                                  //         "درجة",
                                  //         style: AppTextStyle().w500.bodyMedium14,
                                  //       )
                                  //     ]
                                  // ),
                                  ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (answerContext, answerIndex) {
                                      return Container(
                                        width: AppReference.deviceWidth(
                                            context) *
                                            0.9,
                                        padding:
                                        EdgeInsets.all(10.responsiveSize),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10.responsiveSize),
                                          color: (state.nafeesModelAnswers.answers![index].successId ==
                                              state.nafeesModelAnswers.answers![index].nafeesQuestionEntity.answers[answerIndex].id) &&
                                              state.nafeesModelAnswers.answers![index].isTrue=="0"
                                              ? AppColors.failColor
                                              : state.nafeesModelAnswers.answers![index].nafeesQuestionEntity.answers[answerIndex].isTrue=="1"
                                              ? AppColors.successColor
                                              : AppColors.textColor6,
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                              AppColors.white,
                                              child: Text(
                                                  "${answerIndex + 1}",
                                                  style: const AppTextStyle()
                                                      .w600
                                                      .bodyMedium14),
                                            ),
                                            AppSize.s10.sizedBoxWidth,
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  state.nafeesModelAnswers.answers![index].nafeesQuestionEntity
                                                      .answers[answerIndex].option??"",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: const AppTextStyle()
                                                      .s12
                                                      .w700
                                                      .bodyMedium14.copyWith(
                                                    color: (state
                                                        .nafeesModelAnswers.answers![index]
                                                        .successId ==
                                                        state
                                                            .nafeesModelAnswers.answers![
                                                        index].nafeesQuestionEntity.answers[
                                                        answerIndex
                                                        ].id) &&
                                                        state.nafeesModelAnswers.answers![index].isTrue=="0"
                                                        ? AppColors.white
                                                        : state.nafeesModelAnswers.answers![index].nafeesQuestionEntity
                                                        .answers[
                                                    answerIndex]
                                                        .isTrue=="1"
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (answerContext, answerIndex) =>
                                    AppSize.s10.sizedBoxHeight,
                                    itemCount: state
                                        .nafeesModelAnswers.answers![index]
                                        .nafeesQuestionEntity
                                        .answers
                                        .length,
                                  ).paddingBody(top: 0),

                                ]
                            );
                          });
                    case RequestStates.loading:
                      return const LoadingShimmerList();
                    case RequestStates.error:
                      return CustomErrorWidget(errorMessage: state.getNafeesModelAnswersPlansMessage);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}