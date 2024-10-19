part of '../../simulated_plans.dart';

class SimulatedAnswerBuild extends StatefulWidget {
  final SimulatedExamResults simulatedExamResults;

  const SimulatedAnswerBuild({
    super.key, required this.simulatedExamResults,
  });

  @override
  State<SimulatedAnswerBuild> createState() => SimulatedAnswerBuildState();
}

class SimulatedAnswerBuildState extends State<SimulatedAnswerBuild> {
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
                      "${widget.simulatedExamResults.trueAnswersCount}/${widget.simulatedExamResults.trueAnswersCount+widget.simulatedExamResults.falseAnswersCount}",
                      style: AppTextStyle().w500.bodyMedium14,
                    ),
                  ]
              ),

            ),
            AppSize.s20.sizedBoxHeight,
            Expanded(
              child: BlocBuilder<SimulatedBloc, SimulatedState>(
                builder: (context, state) {
                  switch (state.getSimulatedModelAnswersState) {
                    case RequestStates.loaded:
                      return state.simulatedModelAnswers.answers!.isEmpty
                          ? Center(
                        child: Text(
                          'لم تقم بحل هذا الاختبار بعد',
                          style: AppTextStyle.titleSmall18,
                        ),
                      )
                          :       ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.simulatedModelAnswers.answers!.length,
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
                                      state.simulatedModelAnswers.answers![index].simulatedQuestionEntity,
                                      ),
                                    ],
                                  ).paddingBody(),
                                  if (state.simulatedModelAnswers.answers![index].simulatedQuestionEntity.img != null) ...[
                                    QuestionItemForSimulated(
                                        currentQuestion:state.simulatedModelAnswers.answers![index].simulatedQuestionEntity),
                                  ],


                                  CustomInkWell(
                                    onTap: () {
                                      showHintOfQuestionsDialog(
                                          context: context,
                                          descriptionText: state.simulatedModelAnswers.answers![index].simulatedQuestionEntity.description,
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
                                  //       // HintWidgetForSimulated(currentQuestion: state.simulatedModelAnswers.answers![index].simulatedQuestionEntity,),
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
                                          color: (state
                                              .simulatedModelAnswers.answers![index]
                                              .optionId ==
                                              state
                                                  .simulatedModelAnswers.answers![
                                              index].simulatedQuestionEntity.answers[
                                              answerIndex
                                              ].id) &&
                                              state.simulatedModelAnswers.answers![index].isTrue=="0"
                                              ? AppColors.failColor
                                              : state.simulatedModelAnswers.answers![index].simulatedQuestionEntity
                                              .answers[
                                          answerIndex]
                                              .isTrue=="1"
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
                                                  state.simulatedModelAnswers.answers![index].simulatedQuestionEntity
                                                      .answers[answerIndex].option??"",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: const AppTextStyle()
                                                      .s12
                                                      .w700
                                                      .bodyMedium14.copyWith(
                                                    color: (state
                                                        .simulatedModelAnswers.answers![index]
                                                        .optionId ==
                                                        state
                                                            .simulatedModelAnswers.answers![
                                                        index].simulatedQuestionEntity.answers[
                                                        answerIndex
                                                        ].id) &&
                                                        state.simulatedModelAnswers.answers![index].isTrue=="0"
                                                        ? AppColors.white
                                                        : state.simulatedModelAnswers.answers![index].simulatedQuestionEntity
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
                                        .simulatedModelAnswers.answers![index]
                                        .simulatedQuestionEntity
                                        .answers
                                        .length,
                                  ).paddingBody(top: 0),

                                ]
                            );
                          });
                    case RequestStates.loading:
                      return const LoadingShimmerList();
                    case RequestStates.error:
                      return CustomErrorWidget(errorMessage: state.getSimulatedModelAnswersPlansMessage);
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