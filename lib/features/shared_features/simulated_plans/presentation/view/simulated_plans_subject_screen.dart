part of '../../simulated_plans.dart';


class SimulatedSubjectData extends Equatable {
  final SimulatedPlansEntity simulatedPlans;
  final List<SimulatedPlansEntity>? simulatedPlansList;
  final SimulatedExamQuestionsAnswersInputs? simulatedExamQuestionsAnswersInputs;
  final List<SimulatedQuestionEntity>? simulatedQuestionEntity;
  final int childId;
  final int? index;
  final int? duration;
  final String? piece;
  final bool playDuration;

  const SimulatedSubjectData( {
    required this.simulatedPlans,
    required this.childId,
    required this.playDuration,
    this.index,
    this.duration,
    this.piece,
    this.simulatedQuestionEntity,
    this.simulatedPlansList,
    this.simulatedExamQuestionsAnswersInputs
  });

  @override
  List<Object> get props => [simulatedPlans, childId];
}

class SimulatedSubjectScreen extends StatelessWidget {
  final SimulatedSubjectData simulatedSubjectData;
  const SimulatedSubjectScreen({super.key, required this.simulatedSubjectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _ChildSubjectScreenForSimulated(simulatedSubjectData: simulatedSubjectData,)),
    );
  }
}

class SimulatedPlansExamsWidget extends StatelessWidget {
  const SimulatedPlansExamsWidget({
    super.key,
    required this.simulatedExamsData, required this.index, required this.isSubscribed,
  });

  final SimulatedExamsData simulatedExamsData;
  final int index;
  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppReference.deviceHeight(context) *
          0.06.responsiveHeightRatio,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10.responsiveSize,
          horizontal: AppPadding.p20.responsiveSize),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              AppConstants.appPaddingR20.responsiveSize),
          color: AppColors.textColor6
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 10.responsiveSize,
            backgroundColor: AppColors.white,
            child: Text(
              "${index + 1}",
              style: const AppTextStyle().s15.titleSmall18,
            ),
          ),
          AppSize.s10.sizedBoxWidth,
          Text(
            simulatedExamsData.name,
            style: const AppTextStyle().s15.titleSmall18,
          ),
          const Spacer(),

            if(isSubscribed)...[
              Row(
                children: [
                  Text(
                    'اكتشف !',
                    style: const AppTextStyle().white.s14.bodySmall12.copyWith(
                      color: AppColors.primary3
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary3,
                    size: AppSize.s12.responsiveSize,
                  ),
                ],
              ),
            ],
          if(!isSubscribed)...[
            Icon(
              Icons.lock,
              color: AppColors.primary3,
              size: AppSize.s16.responsiveSize,
            ),
          ]


        ],
      ),
    ).paddingBody();
  }
}

class _ChildSubjectScreenForSimulated extends StatelessWidget {
  final SimulatedSubjectData simulatedSubjectData;
  const _ChildSubjectScreenForSimulated({
  required this.simulatedSubjectData});


  @override
  Widget build(BuildContext context) {
    navigateToSimulatedExamsScreen() {
      RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rSimulatedeExamsScreen,
          arguments:simulatedSubjectData
      );

    }

    return Column(
      children: [
        const HeaderForMore(
          title: 'الاختبارات المحاكية',
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: AppSize.s10.responsiveWidth),
                  width: AppReference.deviceWidth(context),
                  height: AppReference.deviceIsTablet?
                  AppReference.deviceHeight(context) *
                      0.08.responsiveHeightRatio
                      :AppReference.deviceHeight(context) *
                      0.14.responsiveHeightRatio,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR25.responsiveSize),
                      color: AppColors.textColor6
                  ),
                  child: LayoutBuilder(builder: (context, constrains) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constrains.maxWidth * 0.05,
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.22,
                          child: SvgPicture.asset(
                            AppImagesAssets.sSimulated22,
                          ),
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.05,
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.6,
                          child: Text(
                            simulatedSubjectData.simulatedPlans.description,
                            style: const AppTextStyle()
                                .s10
                                .w500
                                .titleMedium20
                                .copyWith(
                              color: const Color(0xff58340D),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                AppSize.s10.sizedBoxHeight,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImagesAssets.sExamsss,
                      height: AppReference.deviceHeight(context) * 0.03.responsiveHeightRatio,
                    ),
                    AppSize.s10.sizedBoxWidth,
                    Flexible(
                      child: Text(
                        "الاختبارات",
                        style: AppTextStyle.titleSmall18,
                      ),
                    ),
                  ],
                ),
                AppSize.s10.sizedBoxHeight,
                if(simulatedSubjectData.simulatedPlans.examsData.isNotEmpty)...[
                OrientationItem(
                    portraitWidget: _SimulatedSubjectPortraitView(simulatedPlans: simulatedSubjectData.simulatedPlans,onTap: (){
                      if(simulatedSubjectData.simulatedPlans.isSubscribed){
                        navigateToSimulatedExamsScreen();
                      }
                    }),
                    landscapeWidget: _SimulatedSubjectLandscapeView(simulatedPlans: simulatedSubjectData.simulatedPlans,onTap: (){
                      if(simulatedSubjectData.simulatedPlans.isSubscribed){
                        navigateToSimulatedExamsScreen();
                      }
                    })),],
    if(simulatedSubjectData.simulatedPlans.examsData.isEmpty)...[
      const EmptyListWidgets(message: "لا يوجد اختبارات محاكية")
    ]


              ],
            ).paddingBody(),
          ),
        ),
        AppSize.s10.sizedBoxHeight,
        if(!simulatedSubjectData.simulatedPlans.isSubscribed)
          _SimulatedPaymentButton(simulatedSubjectData: simulatedSubjectData,).paddingBody()
      ],

    );

  }
}
class _SimulatedPaymentButton extends StatelessWidget {
  const _SimulatedPaymentButton({
    required this.simulatedSubjectData,
  });

