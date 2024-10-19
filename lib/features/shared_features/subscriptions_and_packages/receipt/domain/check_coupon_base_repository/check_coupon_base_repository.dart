
import 'package:dartz/dartz.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/payment_data_entity.dart';

import '../../../../../../core/failure/failure.dart';
import '../check_coupon_entities/coupon_entity.dart';

abstract class CheckCouponBaseRepository{
  Future<Either<Failure, CouponEntity>> checkCoupon(String coupon);

  Future<Either<Failure, PaymentDataEntity>> getPaymentData();
}