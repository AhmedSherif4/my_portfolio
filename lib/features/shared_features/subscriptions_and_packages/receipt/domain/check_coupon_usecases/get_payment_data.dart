

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/payment_data_entity.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../check_coupon_base_repository/check_coupon_base_repository.dart';

@LazySingleton()
class GetPaymentDataUseCase extends BaseUseCase<PaymentDataEntity, NoParameter> {
  final CheckCouponBaseRepository repository;

  GetPaymentDataUseCase({required this.repository});

  @override
  Future<Either<Failure, PaymentDataEntity>> call(NoParameter parameter) async {
    return await repository.getPaymentData();
  }
}
