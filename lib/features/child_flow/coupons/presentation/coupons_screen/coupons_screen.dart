import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/child_flow/coupons/presentation/coupon_view_model/coupon_state.dart';
import '../../../../../config/resources/app_assets.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/shared_widget/custom_inkwell.dart';
import '../../../../../core/shared_widget/empty_list_widget.dart';
import '../../../../../my_app/app_reference.dart';
import '../../../../shared_features/more/presentation/more_widgets/header_for_more.dart';
import '../coupon_view_model/coupon_bloc.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderForMore(
                title: AppStrings.myCoupons,
              ),
              SvgPicture.asset(AppIconsAssets.sCoupon),
              AppSize.s10.sizedBoxHeight,
              BlocBuilder<CouponsBloc, CouponState>(
                builder: (context, state) {
                  return switch (state.getCouponsRequestState) {
                    RequestStates.loading => const LoadingShimmerList(),
                    RequestStates.loaded => state.coupons.isEmpty
                        ? Column(
                            children: [
                              200.sizedBoxHeight,
                              const Center(
                                child:  EmptyListWidgets(
                                    message: AppStrings.noCoupons),
                              ),
                            ],
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p10.responsiveSize,
                                    vertical: AppPadding.p20.responsiveSize),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants
                                          .appBorderRadiusR20.responsiveSize),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "خصم ${state.coupons[index].discount} ${state.coupons[index].discountType == "percent" ? "%" : "ريال"}",
                                                style: const AppTextStyle()
                                                    .balooBhaijaan2
                                                    .w500
                                                    .bodyMedium14
                                                    .copyWith(
                                                      fontSize: AppReference
                                                              .deviceIsTablet
                                                          ? AppFontSize.sp14
                                                              .responsiveFontSize
                                                          : AppFontSize.sp14
                                                              .responsiveFontSize,
                                                    ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              AppSize.s10.sizedBoxWidth,
                                              SvgPicture.asset(
                                                  AppIconsAssets.sCelebration),
                                            ],
                                          ),
                                          AppSize.s10.sizedBoxWidth,
                                          Text(
                                            "تاريخ الكوبون : ${state.coupons[index].createdAt}",
                                            style: const AppTextStyle()
                                                .balooBhaijaan2
                                                .w400
                                                .bodySmall12
                                                .copyWith(
                                                  fontSize: AppReference
                                                          .deviceIsTablet
                                                      ? AppFontSize.sp12
                                                          .responsiveFontSize
                                                      : AppFontSize.sp12
                                                          .responsiveFontSize,
                                                  color: AppColors.textColor3,
                                                ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          AppSize.s4.sizedBoxHeight,
                                          Text(
                                            "صالح حتى : ${state.coupons[index].expiryDate}",
                                            style: const AppTextStyle()
                                                .balooBhaijaan2
                                                .w400
                                                .bodySmall12
                                                .copyWith(
                                                  fontSize: AppFontSize
                                                      .sp10.responsiveFontSize,
                                                  color: AppColors.textColor4,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppSize.s16.sizedBoxWidth,
                                    CustomInkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                                text:
                                                    state.coupons[index].code))
                                            .then((value) {
                                          if (context.mounted) {
                                            showSnackBar(
                                                description: "تم نسخ الكود",
                                                state: ToastStates.congrats,
                                                context: context);
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            AppStrings.copy,
                                            style: const AppTextStyle()
                                                .balooBhaijaan2
                                                .w500
                                                .bodyMedium14
                                                .copyWith(
                                                  fontSize: AppReference
                                                          .deviceIsTablet
                                                      ? AppFontSize.sp14
                                                          .responsiveFontSize
                                                      : AppFontSize.sp10
                                                          .responsiveFontSize,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          CustomInkWell(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              AppIconsAssets.sCopy,
                                              width: AppReference.deviceIsTablet
                                                  ? AppSize.s40.responsiveWidth
                                                  : AppSize.s28.responsiveWidth,
                                              height: AppReference
                                                      .deviceIsTablet
                                                  ? AppSize.s40.responsiveHeight
                                                  : AppSize
                                                      .s28.responsiveHeight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            separatorBuilder: (context, index) =>
                                AppSize.s10.sizedBoxHeight,
                            itemCount: state.coupons.length),
                    RequestStates.error => ErrorWidget(
                        state.getCouponsErrorMessage,
                      ),
                    _ => const SizedBox()
                  };
                },
              ),
            ],
          ).paddingBody(),
        ),
      ),
    );
  }
}
