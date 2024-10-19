part of '../../login.dart';

abstract class LoginRemoteDataSource {
  Future<AuthEntity> login({
    required String email,
    required String password,
    required UsersType userType,
  });

  Future<AuthEntity> socialLogin({required String socialID});
}

@LazySingleton(
  as: LoginRemoteDataSource,
)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;
  final UserLocalDataSource userLocalDataSource;

  LoginRemoteDataSourceImpl({
    required this.baseDataSource,
    required this.userLocalDataSource,
  });

  @override
  Future<AuthEntity> login({
    required String email,
    required String password,
    required UsersType userType,
  }) async {
    await getIt<BaseAppSecurityData>().deleteToken();
    final Map<String, dynamic> response = await baseDataSource.postData(
      url: EndPoints.loginPath,
      body: userType == UsersType.child
          ? {
              'email_or_phone': email,
              'password': password,
              'type': userType.name,
              'noti_id':await NotificationSetup.getNotificationTokenFromFireBase(),
              'mobile_id': await AppReference.getMobileID(), //! only with the child
            }
          : {
              'email_or_phone': email,
              'password': password,
              'type': userType.name,
              'noti_id': await NotificationSetup.getNotificationTokenFromFireBase(),
            },
    );

    return LoginModel.fromMap(response);
  }

  @override
  Future<AuthEntity> socialLogin({required String socialID}) async {
    await getIt<BaseAppSecurityData>().deleteToken();
    final response = await baseDataSource.postData(
      url: EndPoints.socialLoginPath,
      body: {
        'social_id': socialID,
        'noti_id': await NotificationSetup.getNotificationTokenFromFireBase(),
        'mobile_id': await AppReference.getMobileID(),
      },
    );
    return LoginModel.fromMap(response);
  }
}



