
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/data/check_coupon_models/coupon_model.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/coupon_entity.dart';

import '../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../core/api/end_points.dart';

abstract class CouponRemoteDataSource {
  Future<List<CouponEntity>> getCoupons(int childId);
}

@LazySingleton(as: CouponRemoteDataSource)
class CouponRemoteDataSourceImpl implements CouponRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  CouponRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<List<CouponEntity>> getCoupons(
      int childId) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.allCouponsPath,
      body: {
        'child_id': childId,
      },
    );
    return List<CouponEntity>.from(
      (response['data'] as List).map(
        (exam) => CouponModel.fromMap(exam),
      ),
    );
  }
}

