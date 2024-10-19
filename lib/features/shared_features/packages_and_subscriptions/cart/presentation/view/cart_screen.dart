import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_bloc.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_event.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';
import '../../../../../../config/resources/app_assets.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_strings.dart';
import '../../../../../../config/resources/app_text_style.dart';
import '../../../../../../config/routes/route_manager.dart';
import '../../../../../../config/routes/routes_names.dart';
import '../../../../../../core/base_widgets/loading_shimmer_widget.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../../core/shared_widget/button_widget.dart';
import '../../../../../../my_app/app_reference.dart';
import '../../../../../home_layout/home_layout.dart';
import '../../../../../shared_features/subscriptions_and_packages/widgets/base_for_two_widgets_subscriptions.dart';
import '../../../../more/presentation/more_widgets/header_for_more.dart';
import '../../../../subscriptions_and_packages/receipt/presentation/receipt_view_model/coupon_bloc.dart';
import '../../../../subscriptions_and_packages/receipt/presentation/receipt_view_model/coupon_state.dart';
import '../../../domain/entity/subject_subscriptions_entity.dart';
import '../../../presentation/view_model/packages_and_subscriptions_state.dart';
import '../view_model/cart_bloc.dart';
import '../view_model/cart_event.dart';
import '../view_model/cart_state.dart';

