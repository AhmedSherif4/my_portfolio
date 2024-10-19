import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';


abstract class GetInvitationRemoteDataSource {
  Future<String> getInvitation(String username);
}

@LazySingleton(as: GetInvitationRemoteDataSource)
class GetInvitationRemoteDataSourceImpl implements GetInvitationRemoteDataSource {
  final BaseRemoteDataSource _dataSource;

  GetInvitationRemoteDataSourceImpl(this._dataSource);
  @override
  Future<String> getInvitation(String username)async{

    final response = await _dataSource.postData(
        url:   EndPoints.invitationPath,
      body: {
          "username":username
      }
       );
    return  response['data'];

  }
}
