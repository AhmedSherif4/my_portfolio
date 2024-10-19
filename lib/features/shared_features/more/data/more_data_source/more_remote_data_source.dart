import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart';
import 'package:my_portfolio/core/api/api_consumer.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/api/network_info.dart';
import '../../../../../core/exceptions/exceptions.dart';

abstract class MoreBaseRemoteDataSource {
  Future<bool> logout();
}

@LazySingleton(as: MoreBaseRemoteDataSource)
class MoreRemoteDataSourceImpl
    implements MoreBaseRemoteDataSource {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;
  final BaseRemoteDataSource baseRemoteDataSource;

  const MoreRemoteDataSourceImpl({
    required this.networkInfo,
    required this.apiConsumer,
    required this.baseRemoteDataSource,
  });
  @override
  Future<bool> logout() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    } else {
      final response = await apiConsumer.post(EndPoints.logout);
      return jsonDecode(response.data)['status'];
    }
  }
}
