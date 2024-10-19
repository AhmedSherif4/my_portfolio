
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/coupon_entity.dart';

import '../../../../../config/base_repository/base_repository.dart';
import '../../../../../core/failure/failure.dart';
import '../../domain/coupon_base_repository/coupon_base_repository.dart';
import '../coupon_data_source/coupon_remote_data_source.dart';

@LazySingleton(as: CouponBaseRepository)
class CouponRepository implements CouponBaseRepository {
  final CouponRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  CouponRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<CouponEntity>>> getCoupons(
      int childId) async {

      final jsonData =
      await baseRepository.checkExceptionForRemoteData<List<CouponEntity>>(
        remoteDataSource.getCoupons(childId),
      );
      return jsonData.fold(
            (failure) => left(failure),
            (data) async {
          return Right(data);
        },
      );
    }
  }

