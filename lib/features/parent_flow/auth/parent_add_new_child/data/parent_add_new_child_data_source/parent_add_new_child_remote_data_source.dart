import 'package:injectable/injectable.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';

abstract class ParentAddNewChildRemoteDataSource {
  Future<String> parentAddNewChild({
    required String mailOrPhone,
  });
}

@LazySingleton(
  as: ParentAddNewChildRemoteDataSource,
)
class ParentAddNewChildRemoteDataSourceImpl
    implements ParentAddNewChildRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  ParentAddNewChildRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<String> parentAddNewChild({required String mailOrPhone}) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.parentAddNewChildPath,
      body: {
        "email_or_phone": mailOrPhone,
      },
    );
    return response['message'];
  }
}
