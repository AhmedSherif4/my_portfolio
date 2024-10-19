part of '../../../statics.dart';


class FinishSubjectsPercentageItem extends StatelessWidget {
  final num index;
  final String subjectName;
  final double percent;

  const FinishSubjectsPercentageItem(
      {super.key,
      required this.index,
      required this.subjectName,
      required this.percent});

  Color _itemColor(double percent) {
    if (percent >= 0 && percent < 50) {
      return AppColors.failColor;
    } else if (percent >= 50 && percent < 75) {
      return AppColors.warningColor;
    } else {
      return AppColors.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.07.responsiveHeightRatio,
      width: AppReference.deviceWidth(context),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextWithBackGroundColor(
                    text: '$index',
                    verticalPadding: 0,
                    isOneLine: true,
                    horizontalPadding: 0,
                    textColor: AppColors.primaryColor,
                    backgroundColor: AppColors.textColor6,
                  ),
                ),
                10.sizedBoxWidth,
                Expanded(
                  flex: 9,
                  child: Text(
                    subjectName,
                    textAlign: TextAlign.start,
                    style: AppReference.themeData.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 15.responsiveWidth,
                    ),
                    height: 20.responsiveHeight,
                    decoration: BoxDecoration(
                        color: AppColors.textColor6,
                        borderRadius: BorderRadius.circular(
                            AppConstants.appBorderRadiusR10.responsiveSize)),
                    child: FractionallySizedBox(
                      alignment: AlignmentDirectional.centerStart,
                      widthFactor: percent <= 0 ? 0 : (percent / 100),
                      child: Container(
                        decoration: BoxDecoration(
                            color: _itemColor(percent),
                            borderRadius: BorderRadius.circular(AppConstants
                                .appBorderRadiusR15.responsiveSize)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: Text(
                      percent <= 0 ? '0%' : '$percent%',
                      style:
                          AppReference.themeData.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.responsiveFontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FinishSubjectsPercentageTabletItem extends StatelessWidget {
  final num index;
  final String subjectName;
  final double percent;

  const FinishSubjectsPercentageTabletItem(
      {super.key,
        required this.index,
        required this.subjectName,
        required this.percent});

  Color _itemColor(double percent) {
    if (percent >= 0 && percent < 50) {
      return AppColors.failColor;
    } else if (percent >= 50 && percent < 75) {
      return AppColors.warningColor;
    } else {
      return AppColors.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.07.responsiveHeightRatio,
      width: AppReference.deviceWidth(context),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.textColor6,
              radius: AppConstants.appBorderRadiusR10.responsiveSize,
              child:  FittedBox(
              child: Text(
              '$index',
              textAlign: TextAlign.center,
              textDirection: AppConstants.arabicDirection(index.toString()),
              style: const AppTextStyle().white.w500.bodySmall12.copyWith(
              color:AppColors.primaryColor,
              ),
              ),              )),
              10.sizedBoxWidth,
              Expanded(
                flex: 6,
                child: Text(
                  subjectName,
                  textAlign: TextAlign.start,
                  style: AppReference.deviceIsTablet?const AppTextStyle().bodyMedium14.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.responsiveFontSize,
                  ):AppReference.themeData.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  margin: EdgeInsetsDirectional.symmetric(
                    horizontal: 15.responsiveWidth,
                  ),
                  height: 20.responsiveHeight,
                  decoration: BoxDecoration(
                      color: AppColors.textColor6,
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR10.responsiveSize)),
                  child: FractionallySizedBox(
                    alignment: AlignmentDirectional.centerStart,
                    widthFactor: percent <= 0 ? 0 : (percent / 100),
                    child: Container(
                      decoration: BoxDecoration(
                          color: _itemColor(percent),
                          borderRadius: BorderRadius.circular(AppConstants
                              .appBorderRadiusR15.responsiveSize)),
                    ),
                  ),
                ),
              ),

         FittedBox(
                  child: Text(
                    percent <= 0 ? '0%' : '$percent%',
                    style:
                    AppReference.themeData.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.responsiveFontSize,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


class FinishSubjectsPercentageBuilder extends StatelessWidget {
  const FinishSubjectsPercentageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticsBloc, StaticsState>(
      builder: (context, state) {
        if(state.bestSubjectsStates == RequestStates.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if(state.bestSubjectsStates == RequestStates.error) {
          return CustomErrorWidget(
            errorMessage: state.bestSubjectsErrorMessage,
          );
        }else{
          if (state.bestSubjects.isNotEmpty) {
            return AppReference.deviceIsTablet&&!AppReference.isPortrait(context)? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.responsiveWidth,
                  mainAxisSpacing: 10.responsiveHeight,
                  childAspectRatio: 8 /1.5),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FinishSubjectsPercentageTabletItem(
                  index: index + 1,
                  subjectName: state.bestSubjects[index].subjectName,
                  percent: state.bestSubjects[index].answersSumPoint == 0 ||
                      state.bestSubjects[index].lessonQuestionSumPoint == 0
                      ? 0
                      : (state.bestSubjects[index].answersSumPoint /
                      state.bestSubjects[index].lessonQuestionSumPoint)
                      .ceilToDouble(),
                );
              },
              itemCount: state.bestSubjects.length,
            ): ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FinishSubjectsPercentageItem(
                  index: index + 1,
                  subjectName: state.bestSubjects[index].subjectName,
                  percent: state.bestSubjects[index].answersSumPoint == 0 ||
                      state.bestSubjects[index].lessonQuestionSumPoint == 0
                      ? 0
                      : (state.bestSubjects[index].answersSumPoint /
                      state.bestSubjects[index].lessonQuestionSumPoint)
                      .ceilToDouble(),
                );
              },
              separatorBuilder: (context, index) => 20.sizedBoxHeight,
              itemCount: state.bestSubjects.length,
            );
          } else {
            return const EmptyListWidgets(message: 'لا يوجد مواد منجزة حالياً');
          }
        }

      },
    );
  }
}
