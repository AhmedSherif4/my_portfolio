import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/payment_data_entity.dart';

import '../../../../../../config/base_repository/base_repository.dart';
import '../../../../../../core/failure/failure.dart';
import '../../domain/check_coupon_base_repository/check_coupon_base_repository.dart';
import '../../domain/check_coupon_entities/coupon_entity.dart';
import '../check_coupon_data_source/check_coupon_remote_data_source.dart';

@LazySingleton(as: CheckCouponBaseRepository)
class CartRepository implements CheckCouponBaseRepository {
  final CheckCouponRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  CartRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, CouponEntity>> checkCoupon(String coupon) async {
    final result = await baseRepository
        .checkExceptionForRemoteData(remoteDataSource.checkCoupon(coupon));
    return result.fold(
      (failure) => left(failure),
      (coupon) {
        if (!coupon.status) {
          return const Left(ResponseFailure('هذا الكوبون غير صالح'));
        } else if (coupon.usages < coupon.currentUse) {
          return const Left(ResponseFailure('تم إستخدام الكوبون من قبل'));
        } else {
          return Right(coupon);
        }
      },
    );
  }

  @override
  Future<Either<Failure, PaymentDataEntity>> getPaymentData() async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getPaymentData(),
    );
  }
}
