part of '../../verification.dart';

abstract class VerificationRemoteDataSource {
  Future<bool> checkVerificationCode({
    required String code,
    required String emailOrPhone,
  });

  Future<String> resendVerificationCode({
    required SendVerificationCodeParameter sendVerificationCodeParameter,
  });

  Future<AuthEntity> signUp({
    required SignUpParameter signUpParameter,
  });
}

@LazySingleton(
  as: VerificationRemoteDataSource,
)
class VerificationRemoteDataSourceImpl implements VerificationRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;

  VerificationRemoteDataSourceImpl(
      {required this.apiConsumer,
      required this.networkInfo,
      required this.baseDataSource});

  @override
  Future<bool> checkVerificationCode({
    required String code,
    required String emailOrPhone,
  }) async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    } else {
      final response = await apiConsumer.post(
        EndPoints.checkVerificationCodePath,
        body: {
          "code": code,
          "email_or_phone": emailOrPhone,
        },
      );
      return jsonDecode(response.data)['status'];
    }
  }

  @override
  Future<String> resendVerificationCode({
    required SendVerificationCodeParameter sendVerificationCodeParameter,
  }) async {
    final response = await baseDataSource.postData(
      url: EndPoints.sendVerificationCodePath,
      body: {
        "email_or_phone": sendVerificationCodeParameter.emailOrPhone,
        "register_type": sendVerificationCodeParameter.userType.name,
        "send_type": sendVerificationCodeParameter.sendType.name,
      },
    );
    return response['message'];
  }

  @override
  Future<AuthEntity> signUp({
    required SignUpParameter signUpParameter,
  }) async {
    final response = await baseDataSource.postData(
      url: EndPoints.signUpPath,
      body: signUpParameter.type == UsersType.child
          ? FormData.fromMap({
              "name": signUpParameter.name,
              "email": signUpParameter.sendType == SendType.email
                  ? signUpParameter.emailOrPhone
                  : null,
              "password": signUpParameter.password,
              "phone": signUpParameter.sendType != SendType.email
                  ? signUpParameter.emailOrPhone
                  : null,
              "type": signUpParameter.type.name,
              "gendar": signUpParameter.gendar,
              "mobile_id": await AppReference.getMobileID(),
              "noti_id": await NotificationSetup.getNotificationTokenFromFireBase(),
              "img": signUpParameter.img.isNotEmpty
                  ? await MultipartFile.fromFile(signUpParameter.img)
                  : null,
            })
          : FormData.fromMap({
              "name": signUpParameter.name,
              "email": signUpParameter.sendType == SendType.email
                  ? signUpParameter.emailOrPhone
                  : null,
              "password": signUpParameter.password,
              "phone": signUpParameter.sendType != SendType.email
                  ? signUpParameter.emailOrPhone
                  : null,
              "type": signUpParameter.type.name,
              "noti_id":
                  await NotificationSetup.getNotificationTokenFromFireBase(),
              "gendar": signUpParameter.gendar,
              "img": signUpParameter.img.isNotEmpty
                  ? await MultipartFile.fromFile(signUpParameter.img)
                  : null,
            }),
    );

    return SignUpModel.fromMap(response);
  }
}