class CartScreen extends StatelessWidget {
  final int? userID;
  const CartScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    AppAnalytics.viewCartScreenLogEvent();
    return BlocProvider(
      create: (context) =>
          getIt<CartBloc>()..add(ViewCartDataEvent(
            userID ?? getIt<UserLocalDataSource>().getUserData()!.userId,
          )),
      child: MultiBlocListener(
  listeners: [
    BlocListener<HomeLayoutBloc, HomeLayoutState>(
    listener:(context, state) {
      if(state.bottomNavState == HomeLayoutStatesEnum.changeBottomNavState){
        state.index == 2 ? Navigator.pop(context) :Navigator.popUntil(
          context,
              (route) => route.isFirst,
        );
      }

    }),
    BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          switch (state.deleteCartState) {
            case RequestStates.loading:
              showLoadingDialog(context);
            case RequestStates.loaded:
              Navigator.pop(context);
              showSnackBar(
                  description: state.deleteCartMessage,
                  state: ToastStates.warning,
                  context: context);
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.deleteCartMessage,
                  state: ToastStates.error,
                  context: context);
            default:
          }
        },
),
    BlocListener<PackagesAndSubscriptionsBloc, PackagesAndSubscriptionsState>(
      listener: (context, state) {
        switch (state.deleteSubjectFromCartState) {
          case RequestStates.loading:
            showLoadingDialog(context);
            break;
          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
              description: state.deleteSubjectFromCartMessage,
              state: ToastStates.error,
              context: context,
            );
            break;
          case RequestStates.loaded:
            Navigator.pop(context);
            showSnackBar(
              description: state.deleteSubjectFromCartMessage,
              state: ToastStates.congrats,
              context: context,
            );
            context.read<CartBloc>().add(ViewCartDataEvent(
              userID ?? getIt<UserLocalDataSource>().getUserData()!.userId,

            ));
        break;
          default:
        }
      },

    ),
  ],
  child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return switch (state.viewCartState) {
                    RequestStates.loading => const LoadingShimmerList(),
                    RequestStates.loaded => Column(
                        children: [
                          HeaderForMore(
                            title: AppStrings.thePay,
                            onBack: AppReference.userIsChild() ? (){
                              RouteManager.rPushNamedAndRemoveUntil(
                                  context: context,
                                  rName: AppRoutesNames.rHomeLayoutView,
                                  arguments: getIt<UserLocalDataSource>().getUserData());
                            }:null,
                          ),
                           SizedBox(
                            width: (AppReference.deviceIsTablet && !AppReference.isPortrait(context))
                                ? AppReference.deviceWidth(context) * 0.5
                                : AppReference.deviceWidth(context),
                            child: Column(
                              children: [
                                const BannerSubscriptionsWidget(),
                                const HeadForListOfSubscriptionsWidget(),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return switch (state.cartData.cart[index].subjects.isEmpty) {
                                      false =>ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, sIndex) =>   ListTileSubscriptionWidget(
                                          isReceipt: true,
                                          isFree: state.cartData.cart[index].subjects[sIndex].subjectPrice == 0,
                                          title:
                                          '${state.cartData.cart[index].classroom}  / ${state.cartData.cart[index].term}\n${state.cartData.cart[index].subjects[sIndex].subjectName}',
                                          price: state
                                              .cartData.cart[index].subjects[sIndex].subjectPrice
                                              .toString(), onPressed: () {
                                          context.read<PackagesAndSubscriptionsBloc>().add(
                                              DeleteSubjectFromCartEvent(
                                                  addAndDeleteSubjectInputs:  AddAndDeleteSubjectInputs(
                                                    childId: userID ?? getIt<UserLocalDataSource>().getUserData()!.userId,
                                                    subjectId: state.cartData.cart[index].subjects[sIndex].subjectID,
                                                    pathId: state.cartData.cart[index].subjects[sIndex].pathID,
                                                  )
                                              ));},
                                        ),
                                        separatorBuilder: (context, sIndex) => AppSize.s10.sizedBoxHeight,
                                        itemCount: state.cartData.cart[index].subjects.length,
                                      ),
                                      true => const SizedBox.shrink(),
                                    };
                                  },
                                  separatorBuilder: (context, index) =>
                                  Divider(
                                    color: AppColors.textColor4,
                                    height: .5.responsiveSize,
                                    thickness: .5.responsiveSize,
                                  ),
                                  itemCount: state.cartData.cart.length,
                                ),
                                if (state.cartData.cart.isEmpty)
                                  const EmptyListWidgets(
                                      message: 'السلة فارغة قم بإضافة اشتراك'),
                                TotalPriceSubscriptionsWidget(
                                  totalPrice: state.cartData.totalPrice.toString(),
                                ),
                                10.sizedBoxHeight,
                                if (AppReference.userIsChild()&&state.cartData.cart.isNotEmpty)
                                  DefaultButtonWidget(
                                    label: 'حذف السلة',
                                    width: AppReference.deviceWidth(context) * 0.85,
                                    buttonColor: AppColors.failColor,
                                    borderColor: AppColors.failColor,
                                    onPressed: () {
                                      if (state.cartData.cart.isNotEmpty) {
                                        context.read<CartBloc>().add(
                                            DeleteCartDataEvent(
                                              userID ?? getIt<UserLocalDataSource>().getUserData()!.userId,

                                            ));
                                      }
                                    },
                                  ),
                                10.sizedBoxHeight,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: BlocBuilder<CouponBloc, CouponState>(
                                        builder: (context, couponStata) {
                                          if(couponStata.getPaymentDataState == RequestStates.loading){
                                            return const LoadingShimmerStructure(height: 70
                                              ,);
                                          }else {
                                            return DefaultButtonWidget(
                                              label: 'إلى الفاتورة',
                                              onPressed: () {
                                                if (couponStata.paymentData.paymentStatus ==
                                                    false) {
                                                  showSnackBar(
                                                      description:
                                                      'سوف يتاح الدفع قريبا',
                                                      state: ToastStates.warning,
                                                      context: context);
                                                } else {
                                                  if (state.cartData.totalPrice >= 0) {
                                                    if (state.cartData.cart
                                                        .isNotEmpty ) {
                                                      if (AppReference.userIsParent()) {
                                                        final cartData =
                                                        state.cartData.copyWith(
                                                          childId: userID!,
                                                        );
                                                        RouteManager.rPushNamed(
                                                          context: context,
                                                          rName: AppRoutesNames
                                                              .rReceiptScreen,
                                                          arguments: cartData,
                                                        );
                                                      } else {
                                                        RouteManager.rPushNamed(
                                                          context: context,
                                                          rName: AppRoutesNames
                                                              .rReceiptScreen,
                                                          arguments: state.cartData,
                                                        );
                                                      }
                                                    } else {
                                                      showSnackBar(
                                                          description:
                                                          'السلة فارغة قم باضافة اشتراك',
                                                          state: ToastStates.error,
                                                          context: context);
                                                    }
                                                  }
                                                }
                                              },
                                              buttonColor: AppColors.primaryColor,
                                              textFontSize: 14,
                                              width: AppReference.deviceWidth(context) *
                                                  0.4,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    AppSize.s10.sizedBoxWidth,
                                    if (AppReference.userIsChild())
                                      Expanded(
                                        child: DefaultButtonWidget(
                                          label: AppStrings.toNewItems,
                                          onPressed: () {
                                            // Navigator.popUntil(
                                            //   context,
                                            //       (route) => route.isFirst,
                                            // );
                                            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(3));

                                          },
                                          textFontSize: 14,
                                          labelColor: AppColors.primaryColor,
                                          borderColor: AppColors.primaryColor,
                                          buttonColor: AppColors.primaryColor.withOpacity(.1),
                                          width:
                                          AppReference.deviceWidth(context) * 0.3,
                                          elevation: 0,
                                        ),
                                      ),
                                    if (!AppReference.userIsChild())
                                      Expanded(
                                        child: DefaultButtonWidget(
                                          label: 'حذف السلة',
                                          borderColor: AppColors.failColor,
                                          width:
                                          AppReference.deviceWidth(context) * 0.1,
                                          buttonColor: AppColors.failColor,
                                          onPressed: () {
                                            if (state.cartData.cart.isNotEmpty) {
                                            context.read<CartBloc>().add(DeleteCartDataEvent(
                                              userID ?? getIt<UserLocalDataSource>().getUserData()!.userId,
                                            ));
                                            }else{
                                              showSnackBar(description: "السلة فارغة", state: ToastStates.warning, context: context);
                                            }
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    RequestStates.error =>
                      CustomErrorWidget(errorMessage: state.viewCartMessage),
                    RequestStates.initial => const SizedBox.shrink(),
                  };
                },
              ),
            ).paddingBody(),
          ),
        ),
),
    );
  }
}

