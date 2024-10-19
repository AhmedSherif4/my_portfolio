part of '../../../../statics.dart';


class TotalTimeInApp extends StatelessWidget {
  final TimeInAppModel timeInAppdata;
  final bool isStaticsScreen;
  final int childId;

  const TotalTimeInApp({
    super.key,
    this.isStaticsScreen = true,
    required this.timeInAppdata,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomInkWell(
        onTap: AppReference.userIsGuest() ? (){
          AppReference.guestDialogMustLogin(context);
        }:() {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rTimeInAppScreen,
            arguments: childId,
          );
        },
        child: Container(
          decoration: AppConstants.containerDecoration(
            backgroundColor: AppColors.white
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.022,
                vertical: constraints.maxHeight * 0.022),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child:AppReference.deviceIsTablet?FittedBox(
                    fit: BoxFit.scaleDown,
                    child: UnderLinedText(
                      text: AppStrings.timeInApp,
                      textAlign: TextAlign.justify,
                      lineColor: AppColors.textColor4,
                      style:
                      AppReference.isPortrait(context)?
                      const AppTextStyle().w600.bodyMedium14:
                      const AppTextStyle().w600.bodySmall12.copyWith(
                        fontSize: AppFontSize.sp10
                      ),
                    ),
                  )
                  :AppReference .currentOrientation(context) == Orientation.portrait ? UnderLinedText(
                    text: AppStrings.timeInApp,
                    textAlign: TextAlign.justify,
                    lineColor: AppColors.textColor4,
                    style: const AppTextStyle().s11.w600.bodyMedium14,
                  ) : FittedBox(
                    child: UnderLinedText(
                      text: AppStrings.timeInApp,
                      textAlign: TextAlign.justify,
                      lineColor: AppColors.textColor4,
                      style: const AppTextStyle().s11.w600.bodyMedium14,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * (isStaticsScreen ? 0.5 : 0.6),
                  child: LayoutBuilder(builder: (context, consRow) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: consRow.maxWidth * 0.4,
                          height: consRow.maxHeight,
                          child: BaseCountTimeItem(
                            time: AppReference.userIsGuest() ? '0' : '${timeInAppdata.total.hours}',
                            timeType: 'ساعة',
                          ),
                        ),
                        (constraints.maxHeight * 0.02).sizedBoxHeight,
                        SizedBox(
                          width: consRow.maxWidth * 0.4,
                          height: consRow.maxHeight,
                          child: BaseCountTimeItem(
                            time: AppReference.userIsGuest() ? '0' : '${timeInAppdata.total.minutes}',
                            timeType: 'دقيقة',
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                if (isStaticsScreen)...[
                  (constraints.maxHeight * 0.01).sizedBoxHeight,
                  SizedBox(
                    height: constraints.maxHeight * 0.16,
                    child: TextWithIconButton(
                      onTap: () {
                        RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rTimeInAppScreen,
                          arguments: childId,
                        );
                      },
                      text: AppStrings.more,
                    ),
                  ),]
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TotalTimeInAppBuilder extends StatelessWidget {
  final int childId;
  const TotalTimeInAppBuilder({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticsBloc, StaticsState>(
      builder: (context, state) {
        switch (state.getTimeInAppStates) {
          case RequestStates.loading:
            return LoadingShimmerStructure(
              height: AppReference.deviceHeight(context) *
                  0.25.responsiveHeightRatio,
              width: double.infinity,
            );
          case RequestStates.loaded:
            return TotalTimeInApp(timeInAppdata: state.timeInAppdata!,childId:childId ,);
          case RequestStates.error:
            return Text(state.geTimeInAppMessage,style: AppTextStyle.errorTextStyle12,);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
