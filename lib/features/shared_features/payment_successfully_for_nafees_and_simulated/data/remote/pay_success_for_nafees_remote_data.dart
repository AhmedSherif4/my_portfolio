import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../domain/repository/pay_for_nafees_success_repo.dart';

abstract class PaymentSuccessForNafeesRemoteDataSource {
  Future<String> savePaymentForNafeesToServe({required PaySuccessForNafeesParameters paySuccessForNafeesParameters});
}

@LazySingleton(as: PaymentSuccessForNafeesRemoteDataSource)
class PaymentSuccessForNafeesRemoteDataSourceImpl implements PaymentSuccessForNafeesRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  PaymentSuccessForNafeesRemoteDataSourceImpl({required this.baseRemoteDataSource});


  @override
  Future<String> savePaymentForNafeesToServe({required PaySuccessForNafeesParameters paySuccessForNafeesParameters})async {
    final response = await baseRemoteDataSource.postData(
      url:  paySuccessForNafeesParameters.isNafees ? EndPoints.nafeesZero : EndPoints.simulatedZero ,
      body: paySuccessForNafeesParameters.isNafees?{
        'child_id': paySuccessForNafeesParameters.childId,
        'nafis_id': paySuccessForNafeesParameters.nafeesId,
      }:{
        'child_id': paySuccessForNafeesParameters.childId,
        'category_id': paySuccessForNafeesParameters.simulatedId,
      },
    );
    return response['message'];
  }

}
