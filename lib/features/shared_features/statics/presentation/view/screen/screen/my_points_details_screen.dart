part of '../../../../statics.dart';


class MyPointsDetailsScreen extends StatelessWidget {
  const MyPointsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: ResponsiveWidgetForTablet(
          mobile: Column(
            children: [
              const HeaderForMore(
                title: "نقاطي الحالية",
                haveIcon: false,
              ),
              AppSize.s30.sizedBoxHeight,
              // const MyCurrentPointsWidget(),
              AppSize.s30.sizedBoxHeight,
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.circular(AppConstants.appBorderRadiusR20)),
                child: ExpansionTile(
                    collapsedShape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Row(
                      children: [
                        SvgPicture.asset(AppIconsAssets.sPointsReward),
                        AppSize.s10.sizedBoxWidth,
                        Text(
                          'كيف يمكنني ان استخدم نقاطي',
                          style: const AppTextStyle()
                              .balooBhaijaan2
                              .w600
                              .black
                              .bodyMedium14,
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Text(
                        "كيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطي",
                        style:
                            const AppTextStyle().balooBhaijaan2.w500.black.bodySmall12,
                      ).paddingBody()
                    ]),
              ),
              AppSize.s30.sizedBoxHeight,
              Row(
                children: [
                  AppSize.s20.sizedBoxWidth,
                  SvgPicture.asset(AppIconsAssets.sHistory),
                  AppSize.s10.sizedBoxWidth,
                  Text(
                    'سجل استخدامي للنقاط',
                    style: const AppTextStyle().balooBhaijaan2.w600.black.bodyLarge16,
                  ),
                ],
              ),
              10.sizedBoxHeight,
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p18.responsiveWidth,
                    vertical: AppPadding.p40.responsiveHeight),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.circular(AppConstants.appBorderRadiusR20)),
                child: ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context, index) => const PointsWidget(),
                    separatorBuilder: (context, index) =>
                        AppSize.s10.sizedBoxHeight,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3),
              )
            ],
          ),
          tablet: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderForMore(
                title: "نقاطي الحالية",
                haveIcon: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppReference.deviceWidth(context)*0.3,
                     height: AppReference.deviceHeight(context)*0.8,
                    child: Column(
                      children: [
                         // MyCurrentPointsWidget(
                         //  height: AppReference.deviceHeight(context)*0.2),
                        AppSize.s30.sizedBoxHeight,
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                              BorderRadius.circular(AppConstants.appBorderRadiusR20)),
                          child: ExpansionTile(
                              collapsedShape: const ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              shape: const ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              title: Row(
                                children: [
                                  SvgPicture.asset(AppIconsAssets.sPointsReward),
                                  AppSize.s10.sizedBoxWidth,
                                  Text(
                                    'كيف يمكنني ان استخدم نقاطي',
                                    style: const AppTextStyle()
                                        .balooBhaijaan2
                                        .w600
                                        .black
                                        .bodyLarge16.copyWith(
                                      fontSize: 12.responsiveFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Text(
                                  "كيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطيكيف يمكنني ان استخدم نقاطي كيف يمكنني ان استخدم نقاطي",
                                  style:
                                  const AppTextStyle().balooBhaijaan2.w500.black.bodySmall12.copyWith(
                                    fontSize: 10.responsiveFontSize,

                                  ),
                                ).paddingBody()
                              ]),
                        ),
                      ],
                    ),
                  ),
                  AppSize.s60.sizedBoxWidth,
                  SizedBox(
                    width: AppReference.deviceWidth(context)*0.4,
                      height: AppReference.deviceHeight(context)*0.8,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppSize.s20.sizedBoxWidth,
                            SvgPicture.asset(AppIconsAssets.sHistory),
                            AppSize.s10.sizedBoxWidth,
                            Text(
                              'سجل استخدامي للنقاط',
                              style: const AppTextStyle().balooBhaijaan2.w600.black.bodyLarge16.copyWith(
                                fontSize: 12.responsiveFontSize,
                              ),
                            ),
                          ],
                        ),
                        10.sizedBoxHeight,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p18.responsiveWidth,
                              vertical: AppPadding.p40.responsiveHeight),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                              BorderRadius.circular(AppConstants.appBorderRadiusR20)),
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => const PointsWidget(),
                              separatorBuilder: (context, index) =>
                              AppSize.s10.sizedBoxHeight,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3),
                        )
                      ],
                    ),
                  )

                ],
              ),


            ],
          ),
        ),
      )).paddingBody(),
    );
  }
}

class PointsWidget extends StatelessWidget {
  const PointsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20.responsiveWidth,
          vertical: AppPadding.p14.responsiveHeight),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize),
        border: Border.all(color: AppColors.textColor6, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الأستخدام الأول",
            style: const AppTextStyle().balooBhaijaan2.w500.black.bodySmall12.copyWith(
              fontSize: AppFontSize.sp12.responsiveFontSize,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              "2024-5-02 11:00 AM",
              style: const AppTextStyle()
                  .balooBhaijaan2
                  .w400
                  .bodySmall12
                  .copyWith(
                      color: AppColors.textColor4,
                      fontSize: AppFontSize.sp10.responsiveFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
