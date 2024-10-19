import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../../../core/exceptions/exceptions.dart';
import '../../../../../../my_app/app_reference.dart';
import '../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../config/notification/notification_setup.dart';
import '../../../../../config/storages/secure_storage.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_models/auth_entity/auth_entity.dart';
import '../../../../auth/shared_screens/login/data/models/login_model.dart';
import '../../../get_social_data/domain/entity/social_login_data_entity.dart';

abstract class SocialLoginBaseRemoteDataSource {
  Future<SocialLoginDataEntity> getGoogleIdAndUserDataByGoogleAccount();
  Future<AuthEntity> socialLogin({required String socialID});
}

@LazySingleton(
  as: SocialLoginBaseRemoteDataSource,
)
class SocialLoginRemoteDataSourceImpl extends SocialLoginBaseRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email', 'profile', 'openid']);

  SocialLoginRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<SocialLoginDataEntity> getGoogleIdAndUserDataByGoogleAccount() async {
    try {
      if(AppReference.deviceIsIos){
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],);

        return SocialLoginDataEntity(
          email: credential.email ?? '',
          displayName:  (credential.familyName != null || credential.givenName != null)  ? '${credential.givenName} ${credential.familyName}' : 'name not set',
          photoUrl:  '',
          socialId: credential.userIdentifier ?? credential.authorizationCode,
        );

      }else{
        if (await _googleSignIn.isSignedIn()) {
          await _googleSignIn.signOut();
        }
        await _googleSignIn.signIn();
        final currentUser = _googleSignIn.currentUser;
        if (currentUser != null) {
          return SocialLoginDataEntity(
            email: currentUser.email,
            displayName: currentUser.displayName ?? 'name not set',
            photoUrl: currentUser.photoUrl ?? '',
            socialId: currentUser.id,
          );
        } else {
          throw const ServerException(message: 'Failed to sign in with Google');
        }
      }

    } catch (error) {

      throw ServerException(message: 'Failed to sign in : $error');
    }
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
