import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';

import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_strings.dart';
import '../../../../../../config/resources/app_text_style.dart';
import '../../../../../../core/shared_widget/button_widget.dart';
import '../../../../more/presentation/more_widgets/header_for_more.dart';
import '/../../../../../config/resources/app_values.dart';
import '/../../../../../my_app/app_reference.dart';

class NotificationsDetailsScreen extends StatelessWidget {
  const NotificationsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ResponsiveWidgetForTablet(
            mobile: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderForMore(title: AppStrings.notificationsTitle),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("تقديم طلب لعملة",
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: const AppTextStyle().balooBhaijaan2.w500.bodyLarge16),
                    ),
            AppSize.s20.sizedBoxWidth,

            NullableNetworkImage(
              imagePath: "",
              height: AppSize.s100.responsiveHeight,
              width: 128.responsiveWidth,
              notHaveImage: true,
              fit: BoxFit.cover,
            )                ],
                ),
                AppSize.s20.sizedBoxHeight,
                Text(
                  "2024-5-02 11:00 AM",
                  style: const AppTextStyle().balooBhaijaan2.w400.bodySmall12.copyWith(
                    fontSize: AppFontSize.sp10.responsiveFontSize,
                    color: AppColors.textColor4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const NotificationDetailsWidget(),
                AppSize.s20.sizedBoxHeight,
                DefaultButtonWidget(
                  icon: AppIconsAssets.sDeleteNotification,
                  borderColor: Colors.transparent,
                   buttonColor: AppColors.failColor.withOpacity(.1),
                    label: "حذف الاشعار",
                    textStyle: const AppTextStyle().bodyMedium14.copyWith(
                        color: AppColors.failColor,
                    ),
                    elevation: 0,
                    isExpanded: true,
                    onPressed: (){})

              ],
            ).paddingBody(),
            tablet: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderForMore(title: AppStrings.notificationsTitle),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppReference.deviceWidth(context)*0.3,
                      height: AppReference.deviceHeight(context)*0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text("تقديم طلب لعملة",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: const AppTextStyle().balooBhaijaan2.w500.bodyLarge16.copyWith(
                                      fontSize: AppFontSize.sp16.responsiveFontSize
                                    )),
                              ),
                              AppSize.s20.sizedBoxWidth,

                              NullableNetworkImage(
                                imagePath: "",
                                height: AppSize.s100.responsiveHeight,
                                width: 128.responsiveWidth,
                                notHaveImage: true,
                                fit: BoxFit.cover,
                              )                ],
                          ),
                          AppSize.s20.sizedBoxHeight,
                          Text(
                            "2024-5-02 11:00 AM",
                            style: const AppTextStyle().balooBhaijaan2.w400.bodySmall12.copyWith(
                              fontSize:AppReference.deviceIsTablet? AppFontSize.sp12.responsiveFontSize:AppFontSize.sp10.responsiveFontSize,
                              color: AppColors.textColor4,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSize.s20.sizedBoxHeight,
                          DefaultButtonWidget(
                              icon: AppIconsAssets.sDeleteNotification,
                              borderColor: Colors.transparent,
                              buttonColor: AppColors.failColor.withOpacity(.1),
                              label: "حذف الاشعار",
                              textStyle: const AppTextStyle().bodyMedium14.copyWith(
                                fontSize: AppFontSize.sp14.responsiveFontSize,
                                color: AppColors.failColor,
                              ),
                              elevation: 0,
                              isExpanded: true,
                              onPressed: (){})
                        ],
                      ),
                    ),
                    AppSize.s60.sizedBoxWidth,
                    SizedBox(
                      width: AppReference.deviceWidth(context)*0.3,
                      child:const NotificationDetailsWidget(),
                    ),
                  ],
                ),


              ],
            ).paddingBody(),
          ),
        )
   );
  }
}

class NotificationDetailsWidget extends StatelessWidget {
  const NotificationDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p32.responsiveSize),
      margin: EdgeInsets.only(bottom: AppPadding.p10.responsiveSize),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20),
        color: AppColors.white,
      ),
      height: AppReference.deviceHeight(context) / 2,
      width: AppReference.deviceWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تفاصيل الاشعار",style: const AppTextStyle().bodySmall12.copyWith(
              fontSize: AppFontSize.sp12.responsiveFontSize,
              fontWeight:FontWeight.w700),
          ),
          36.sizedBoxHeight,
          Text(
              "تم الموافقة علي طلبكم من قبل الاستاذ محمد احمد وسيتم البدء في اجراءات الانابة مباشرة بعد دفع قيمة الانابة وهي 100 حنية مصري لا غير.",
              style: const AppTextStyle().bodySmall12.copyWith(
                fontSize: AppFontSize.sp12.responsiveFontSize,

              )
          )
        ],
      ),
    );
  }
}
