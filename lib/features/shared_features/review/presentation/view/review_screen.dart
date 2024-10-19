
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_event.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_text_style.dart';
import '../../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../../core/shared_widget/button_widget.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../more/presentation/more_widgets/header_for_more.dart';
import '../../domain/entity/review_entity_outputs.dart';
import '../view_model/review_bloc.dart';
import '../view_model/review_state.dart';
import '/../../../../../config/resources/app_values.dart';
import '/../../../../../my_app/app_reference.dart';

class ReviewDetailsScreen extends StatelessWidget {
  final ReviewEntityOutputs reviewEntityOutputs;
  const ReviewDetailsScreen({super.key, required this.reviewEntityOutputs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: BlocListener<ReviewBloc, ReviewState>(
            listener: (context, state) {
              switch(state.deleteReviewState) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                  break;
                case RequestStates.loaded:
                  RouteManager.rPopRoute(context);
                  // Navigator.pop(context);
                  RouteManager.rPushReplacementNamed(context: context, rName:
                  AppRoutesNames.rReviewScreen,
                  );
                  showSnackBar(
                      description: state.deleteReviewMessage,
                      state: ToastStates.congrats,
                      context: context);
                  break;
                case RequestStates.error:
                  RouteManager.rPopRoute(context);
                  showSnackBar(
                      description: state.deleteReviewMessage,
                      state: ToastStates.error,
                      context: context);
                  break;
                default:
              }

            },
            child: ResponsiveWidgetForTablet(
              mobile: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderForMore(title: "التقييم"),
                    Container(
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
                            reviewEntityOutputs.reviewText!,style: const AppTextStyle().bodySmall12.copyWith(
                              fontSize: AppFontSize.sp12.responsiveFontSize,
                              fontWeight:FontWeight.w700),
                          ),
                          const Spacer(),
                          Text(
                            reviewEntityOutputs.createdAt.toString(),
                            style: const AppTextStyle().balooBhaijaan2.w400.bodySmall12.copyWith(
                              fontSize: AppFontSize.sp10.responsiveFontSize,
                              color: AppColors.textColor4,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    AppSize.s20.sizedBoxHeight,
                    DefaultButtonWidget(
                        icon: AppIconsAssets.sDeleteNotification,
                        borderColor: Colors.transparent,
                        buttonColor: AppColors.failColor.withOpacity(.1),
                        label: "حذف",
                        textStyle: const AppTextStyle().bodyMedium14.copyWith(
                          color: AppColors.failColor,
                        ),
                        elevation: 0,
                        isExpanded: true,
                        onPressed: (){
                          context.read<ReviewBloc>().add(
                            DeleteReviewDataEvent(reviewID: reviewEntityOutputs.id),
                          );
                        }),
                    AppSize.s20.sizedBoxHeight,
                    Container(
                      decoration: BoxDecoration(
                        // color: AppColors.white,
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(
                            20.responsiveSize),
                      ),
                      child: ExpansionTile(
                        title:                         Text(
                          "الرد",
                          style: const AppTextStyle()
                              .w500
                              .bodySmall12
                              .copyWith(
                            color: AppColors.white,
                            height: 2,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor:
                        AppColors.primaryColor2,
                        textColor: AppColors.textColor4,
                        collapsedTextColor:
                        AppColors.textColor4,
                        iconColor: AppColors.white,
                        collapsedIconColor: AppColors.white,
                        //childrenPadding: EdgeInsets.symmetric(horizontal:  10.responsiveSize),
                        controlAffinity:
                        ListTileControlAffinity.platform,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.responsiveSize),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.responsiveSize),
                        ),
                        children: [
                          if (reviewEntityOutputs.response!.isEmpty)
                            Center(
                                child: Text(
                                  "لا يوجد ردود",
                                  style: AppTextStyle.bodyMedium14.copyWith(
                                    color: AppColors.white,
                                  ),
                                )),
                          if (reviewEntityOutputs.response!.isNotEmpty)
                            Container(

                              color: AppColors.backgroundColor,
                              child: Column(
                                children: [
                                  AppSize.s10.sizedBoxHeight,
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical:AppPadding.p10.responsiveSize ,
                                              horizontal: AppPadding.p20.responsiveSize),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: AppPadding.p10.responsiveSize),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                                AppConstants.appBorderRadiusR10),
                                          ),
                                          child: Text(reviewEntityOutputs.response![index],
                                            style: const AppTextStyle().w700.bodyMedium14,
                                            // textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (context, index) =>
                                          const Divider(
                                            color: AppColors.textColor6,
                                            thickness: .5,
                                          ),
                                      // AppSize.s16
                                      //     .sizedBoxHeight,
                                      itemCount: reviewEntityOutputs.response!.length
                                  ),
                                  AppSize.s10.sizedBoxHeight,
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ).paddingBody(),
              ),
              tablet: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderForMore(title: "التقييم"),

                  SizedBox(
                    // width: AppReference.deviceWidth(context)*0.6,
                    // height: AppReference.deviceHeight(context)*0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
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
                                  reviewEntityOutputs.reviewText!,style: const AppTextStyle().bodySmall12.copyWith(
                                    fontSize: AppFontSize.sp12.responsiveFontSize,
                                    fontWeight:FontWeight.w700),
                                ),
                                const Spacer(),
                                Text(
                                  reviewEntityOutputs.createdAt.toString(),
                                  style: const AppTextStyle().balooBhaijaan2.w400.bodySmall12.copyWith(
                                    fontSize: AppFontSize.sp10.responsiveFontSize,
                                    color: AppColors.textColor4,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          AppSize.s20.sizedBoxHeight,
                          DefaultButtonWidget(
                              icon: AppIconsAssets.sDeleteNotification,
                              borderColor: Colors.transparent,
                              buttonColor: AppColors.failColor.withOpacity(.1),
                              label: "حذف",
                              textStyle: const AppTextStyle().bodyMedium14.copyWith(
                                color: AppColors.failColor,
                              ),
                              elevation: 0,
                              isExpanded: true,
                              onPressed: (){
                                context.read<ReviewBloc>().add(
                                  DeleteReviewDataEvent(reviewID: reviewEntityOutputs.id),
                                );
                              }),
                          AppSize.s20.sizedBoxHeight,
                          Container(
                            decoration: BoxDecoration(
                              // color: AppColors.white,
                              color: AppColors.primaryColor2,
                              borderRadius: BorderRadius.circular(
                                  20.responsiveSize),
                            ),
                            child: ExpansionTile(
                              title:                         Text(
                                "الرد",
                                style: const AppTextStyle()
                                    .w500
                                    .bodySmall12
                                    .copyWith(
                                  color: AppColors.white,
                                  height: 2,
                                ),
                                textAlign: TextAlign.justify,
                              ),

                              backgroundColor: Colors.transparent,
                              collapsedBackgroundColor:
                              AppColors.primaryColor2,
                              textColor: AppColors.textColor4,
                              collapsedTextColor:
                              AppColors.textColor4,
                              iconColor: AppColors.white,
                              collapsedIconColor: AppColors.white,
                              //childrenPadding: EdgeInsets.symmetric(horizontal:  10.responsiveSize),
                              controlAffinity:
                              ListTileControlAffinity.platform,
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.responsiveSize),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.responsiveSize),
                              ),
                              children: [
                                if (reviewEntityOutputs.response!.isEmpty)
                                  Center(
                                      child: Text(
                                        "لا يوجد ردود",
                                        style: AppTextStyle.bodyMedium14.copyWith(
                                          color: AppColors.white,
                                        ),
                                      )),
                                if (reviewEntityOutputs.response!.isNotEmpty)
                                  Container(

                                    color: AppColors.backgroundColor,
                                    child: Column(
                                      children: [
                                        AppSize.s10.sizedBoxHeight,
                                        ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemBuilder:
                                                (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:AppPadding.p10.responsiveSize ,
                                                    horizontal: AppPadding.p20.responsiveSize),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: AppPadding.p10.responsiveSize),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(
                                                      AppConstants.appBorderRadiusR10),
                                                ),
                                                child: Text(reviewEntityOutputs.response![index],
                                                  style: const AppTextStyle().w700.bodyMedium14,
                                                  // textAlign: TextAlign.center,
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                            const Divider(
                                              color: AppColors.textColor6,
                                              thickness: .5,
                                            ),
                                            // AppSize.s16
                                            //     .sizedBoxHeight,
                                            itemCount: reviewEntityOutputs.response!.length
                                        ),
                                        AppSize.s10.sizedBoxHeight,
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),



                ],
              ).paddingBody(),
            ),
          ),
        )
    );
  }
}
