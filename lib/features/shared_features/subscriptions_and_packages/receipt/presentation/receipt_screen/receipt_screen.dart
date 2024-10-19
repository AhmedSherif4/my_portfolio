import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_screen/required_data_after_payment.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../../config/resources/app_assets.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_strings.dart';
import '../../../../../../config/resources/app_text_style.dart';
import '../../../../../../config/resources/app_values.dart';
import '../../../../../../config/routes/route_manager.dart';
import '../../../../../../config/routes/routes_names.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../../core/shared_widget/button_widget.dart';
import '../../../../../../core/shared_widget/text_form_field.dart';
import '../../../../../../my_app/app_reference.dart';
import '../../../../packages_and_subscriptions/cart/domain/entity/cart_entity.dart';
import '../../../../packages_and_subscriptions/cart/presentation/view/cart_screen.dart';
import '../../../widgets/header_widget.dart';
import '../receipt_view_model/coupon_bloc.dart';
import '../receipt_view_model/coupon_event.dart';
import '../receipt_view_model/coupon_state.dart';

class CouponScreen extends StatelessWidget {
  final CartEntity cartData;
  const CouponScreen({super.key, required this.cartData});

  @override
  Widget build(BuildContext context) {
    AppAnalytics.viewCheckoutScreenLogEvent();
    return BlocProvider(
      create: (context) => getIt<CouponBloc>(),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
              child: BlocListener<CouponBloc, CouponState>(
            listener: (context, state) {
              switch (state.checkCouponState) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                  break;
                case RequestStates.loaded:
                  Navigator.pop(context);
                  showSnackBar(
                      description: state.couponMessage,
                      state: ToastStates.congrats,
                      context: context);
                  break;
                case RequestStates.error:
                  Navigator.pop(context);
                  showSnackBar(
                      description: state.couponMessage,
                      state: ToastStates.error,
                      context: context);
                  break;
                default:
              }
            },
            child:
            Column(
              children: [
                AppBarSubscriptionsWidget(
                    childID: cartData.cart.first.subjects.first.childID,
                    title: 'الفاتورة'),
                Expanded(
                      child: SingleChildScrollView(
                    child: SizedBox(
                      width: (AppReference.deviceIsTablet && !AppReference.isPortrait(context))
                          ? AppReference.deviceWidth(context) * 0.5
                          : AppReference.deviceWidth(context),
                      child: Column(
                        children: [
                          const BannerSubscriptionsWidget(title: 'تفاصيل فاتورتك'),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return switch (cartData.cart.isEmpty) {
                                false => ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, sIndex) =>   ListTileSubscriptionWidget(
                                    isReceipt: false,
                                    isFree: cartData.cart[index].subjects[sIndex].subjectPrice == 0,
                                    title:
                                    '${cartData.cart[index].classroom}  / ${cartData.cart[index].term}\n${cartData.cart[index].subjects[sIndex].subjectName}',
                                    price: cartData.cart[index].subjects[sIndex].subjectPrice
                                        .toString(), onPressed: () {},
                                  ),
                                  separatorBuilder: (context, sIndex) => 10.sizedBoxHeight,
                                  itemCount: cartData.cart[index].subjects.length,
                                ),
                                true => const SizedBox.shrink(),
                              };
                            },
                            separatorBuilder: (context, index) =>
                                AppSize.s10.sizedBoxHeight,
                            itemCount: cartData.cart.length,
                          ),
                          BlocBuilder<CouponBloc, CouponState>(
                              builder: (context, state) {
                            context.read<CouponBloc>().totalPrice =
                                cartData.totalPrice;
                            return Column(
                              children: [
                                TotalPriceSubscriptionsWidget(
                                  discount: int.tryParse(state.discount) ?? 0,
                                  couponState: state.checkCouponState,
                                  totalPriceAfterCoupon:
                                      state.totalPriceAfterCoupon,
                                  totalPrice: context.read<CouponBloc>().totalPrice,
                                  isApplyCoupon: state.isApplyCoupon,
                                ),
                                const PromoCodeSubscriptionWidget(),
                                if (state.checkCouponState == RequestStates.loaded)
                                  Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      'تم تطبيق الخصم بنجاح',
                                      style: const AppTextStyle()
                                          .green
                                          .w500
                                          .bodySmall12,
                                    ),
                                  ),
                                if (state.checkCouponState == RequestStates.error)
                                  Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      'كوبون غير صالح',
                                      style:
                                          const AppTextStyle().red.w500.bodySmall12,
                                    ),
                                  ),
                              ],
                            );
                          }),
                          10.sizedBoxHeight,
                          Builder(builder: (context) {
                            return DefaultButtonWidget(
                              label: 'إلى الدفع',
                              onPressed: () async {

                                final data = AppReference.userIsParent()
                                    ? RequiredDataAfterPayment(
                                        cartData: cartData,
                                        totalPrice: context
                                                .read<CouponBloc>()
                                                .state
                                                .isApplyCoupon
                                            ? context
                                                .read<CouponBloc>()
                                                .state
                                                .totalPriceAfterCoupon
                                            : cartData.totalPrice,
                                        coupon:
                                            context.read<CouponBloc>().state.coupon,
                                        couponDiscount: context
                                            .read<CouponBloc>()
                                            .state
                                            .discount,
                                        childId: cartData.cart.first.subjects.first.childID,
                                      ).copyWith(parentId: getIt<UserLocalDataSource>().getUserData()!.userId,)
                                    : RequiredDataAfterPayment(
                                        cartData: cartData,
                                        totalPrice: context
                                                .read<CouponBloc>()
                                                .state
                                                .isApplyCoupon
                                            ? context
                                                .read<CouponBloc>()
                                                .state
                                                .totalPriceAfterCoupon
                                            : cartData.totalPrice,
                                        coupon:
                                            context.read<CouponBloc>().state.coupon,
                                        couponDiscount: context
                                            .read<CouponBloc>()
                                            .state
                                            .discount,
                                        childId: getIt<UserLocalDataSource>()
                                            .getUserData()!
                                            .userId,
                                      );
                                if ((context.read<CouponBloc>().totalPrice == 0 ||
                                        context.read<CouponBloc>().state.totalPriceAfterCoupon ==
                                            0) && context.read<CouponBloc>().state.isApplyCoupon
                                ) {
                                  RouteManager.rPushNamedAndRemoveUntil(
                                      context: context,
                                      rName: AppRoutesNames.rPaymentSuccessScreen,
                                      arguments: data);
                                } else {
                                  String message = '';
                                  String status = '';
                                  final createController = WebViewController()
                                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                    ..setBackgroundColor(const Color(0x00000000))
                                    ..setNavigationDelegate(
                                      NavigationDelegate(
                                        onUrlChange: (urlChange){
                                          // urlChange.url.log();
                                        },
                                        onPageFinished: (String url) {
                                          if (url.contains('callback')) {
                                            Uri uri = Uri.parse(url);
                                            status =
                                                uri.queryParameters['status'] ?? '';
                                            message =
                                                uri.queryParameters['message'] ??
                                                    '';
                                            if (status.isNotEmpty &&
                                                status == 'paid') {
                                              RouteManager.rPushNamedAndRemoveUntil(
                                                  context: context,
                                                  rName: AppRoutesNames
                                                      .rPaymentSuccessScreen,
                                                  arguments: data);
                                            } else {
                                              RouteManager.rPopRoute(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                        message.isNotEmpty
                                                            ? message
                                                            : 'لقد حدث خطأ٫ برجاء المحاولة في وقت لاحق',
                                                        style: AppTextStyle
                                                            .bodyMedium14,
                                                      ),
                                                    );
                                                  });
                                            }
                                          }
                                        },
                                      ),
                                    )
                                    ..loadRequest(
                                      Uri.parse(
                                          '${EndPoints.baseUrl}/new/order?child_id=${data.childId}&parent_id=${AppReference.userIsParent() ? getIt<UserLocalDataSource>().getUserData()!.userId : ""}&price=${data.totalPrice}&coupon=${data.coupon}&coupon_discount=${data.couponDiscount}',
                                      ),
                                    );

                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return PaymentScreen(createController: createController);
                                    },
                                  ));
                                }
                              },
                              buttonColor: AppColors.primaryColor,
                              textFontSize: 14,
                              width: AppReference.deviceWidth(context) * 0.4,
                            );
                          }),
                        ],
                      ),
                    ),
                  )),

              ],
            ),
          )).paddingBody(),
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final WebViewController createController;
  const PaymentScreen({super.key, required this.createController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextBackButton())
              .paddingBody(),
          Expanded(child: WebViewWidget(controller: createController)),
        ],
      )),
    );
  }
}

