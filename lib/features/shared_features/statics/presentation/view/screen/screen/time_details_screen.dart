part of '../../../../statics.dart';


class TimeDetailsScreen extends StatefulWidget {
  final int childId;

  const TimeDetailsScreen({super.key,  required this.childId});

  @override
  State<TimeDetailsScreen> createState() => _TimeDetailsScreenState();
}

class _TimeDetailsScreenState extends State<TimeDetailsScreen> {
  DateTime selectedStartDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime selectedEndDate = DateTime.now();
  @override
  void initState() {
    context.read<StaticsBloc>().add(GetTimeInAppEvent(
        timeInAppInputs: TimeInAppInputs(
          startDate: selectedStartDate,
          endDate: selectedEndDate,
          childId: widget.childId ,
        )));    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width:  !AppReference.isPortrait(context)
                ? AppReference.deviceWidth(context) * 0.6
                : AppReference.deviceWidth(context),
            child: Column(
              children: [
                const HeaderForMore(
                  title: 'وقتي في استخدام التطبيق',
                  haveIcon: true,
                ),
               AppSize.s30.sizedBoxHeight,
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppPadding.p12.responsiveHeight,
                      horizontal: AppPadding.p30.responsiveWidth,
                    ),
                    width: AppReference.deviceWidth(context),
                    decoration:
                    ShapeDecoration(
                      color: AppColors.primaryColor2,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 5.responsiveWidth,
                          color: AppColors.warningColor,
                        ),
                        borderRadius: BorderRadius.circular(
                            AppConstants.appBorderRadiusR25.responsiveSize),
                      ),
                    ),
                    child:
                    LayoutBuilder(builder: (context, constraints) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: AppPadding.p10.responsiveWidth),
                                  child: SvgPicture.asset(
                                    AppIconsAssets.sCalender,
                                    width: AppSize.s20.responsiveSize,
                                    height: AppSize.s20.responsiveHeightRatio,
                                  )
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.8,
                                child: Column(
                                  children: [
                                    CustomInkWell(
                                      onTap: ()  async {
                                        final DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: selectedStartDate,
                                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null && pickedDate != selectedStartDate) {
                                          setState(() {
                                            selectedStartDate = pickedDate;
                                          });
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              "من : ${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}",

                                              style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: AppColors.white,
                                            size: AppSize.s16.responsiveSize,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: AppColors.textColor6,
                                      thickness: 1,
                                    ),
                                    CustomInkWell(
                                      onTap: ()  async {
                                        final DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: selectedEndDate,
                                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null && pickedDate != selectedEndDate) {
                                          setState(() {
                                            selectedEndDate = pickedDate;
                                          });
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              "إلى : ${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}",

                                              style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: AppColors.white,
                                            size: AppSize.s16.responsiveSize,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          AppSize.s10.sizedBoxHeight,
                          DefaultButtonWidget(
                            label: "اختيار",
                            onPressed: (){
                              context.read<StaticsBloc>().add(GetTimeInAppEvent(
                                  timeInAppInputs: TimeInAppInputs(
                                    startDate: selectedStartDate,
                                    endDate: selectedEndDate,
                                    childId: widget.childId,
                                  )));
                            },
                            borderColor: AppColors.white,
                            elevation: 0,
                            buttonColor: AppColors.primaryColor2,
                            textVerticalPadding: 2,
                          ),
                        ],
                      );
                    })
                ),
                AppSize.s30.sizedBoxHeight,
                SizedBox(
                    height: AppReference.deviceHeight(context) *
                        0.2.responsiveHeightRatio,
                    width: AppReference.deviceWidth(context) * 0.5,
                    child: BlocBuilder<StaticsBloc, StaticsState>(
                      builder: (context, state) {
                        switch (state.getTimeInAppStates) {
                          case RequestStates.loading:
                            return LoadingShimmerStructure(
                              height: AppReference.deviceHeight(context) *
                                  0.25.responsiveHeightRatio,
                              width: double.infinity,
                            );
                          case RequestStates.loaded:
                            return  SelectedTimeInApp(

                              hours:'${state.timeInAppdata!.inTimeRange.hours}' ,
                              minutes:'${state.timeInAppdata!.inTimeRange.minutes}',
                            );
                          case RequestStates.error:
                            return Text(state.geTimeInAppMessage,style: AppTextStyle.errorTextStyle12,);
                          default:
                            return const SizedBox();
                        }
                      },
                    )
                ),
              ],
            ),
          ),
        ),
      )).paddingBody(),
    );
  }
}

class SelectedTimeInApp extends StatelessWidget {
  final String hours;
  final String minutes;
  const SelectedTimeInApp({
    super.key, required this.hours, required this.minutes,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
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
                    style:AppReference.isPortrait(context)?
                    const AppTextStyle().w600.bodyMedium14:
                    const AppTextStyle().w600.bodyLarge16
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
                height: constraints.maxHeight * 0.6,
                child: LayoutBuilder(builder: (context, consRow) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: consRow.maxWidth * 0.4,
                        height: consRow.maxHeight,
                        child: BaseCountTimeItem(
                          height: AppReference.isPortrait(context)?AppSize.s56:AppSize.s80,
                          width: AppReference.isPortrait(context)?AppSize.s46:AppSize.s30,
                          time: AppReference.userIsGuest() ? '0' : hours,
                          timeType: 'ساعة',
                        ),
                      ),
                      (constraints.maxHeight * 0.02).sizedBoxHeight,
                      SizedBox(
                        width: consRow.maxWidth * 0.4,
                        height: consRow.maxHeight,
                        child: BaseCountTimeItem(
                          height: AppReference.isPortrait(context)?AppSize.s56:AppSize.s80,
                          width: AppReference.isPortrait(context)?AppSize.s46:AppSize.s30,
                          time: AppReference.userIsGuest() ? '0' : minutes,
                          timeType: 'دقيقة',
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

