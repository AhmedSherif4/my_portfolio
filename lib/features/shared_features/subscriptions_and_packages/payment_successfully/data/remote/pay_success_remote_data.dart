import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../domain/repository/pay_success_repo.dart';

abstract class PaymentSuccessRemoteDataSource {
  Future<String> savePaymentToServe({required PaySuccessParameters paySuccessParameters});
}

@LazySingleton(as: PaymentSuccessRemoteDataSource)
class PaymentSuccessRemoteDataSourceImpl implements PaymentSuccessRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  PaymentSuccessRemoteDataSourceImpl({required this.baseRemoteDataSource});


  @override
  Future<String> savePaymentToServe({required PaySuccessParameters paySuccessParameters})async {
    final response = await baseRemoteDataSource.postData(
      url:  EndPoints.addTransaction ,
      body: AppReference.userIsParent() ? {
        'child_id': paySuccessParameters.childId,
        'coupon': paySuccessParameters.coupon,
        'parent_id': getIt<UserLocalDataSource>().getUserData()!.userId,
      }:{
        'child_id': paySuccessParameters.childId,
        'coupon': paySuccessParameters.coupon,
      },
    );
    return response['message'];
  }

}
