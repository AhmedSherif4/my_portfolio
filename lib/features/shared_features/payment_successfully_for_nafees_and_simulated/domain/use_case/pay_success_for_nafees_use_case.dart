
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../repository/pay_for_nafees_success_repo.dart';

@LazySingleton()
class PaymentSuccessForNafeesUseCase extends BaseUseCase<String, PaySuccessForNafeesParameters> {
  final PaymentForNafeesSuccessBaseRepository repository;

  PaymentSuccessForNafeesUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(PaySuccessForNafeesParameters parameter) async {
    return await repository.savePaymentForNafeesToServer(
      parameter,
    );
  }
}
