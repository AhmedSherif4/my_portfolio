
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/repository/pay_success_repo.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';

@LazySingleton()
class PaymentSuccessUseCase extends BaseUseCase<String, PaySuccessParameters> {
  final PaymentSuccessBaseRepository repository;

  PaymentSuccessUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(PaySuccessParameters parameter) async {
    return await repository.savePaymentToServer(
      parameter,
    );
  }
}