class BannerSubscriptionsWidget extends StatelessWidget {
  final String title;

  const BannerSubscriptionsWidget({
    super.key,
    this.title = 'السلة',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.14.responsiveHeightRatio,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const AppTextStyle().gray.w500.s30.displayLarge32,
          ), // try the card
          SvgPicture.asset(
            AppImagesAssets.sGuyWithShoppingCard,
          ),
        ],
      ),
    );
  }
}

class HeadForListOfSubscriptionsWidget extends StatelessWidget {
  const HeadForListOfSubscriptionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseForTwoWidgetsSubscriptions(
      widget1: Text(
        'العناصر',
        style: const AppTextStyle().gray.w500.bodyLarge16,
      ),
      widget2: Text(
        'السعر',
        style: const AppTextStyle().gray.w500.bodyLarge16,
      ),
      backgroundColor: AppColors.primaryColor.withOpacity(.1),
    );
  }
}

class TotalPriceSubscriptionsWidget extends StatelessWidget {
  final String totalPrice;

  const TotalPriceSubscriptionsWidget({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.responsiveSize,
        vertical: 10.responsiveSize,
      ),
      decoration: ShapeDecoration(
        color: const Color(0xFFFAFAFA),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFC6C6C6)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(10.responsiveSize),
      height: AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
      width: double.infinity,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: constrains.maxWidth * 0.5,
              child: Text(
                AppStrings.total,
                style: const AppTextStyle().w600.bodyLarge16,
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.5,
              child: Center(
                child: Text(
                  '$totalPrice ريال',
                  textAlign: TextAlign.center,
                  style: const AppTextStyle().w700.bodyMedium14,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ListTileSubscriptionWidget extends StatelessWidget {
  final String title;
  final String price;
  final bool isFree;
  final bool isReceipt;
  final Function() onPressed;
  const ListTileSubscriptionWidget({
    super.key,
    required this.title,
    required this.price,
    required this.onPressed, required this.isFree, required this.isReceipt,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onPressed,
      child: BaseForTwoWidgetsSubscriptions(
        backgroundColor:isFree ? AppColors.successColor.withOpacity(.1):AppColors.white,
        widget1: Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const AppTextStyle().gray.w500.bodySmall12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        widget2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.responsiveSize),
          child: isFree ? Row(
            children: [
              SvgPicture.asset(AppIconsAssets.sFireworks),
              AppSize.s6.sizedBoxWidth,
              Text(
                'هدية',
                style: const AppTextStyle()
                    .balooBhaijaan2
                    .w800
                    .bodySmall12.copyWith(
                    color: AppColors
                        .successColor
                ),
              ),
            ],
          ) : Row(
            children: [
              Text(
                ' $price  ريال',
                style: const AppTextStyle().gray.w600.bodyMedium14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if(isReceipt)...[
              AppSize.s6.sizedBoxWidth,
              SvgPicture.asset(
                AppIconsAssets.sDeleteNotification,
              )]
            ],
          ),
        ),
      ),
    );
  }
}
