part of '../../nafees_plans.dart';


class NafeesSubjectData extends Equatable {
  final NafeesPlansEntity nafeesPlans;
  final NafeesExamQuestionsAnswersInputs? nafeesExamQuestionsAnswersInputs;
  final List<NafeesQuestionEntity>? nafeesQuestionEntity;
  final int childId;
  final int? index;
  final int? duration;
  final String? piece;
  final bool playDuration;

  const NafeesSubjectData( {
    required this.nafeesPlans,
    required this.childId,
    required this.playDuration,
    this.index,
    this.duration,
    this.piece,
    this.nafeesQuestionEntity,
    this.nafeesExamQuestionsAnswersInputs
  });

  @override
  List<Object> get props => [nafeesPlans, childId];
}

class NafeesSubjectScreen extends StatelessWidget {
  final NafeesSubjectData nafeesSubjectData;
  const NafeesSubjectScreen({super.key, required this.nafeesSubjectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AppReference.childIsPrimary()?Container(
            height: AppReference.deviceHeight(context),
            width: AppReference.deviceWidth(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImagesAssets.sPrimaryChildBackground),
                  fit: BoxFit.fill,
                )),
            child: _SubjectScreenForNafees(nafeesSubjectData: nafeesSubjectData,),
          ):_ChildSubjectScreenForNafees(nafeesSubjectData: nafeesSubjectData,)),
    );
  }
}

class _SubjectScreenForNafees extends StatelessWidget {
  final NafeesSubjectData nafeesSubjectData;
  const _SubjectScreenForNafees({
    required this.nafeesSubjectData,
  });
  @override
  Widget build(BuildContext context) {
    navigateToNafeesExamsScreen() {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rNafeeseExamsScreen,
          arguments:nafeesSubjectData
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
              children: [
                Container(
                  width: AppReference.deviceWidth(context),
                  height: AppReference.deviceIsTablet?
                  AppReference.deviceHeight(context) *
                      0.08.responsiveHeightRatio
                      :AppReference.deviceHeight(context) *
                      0.11.responsiveHeightRatio,
                  child: LayoutBuilder(builder: (context, constrains) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constrains.maxWidth * 0.05,
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.22,
                          child: SvgPicture.asset(
                            AppImagesAssets.sNafes,
                          ),
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.05,
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.6,
                          child: Text(
                            nafeesSubjectData.nafeesPlans.description,
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
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImagesAssets.sExamsss,
                      // width: 50.responsiveWidth,
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
                ).paddingBody(),
                OrientationItem(
                    portraitWidget: _NafeesSubjectPortraitView(nafeesPlans: nafeesSubjectData.nafeesPlans,onTap: (){
                      if(nafeesSubjectData.nafeesPlans.isSubscribed){
                        navigateToNafeesExamsScreen();
                      }
                    }),
                    landscapeWidget: _NafeesSubjectLandscapeView(nafeesPlans: nafeesSubjectData.nafeesPlans,onTap:(){
                if(nafeesSubjectData.nafeesPlans.isSubscribed){
                navigateToNafeesExamsScreen();
                }
                })),
                AppSize.s10.sizedBoxHeight,

              ],
            ),
          ),
        ),
        if(!nafeesSubjectData.nafeesPlans.isSubscribed)
        _NafeesPaymentButton(nafeesSubjectData: nafeesSubjectData)


      ],
    );
  }
}

class _NafeesPaymentButton extends StatelessWidget {
  const _NafeesPaymentButton({
    required this.nafeesSubjectData,
  });

