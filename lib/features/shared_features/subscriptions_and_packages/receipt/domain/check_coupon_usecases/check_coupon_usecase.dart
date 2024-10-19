

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../check_coupon_base_repository/check_coupon_base_repository.dart';
import '../check_coupon_entities/coupon_entity.dart';

@LazySingleton()
class CheckCouponUseCase extends BaseUseCase<CouponEntity, String> {
  final CheckCouponBaseRepository repository;

  CheckCouponUseCase({required this.repository});

  @override
  Future<Either<Failure, CouponEntity>> call(String parameter) async {
    return await repository.checkCoupon(parameter);
  }
}
