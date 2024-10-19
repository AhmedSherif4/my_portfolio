part of '../.././sign_up.dart';

abstract class SignUpRemoteDataSource {
  Future<String> sendVerificationCode(
      {required SendVerificationCodeParameter sendVerificationCodeParameter});

}

@LazySingleton(
  as: SignUpRemoteDataSource,
)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  SignUpRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<String> sendVerificationCode(
      {required SendVerificationCodeParameter
          sendVerificationCodeParameter}) async {
    final response = await baseDataSource
        .postData(url: EndPoints.sendVerificationCodePath, body: {
      "email_or_phone": sendVerificationCodeParameter.emailOrPhone,
      "register_type": sendVerificationCodeParameter.userType.name,
      "send_type": sendVerificationCodeParameter.sendType.name,
    });
    return response['message'];
  }

}
