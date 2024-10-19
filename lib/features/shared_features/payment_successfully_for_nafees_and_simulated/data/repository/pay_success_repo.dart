import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import '../../../../../../config/base_repository/base_repository.dart';
import '../../domain/repository/pay_for_nafees_success_repo.dart';
import '../remote/pay_success_for_nafees_remote_data.dart';

@LazySingleton(as: PaymentForNafeesSuccessBaseRepository)
class PaymentForNafeesSuccessBaseRepositoryImpl implements PaymentForNafeesSuccessBaseRepository {
  final BaseRepository baseRepository;
  final PaymentSuccessForNafeesRemoteDataSource remoteDataSource;

  PaymentForNafeesSuccessBaseRepositoryImpl(
    this.baseRepository,
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, String>> savePaymentForNafeesToServer(
     PaySuccessForNafeesParameters parameter) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.savePaymentForNafeesToServe(
        paySuccessForNafeesParameters: parameter,
      ),
    );
  }
}
