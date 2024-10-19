import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../../../core/exceptions/exceptions.dart';
import '../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../domain/entity/social_login_data_entity.dart';

abstract class GetSocialDataBaseRemoteDataSource {
  Future<SocialLoginDataEntity> getGoogleData();
  Future<SocialLoginDataEntity> getAppleData();
}

@LazySingleton(
  as: GetSocialDataBaseRemoteDataSource,
)
class GetSocialDataRemoteDataSourceImpl extends GetSocialDataBaseRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile', 'openid']);

  GetSocialDataRemoteDataSourceImpl(this.baseDataSource);
  @override
  Future<SocialLoginDataEntity> getAppleData() async {
    try {
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
    } catch (error) {
      throw ServerException(message: 'Failed to sign in : $error');
    }
  }

  @override
  Future<SocialLoginDataEntity> getGoogleData()async {
    try {
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
    } catch (error) {

      throw ServerException(message: 'Failed to sign in : $error');
    }
  }
}
