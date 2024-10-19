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
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/presentation/view_model/pay_success_for_nafees_bloc.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../domain/repository/pay_for_nafees_success_repo.dart';
import '../view_model/pay_success_for_nafees_event.dart';
import '../view_model/pay_success_for_nafees_state.dart';
import 'required_data_after_nafees_payment.dart';

class PaymentSuccessForNafeesScreen extends StatefulWidget {
  final RequiredDataAfterNafeesPayment paymentData;

  const PaymentSuccessForNafeesScreen({super.key, required this.paymentData});

  @override
  State<PaymentSuccessForNafeesScreen> createState() => _PaymentSuccessForNafeesScreenState();
}

class _PaymentSuccessForNafeesScreenState extends State<PaymentSuccessForNafeesScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.paymentData.totalPrice == 0
        ? BlocProvider(
            create: (context) {
              if (widget.paymentData.totalPrice != 0) {
                return getIt<PaySuccessForNafeesBloc>();
              } else {
                return getIt<PaySuccessForNafeesBloc>()
                  ..add(
                    AddPaymentToServerForNafeesEvent(
                      parameters: PaySuccessForNafeesParameters(
                        childId: widget.paymentData.childId!,
                        nafeesId: widget.paymentData.nafeesId??0,
                        simulatedId: widget.paymentData.simulatedId??0,
                        isNafees: widget.paymentData.isNafees,
                      ),
                    ),
                  );
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: BlocBuilder<PaySuccessForNafeesBloc, PaySuccessForNafeesState>(
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
