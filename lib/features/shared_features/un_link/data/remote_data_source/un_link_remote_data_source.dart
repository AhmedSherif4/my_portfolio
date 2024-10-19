part of '../../un_link.dart';

abstract class UnLinkRemoteDataSource {
  Future<String> userUnLink({required int userId});
  Future<String> childAddNewParent({required String emailOrPhone,});
  Future<String> childAddExistParent({required String username});
  Future<String> parentAddNewChild({required String mailOrPhone});
  Future<String> parentAddExistChild({required String username});
}

@LazySingleton(
  as: UnLinkRemoteDataSource,
)
class UnLinkRemoteDataSourceImpl implements UnLinkRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  UnLinkRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<String> userUnLink({required int userId}) async {
    final response = AppReference.userIsChild()
        ? await baseDataSource.postData(
            url: EndPoints.childUnLinkParentPath,
            body: {
              'parent_id': userId,
            },
          )
        : await baseDataSource.postData(
            url: EndPoints.parentUnLinkChildPath,
            body: {
              'child_id': userId.toString(),
            },
          );
    return response['message'];
  }

  @override
  Future<String> childAddNewParent({required String emailOrPhone}) async {
    final response = await baseDataSource.postData(
      url: EndPoints.childAddNewParentPath,
      body: {
        "email_or_phone": emailOrPhone,
      },
    );
    return response['message'];
  }

  @override
  Future<String> childAddExistParent({required String username}) async {
    final response = await baseDataSource.postData(
      url: EndPoints.childAddExistParentPath,
      body: {
        "username": username,
      },
    );
    return response['message'];
  }

  @override
  Future<String> parentAddNewChild({required String mailOrPhone}) async {
    final response = await baseDataSource.postData(
      url: EndPoints.parentAddNewChildPath,
      body: {
        "email_or_phone": mailOrPhone,
      },
    );
    return response['message'];
  }

  @override
  Future<String> parentAddExistChild({required String username}) async {
    final response = await baseDataSource.postData(
      url: EndPoints.parentAddExistChildPath,
      body: {
        "username": username,
      },
    );
    return response['message'];
  }
}
