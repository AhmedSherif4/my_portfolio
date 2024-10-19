
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/data/check_coupon_models/payment_model.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/coupon_entity.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';
import '../../domain/check_coupon_entities/payment_data_entity.dart';
import '../check_coupon_models/coupon_model.dart';

abstract class CheckCouponRemoteDataSource {
  Future<CouponEntity> checkCoupon(String coupon);

  Future<PaymentDataEntity> getPaymentData();
}

@LazySingleton(as: CheckCouponRemoteDataSource)
class CheckCouponRemoteDataSourceImpl implements CheckCouponRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  CheckCouponRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<CouponEntity> checkCoupon(String coupon) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.checkCoupon,
      body: {
        'coupon': coupon,
      },
    );
    return CouponModel.fromMap(response['data']);
  }

  @override
  Future<PaymentDataEntity> getPaymentData() async {
  final response = await baseRemoteDataSource.postData(url: EndPoints.paymentDataPath ,body: {});
  return PaymentDataModel.fromJson(response['data']);

  }
}
