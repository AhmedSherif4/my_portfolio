import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/extensions/color_extension.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/repository/pay_success_repo.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/presentation/view_model/pay_success_bloc.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/presentation/view_model/pay_success_event.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../receipt/presentation/receipt_screen/required_data_after_payment.dart';
import '../view_model/pay_success_state.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final RequiredDataAfterPayment paymentData;

  const PaymentSuccessScreen({super.key, required this.paymentData});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.paymentData.totalPrice == 0
        ? BlocProvider(
            create: (context) {
              if (widget.paymentData.totalPrice != 0) {
                return getIt<PaySuccessBloc>();
              } else {
                return getIt<PaySuccessBloc>()
                  ..add(
                    AddPaymentToServerEvent(
                      parameters: PaySuccessParameters(
                        paymentId: widget.paymentData.transactionId,
                        coupon: widget.paymentData.coupon,
                        couponDiscount: widget.paymentData.couponDiscount,
                        price: widget.paymentData.totalPrice,
                        childId: widget.paymentData.childId,
                      ),
                    ),
                  );
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: BlocBuilder<PaySuccessBloc, PaySuccessState>(
                  builder: (context, state) {
                    switch (state.addPayState) {
                      case RequestStates.loading:
                        return LoadingShimmerList(
                          height: 100.responsiveHeight,
                        );
                      case RequestStates.loaded:
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/verify_fingerprint.svg',
                                height:
                                    AppReference.deviceHeight(context) * 0.2,
                                width: AppReference.deviceWidth(context) * 0.7,
                              ),
                              AppSize.s20.sizedBoxHeight,
                              Text(
                                'تم الاشتراك  بنجاح !',
                                style: AppTextStyle.titleSmall18,
                              ),
                              AppSize.s20.sizedBoxHeight,
                              DefaultButtonWidget(
                                label: 'إلى الصفحة الرئيسية',
                                buttonColor: HexColor.fromHex('#539013'),
                                borderColor: HexColor.fromHex('#539013'),
                                onPressed: () {
                                  RouteManager.rPushNamedAndRemoveUntil(
                                    context: context,
                                    rName: AppRoutesNames.rHomeLayoutView,
                                    arguments: getIt<UserLocalDataSource>()
                                        .getUserData(),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      case RequestStates.error:
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSize.s20.sizedBoxHeight,
                              Text(
                                ' لقد حدث خطا ما برجاء المحاولة مرة أخرى',
                                style: AppTextStyle.titleSmall18,
                              ),
                              AppSize.s20.sizedBoxHeight,
                              DefaultButtonWidget(
                                label: 'إلى الصفحة الرئيسية',
                                buttonColor: HexColor.fromHex('#539013'),
                                borderColor: HexColor.fromHex('#539013'),
                                onPressed: () {
                                  RouteManager.rPushNamedAndRemoveUntil(
                                    context: context,
                                    rName: AppRoutesNames.rHomeLayoutView,
                                    arguments: getIt<UserLocalDataSource>()
                                        .getUserData(),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/verify_fingerprint.svg',
                      height: AppReference.deviceHeight(context) * 0.2,
                      width: AppReference.deviceWidth(context) * 0.7,
                    ),
                    AppSize.s20.sizedBoxHeight,
                    Text(
                      'تم الاشتراك  بنجاح !',
                      style: AppTextStyle.titleSmall18,
                    ),
                    AppSize.s20.sizedBoxHeight,
                    DefaultButtonWidget(
                      label: 'إلى الصفحة الرئيسية',
                      buttonColor: HexColor.fromHex('#539013'),
                      borderColor: HexColor.fromHex('#539013'),
                      onPressed: () {
                        RouteManager.rPushNamedAndRemoveUntil(
                          context: context,
                          rName: AppRoutesNames.rHomeLayoutView,
                          arguments: getIt<UserLocalDataSource>().getUserData(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
