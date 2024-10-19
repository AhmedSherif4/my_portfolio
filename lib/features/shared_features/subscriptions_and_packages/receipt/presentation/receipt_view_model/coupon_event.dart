import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();
}

class CheckCouponEvent extends CouponEvent {
  final String coupon;
  const CheckCouponEvent(
    this.coupon,
  );
  @override
  List<Object> get props => [
        coupon,
      ];
}

class RemoveCouponEvent extends CouponEvent {
  const RemoveCouponEvent();
  @override
  List<Object> get props => [];
}

class GetPaymentDataEvent extends CouponEvent {
  const GetPaymentDataEvent();
  @override
  List<Object> get props => [];
}