class TotalPriceSubscriptionsWidget extends StatelessWidget {
  final int totalPrice;
  final int totalPriceAfterCoupon;
  final int discount;
  final RequestStates couponState;
  final bool isApplyCoupon;
  const TotalPriceSubscriptionsWidget({
    super.key,
    required this.totalPrice,
    required this.discount,
    required this.couponState,
    required this.totalPriceAfterCoupon,
    required this.isApplyCoupon,
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
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (couponState == RequestStates.loaded)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الإجمال قبل الخصم',
                    style: const AppTextStyle().w600.bodyMedium14,
                  ),
                ),
                Expanded(
                  child: Text(
                    '$totalPrice ريال',
                    style: const AppTextStyle().red.w700.bodyMedium14,
                  ),
                ),
              ],
            ),
          if (couponState == RequestStates.loaded) AppSize.s10.sizedBoxHeight,
          if (couponState == RequestStates.loaded)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'الخصم',
                    style: const AppTextStyle().w600.bodyMedium14,
                  ),
                ),
                Expanded(
                  child: Text(
                    '$discount ريال',
                    style: const AppTextStyle().orange.w700.bodyMedium14,
                  ),
                ),
              ],
            ),
          if (couponState == RequestStates.loaded) AppSize.s10.sizedBoxHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  AppStrings.total,
                  style: const AppTextStyle().w600.bodyLarge16,
                ),
              ),
              Expanded(
                child: Text(
                  isApplyCoupon
                      ? '$totalPriceAfterCoupon ريال'
                      : '$totalPrice ريال',
                  style: const AppTextStyle().w700.bodyMedium14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PromoCodeSubscriptionWidget extends StatefulWidget {
  const PromoCodeSubscriptionWidget({super.key});

  @override
  State<PromoCodeSubscriptionWidget> createState() =>
      _PromoCodeSubscriptionWidgetState();
}

class _PromoCodeSubscriptionWidgetState
    extends State<PromoCodeSubscriptionWidget> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'هل لديك كوبون خصم ؟',
              style: const AppTextStyle().gray.w500.bodyLarge16,
            ),
            20.sizedBoxWidth,
            SvgPicture.asset(
              AppIconsAssets.sDiscountCoupon,
              width: AppReference.deviceWidth(context) * 0.05,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
flex: 1,              child: DefaultButtonWidget(
                label: 'تطبيق',
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    showSnackBar(
                        description: 'قم بإدخال الكوبون',
                        state: ToastStates.warning,
                        context: context);
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<CouponBloc>().add(
                          CheckCouponEvent(_controller.text),
                        );
                  }
                },
                buttonColor: AppColors.primaryColor,
                textFontSize: 12,
              ),
            ),
            AppSize.s10.sizedBoxWidth,
            Expanded(
              flex: 2,
              child: TextFormFieldWidget(
                controller: _controller,
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.done,
                suffixIcon: Icons.delete_outline_sharp,
                suffixIconColor: AppColors.failColor,
                suffixIconOnPress: () {
                  context.read<CouponBloc>().add(const RemoveCouponEvent());
                  _controller.clear();
                },
                label: '',
                onFieldSubmitted: (value) {
                  context.read<CouponBloc>().add(CheckCouponEvent(value));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
