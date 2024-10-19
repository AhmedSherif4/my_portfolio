import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/payment_data_entity.dart';

import '../../../../../../core/enum/enum_generation.dart';

class CouponState extends Equatable {
  final RequestStates checkCouponState;
  final String couponMessage;
  final String discount;

  final int totalPriceAfterCoupon;

  final bool isApplyCoupon;

  final String coupon;

  final RequestStates getPaymentDataState;
  final PaymentDataEntity paymentData;

  const CouponState({
    this.checkCouponState = RequestStates.initial,
    this.couponMessage = '',
    this.discount = '',
    this.totalPriceAfterCoupon = 0,
    this.isApplyCoupon = false,
    this.coupon = '',
    this.getPaymentDataState = RequestStates.initial,
    this.paymentData =  const PaymentDataEntity(
      paymentStatus: false,
      payKey: '',
      merchantId: '',
    ),
  });

  CouponState copyWith(
      {RequestStates? checkCouponState,
      String? couponMessage,
      String? discount,
      int? totalPriceAfterCoupon,
      bool? isApplyCoupon,
      String? coupon,
      RequestStates? getPaymentDataState,
      PaymentDataEntity? paymentData}) {
    return CouponState(
      checkCouponState: checkCouponState ?? this.checkCouponState,
      couponMessage: couponMessage ?? this.couponMessage,
      discount: discount ?? this.discount,
      totalPriceAfterCoupon:
          totalPriceAfterCoupon ?? this.totalPriceAfterCoupon,
      isApplyCoupon: isApplyCoupon ?? this.isApplyCoupon,
      coupon: coupon ?? this.coupon,
      getPaymentDataState: getPaymentDataState ?? this.getPaymentDataState,
      paymentData: paymentData ?? this.paymentData,
    );
  }

  @override
  List<Object> get props => [
        checkCouponState,
        couponMessage,
        discount,
        totalPriceAfterCoupon,
        isApplyCoupon,
        coupon,
        paymentData,
        getPaymentDataState,
      ];
}
