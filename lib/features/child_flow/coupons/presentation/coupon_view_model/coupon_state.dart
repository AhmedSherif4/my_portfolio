import 'package:equatable/equatable.dart';

import '../../../../../core/enum/enum_generation.dart';
import '../../../../shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/coupon_entity.dart';
class CouponState extends Equatable {
  final RequestStates getCouponsRequestState;
  final String getCouponsErrorMessage;
  final List<CouponEntity> coupons;

  const CouponState({
    this.getCouponsErrorMessage = '',
    this.getCouponsRequestState = RequestStates.initial,
    this.coupons = const [],
  });

  CouponState copyWith({
     RequestStates? getCouponsRequestState,
     String? getCouponsErrorMessage,
     List<CouponEntity>? coupons,
  }) {
    return CouponState(
      getCouponsRequestState: getCouponsRequestState ?? this.getCouponsRequestState,
      getCouponsErrorMessage: getCouponsErrorMessage ?? this.getCouponsErrorMessage,
      coupons: coupons ?? this.coupons,
    );
  }

  @override
  List<Object> get props => [
        getCouponsRequestState,
        getCouponsErrorMessage,
        coupons
      ];
}
