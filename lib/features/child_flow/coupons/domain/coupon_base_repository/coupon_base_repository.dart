import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/coupon_entity.dart';
abstract class CouponBaseRepository {
  Future<Either<Failure, List<CouponEntity>>> getCoupons(
      int childId);
}
