import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/data/remote/pay_success_remote_data.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/repository/pay_success_repo.dart';

import '../../../../../../config/base_repository/base_repository.dart';

@LazySingleton(as: PaymentSuccessBaseRepository)
class PaymentSuccessRepositoryImpl implements PaymentSuccessBaseRepository {
  final BaseRepository baseRepository;
  final PaymentSuccessRemoteDataSource remoteDataSource;

  PaymentSuccessRepositoryImpl(
    this.baseRepository,
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, String>> savePaymentToServer(
      PaySuccessParameters parameter) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.savePaymentToServe(
        paySuccessParameters: parameter,
      ),
    );
  }
}
