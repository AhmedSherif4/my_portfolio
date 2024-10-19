import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();
}

class GetCoupons extends CouponEvent {
  final int childId;
  const GetCoupons({
    required this.childId,
  });
  @override
  List<Object?> get props => [
        childId,
      ];
}
