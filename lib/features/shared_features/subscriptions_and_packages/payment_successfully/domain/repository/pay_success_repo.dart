import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/failure/failure.dart';

abstract class PaymentSuccessBaseRepository {
  Future<Either<Failure, String>> savePaymentToServer(
      PaySuccessParameters parameter);
}

class PaySuccessParameters extends Equatable {
  final String paymentId;
  final String coupon;
  final String couponDiscount;
  final int price;
  final int? childId;
  final int? parentId;

  const PaySuccessParameters(
      {required this.paymentId,
      required this.coupon,
      required this.couponDiscount,
      required this.price,
      this.childId, this.parentId});

  @override
  List<Object?> get props => [
        paymentId,
        coupon,
        couponDiscount,
        price,
        childId,
    parentId,
      ];
}