  final NafeesSubjectData nafeesSubjectData;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
 if(nafeesSubjectData.nafeesPlans.price == 0){
   RouteManager.rPushNamedAndRemoveUntil(
     context: context,
     rName: AppRoutesNames.rPaymentSuccessForNafeesScreen,
     arguments: RequiredDataAfterNafeesPayment(
       isNafees: true,
       totalPrice: nafeesSubjectData.nafeesPlans.price,
       nafeesId: nafeesSubjectData.nafeesPlans.id,
       childId: nafeesSubjectData.childId,
     )
   );
 }else{
   PaymentService().initialize(
     context: context,
     url:'${EndPoints.baseUrl}/api/pay/nafis?child_id=${nafeesSubjectData.childId}&nafis_id=${nafeesSubjectData.nafeesPlans.id}',
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
                      '(${nafeesSubjectData.nafeesPlans.oldPrice} ر.س)',
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
                  'سعر الباقة  الحالي  :    (${nafeesSubjectData.nafeesPlans.price} ر.س)',
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

class NafeesPlansExamsWidget extends StatelessWidget {
  const NafeesPlansExamsWidget({
    super.key,
    required this.nafeesExamsData, required this.index, required this.isSubscribed,
  });

  final NafeesExamsData nafeesExamsData;
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
          gradient: AppGradientColors.nafeesGradient
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
            nafeesExamsData.name,
            style: const AppTextStyle().white.s15.titleSmall18,
          ),
          const Spacer(),

            if(isSubscribed)...[
              Row(
                children: [
                  Text(
                    'اكتشف !',
                    style: const AppTextStyle().white.s14.bodySmall12,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: AppSize.s12.responsiveSize,
                  ),
                ],
              ),
            ],
          if(!isSubscribed)...[
            Icon(
              Icons.lock,
              color: AppColors.white,
              size: AppSize.s16.responsiveSize,
            ),
          ]


        ],
      ),
    ).paddingBody();
  }
}

class _ChildSubjectScreenForNafees extends StatelessWidget {
  final NafeesSubjectData nafeesSubjectData;
  const _ChildSubjectScreenForNafees({
  required this.nafeesSubjectData});


  @override
  Widget build(BuildContext context) {
    navigateToNafeesExamsScreen() {
      RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rNafeeseExamsScreen,
          arguments:nafeesSubjectData
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
                            AppImagesAssets.sNafes,
                          ),
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.05,
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.6,
                          child: Text(
                            nafeesSubjectData.nafeesPlans.description,
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
                      // width: 50.responsiveWidth,
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

                OrientationItem(
                    portraitWidget: _NafeesSubjectPortraitView(nafeesPlans: nafeesSubjectData.nafeesPlans,onTap: (){
                      if(nafeesSubjectData.nafeesPlans.isSubscribed){
                        navigateToNafeesExamsScreen();
                      }
                    }),
                    landscapeWidget: _NafeesSubjectLandscapeView(nafeesPlans: nafeesSubjectData.nafeesPlans,onTap: (){
                      if(nafeesSubjectData.nafeesPlans.isSubscribed){
                        navigateToNafeesExamsScreen();
                      }
                    })),


              ],
            ).paddingBody(),
          ),
        ),
        AppSize.s10.sizedBoxHeight,
        if(!nafeesSubjectData.nafeesPlans.isSubscribed)
          _NafeesPaymentButton(nafeesSubjectData: nafeesSubjectData,).paddingBody()
      ],

    );

  }
}

class _NafeesSubjectPortraitView extends StatelessWidget {
  final Function() onTap;
  final NafeesPlansEntity nafeesPlans;
  const _NafeesSubjectPortraitView({
    required this.onTap, required this.nafeesPlans,
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
          child: NafeesPlansExamsWidget(nafeesExamsData: nafeesPlans.examsData[index], index: index,isSubscribed: nafeesPlans.isSubscribed,),
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
      itemCount: nafeesPlans.examsData.length,
    );
  }
}

class _NafeesSubjectLandscapeView extends StatelessWidget {
  final Function() onTap;
  final NafeesPlansEntity nafeesPlans;

  const _NafeesSubjectLandscapeView({
    required this.onTap, required this.nafeesPlans,

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
          child: NafeesPlansExamsWidget(nafeesExamsData: nafeesPlans.examsData[index], index: index,isSubscribed: nafeesPlans.isSubscribed,),
        );
      },
      itemCount: nafeesPlans.examsData.length,
    );
  }
}
