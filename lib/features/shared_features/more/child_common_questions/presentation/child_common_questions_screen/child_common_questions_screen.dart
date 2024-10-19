part of '../../child_common_questions.dart';

class ChildCommonQuestionsScreen extends StatelessWidget {
  const ChildCommonQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderForMore(
                title: AppStrings.commonQuestions,
              ).paddingBody(),
              AppSize.s30.sizedBoxHeight,
              SvgPicture.asset(AppIconsAssets.sCommonQuistion).paddingBody(),
              AppSize.s30.sizedBoxHeight,
              BlocBuilder<ChildCommonQuestionsBloc, ChildCommonQuestionsState>(
                builder: (context, state) {
                  switch (state.getAllQuestionsState) {
                    case RequestStates.loading:
                      return const LoadingShimmerList();
                    case RequestStates.loaded:
                      if (state.allQuestions.isEmpty) {
                        return SizedBox(
                          height: AppReference.deviceHeight(context) * .5,
                          child: const Center(
                            child: EmptyListWidgets(
                                message: AppStrings.noQuestionNow),
                          ),
                        );
                      } else {
                        return
                          (AppReference.deviceIsTablet && !AppReference.isPortrait(context))?
                  MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  shrinkWrap: true,
                  itemCount: state.allQuestions.length,
                  physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _CommonQuestionItem(
                                question: state.allQuestions[index].question,
                                answer: state.allQuestions[index].answer
                              );
                            },):
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.allQuestions.length,
                            itemBuilder: (context, index) {
                              return _CommonQuestionItem(
                                question: state.allQuestions[index].question,
                                answer: state.allQuestions[index].answer,
                              );
                            },
                          );
                      }
                    case RequestStates.error:
                      return CustomErrorWidget(
                        errorMessage: state.getAllQuestionMessage,
                        onRefresh: () async {
                          context
                              .read<ChildCommonQuestionsBloc>()
                              .add(GetAllChildCommonQuestionsEvent());
                        },
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommonQuestionItem extends StatelessWidget {
  final String question;
  final String answer;

  const _CommonQuestionItem(
      {required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.responsiveSize,
        vertical: 10.responsiveSize,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor3,
        borderRadius: BorderRadius.circular(20.responsiveSize),
        border: Border.all(
          color: AppColors.secondaryColor3,
          width: 1.responsiveSize,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const AppTextStyle().w500.white.bodySmall12.copyWith(
            height: 2,
          ),
          textAlign: TextAlign.justify,
        ),
        textColor: AppColors.textColor4,
        collapsedTextColor: AppColors.textColor4,
        iconColor: AppColors.white,
        collapsedIconColor: AppColors.white,
        childrenPadding: EdgeInsets.all(20.responsiveSize),
        controlAffinity: ListTileControlAffinity.platform,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.responsiveSize),
        ),
        collapsedShape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.responsiveSize),
        ),

        children: [
          Text(
            answer,
            style: const AppTextStyle().w500.white.bodySmall12.copyWith(
              height: 2,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