  final SimulatedSubjectData simulatedSubjectData;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {

        if(simulatedSubjectData.simulatedPlans.price == 0){
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rPaymentSuccessForNafeesScreen,
              arguments: RequiredDataAfterNafeesPayment(
                isNafees: false,
                totalPrice:simulatedSubjectData.simulatedPlans.price,
                simulatedId:simulatedSubjectData.simulatedPlans.id,
                childId: simulatedSubjectData.childId,
              )
          );
        }else{
          PaymentService().initialize(
            context: context,
            url: '${EndPoints.baseUrl}/api/pay/tahsilia?child_id=${simulatedSubjectData.childId}&category_id=${simulatedSubjectData.simulatedPlans.id}',
            onError: (String errorMessage) {
              // Handle error or log error
              print('Payment error: $errorMessage');
            },
          );
          final controller = PaymentService().createPaymentController();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(createController: controller),
          ),
        );
        }

      },
      child: Container(
        height: AppReference.deviceHeight(context) *
            0.07.responsiveHeightRatio,
        width: AppReference.deviceWidth(context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary3,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR25.responsiveSize),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'سعر الباقة  قبل الخصم  :    ',
                      style: const AppTextStyle()
                          .s12
                          .titleSmall18
                          .copyWith(color: AppColors.white),
                    ),
                    Text(
                      '(${simulatedSubjectData.simulatedPlans.oldPrice} ر.س)',
                      style: const AppTextStyle()
                          .s12
                          .titleSmall18
                          .copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.white),
                    ),
                  ],
                ),
                Text(
                  'سعر الباقة  الحالي  :    (${simulatedSubjectData.simulatedPlans.price} ر.س)',
                  style: const AppTextStyle()
                      .s12
                      .titleSmall18
                      .copyWith(color: AppColors.white),
                ),
              ],
            ),
            AppSize.s10.sizedBoxWidth,
            Row(
              children: [
                SvgPicture.asset(
                  AppImagesAssets.sSubscriptinoInHome,
                  height: AppReference.deviceHeight(context) * 0.02.responsiveHeightRatio,
                ),
                AppSize.s10.sizedBoxWidth,
                Text(
                  "اشتراك",
                  style: const AppTextStyle().white.titleSmall18,
                ),
              ],
            )
          ],
        ),
      ).paddingBody(),
    );
  }
}

class _SimulatedSubjectPortraitView extends StatelessWidget {
  final Function() onTap;
  final SimulatedPlansEntity simulatedPlans;
  const _SimulatedSubjectPortraitView({
    required this.onTap, required this.simulatedPlans,
  });


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CustomInkWell(
          onTap: () {
            onTap();
          },
          child: SimulatedPlansExamsWidget(simulatedExamsData: simulatedPlans.examsData[index], index: index,isSubscribed: simulatedPlans.isSubscribed,),
        );
      },
      separatorBuilder: (context, index) => Center(
        child: SizedBox(
          width:AppReference.deviceWidth(context) *.5 ,
          child:  Divider(
            color: AppColors.textColor6,
            thickness:  AppSize.s2.responsiveSize,
            height: AppSize.s16.responsiveHeight,
          ),
        ),
      ),
      itemCount: simulatedPlans.examsData.length,
    );
  }
}

class _SimulatedSubjectLandscapeView extends StatelessWidget {
  final Function() onTap;
  final SimulatedPlansEntity simulatedPlans;

  const _SimulatedSubjectLandscapeView({
    required this.onTap, required this.simulatedPlans,

  });


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppConstants.appPaddingR20,
        crossAxisSpacing: AppConstants.appPaddingR20,
        childAspectRatio: 12/2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return   CustomInkWell(
          onTap: () {
            onTap();
          },
          child: SimulatedPlansExamsWidget(simulatedExamsData: simulatedPlans.examsData[index], index: index,isSubscribed: simulatedPlans.isSubscribed,),
        );
      },
      itemCount: simulatedPlans.examsData.length,
    );
  }
}


