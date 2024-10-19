
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/coupon_entity.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../coupon_base_repository/coupon_base_repository.dart';

@LazySingleton()
class CouponUseCase extends BaseUseCase<List<CouponEntity>, int> {
  final CouponBaseRepository repository;

  CouponUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CouponEntity>>> call(
      int parameter) async {
    return await repository.getCoupons(
      parameter,
    );
  }
}
