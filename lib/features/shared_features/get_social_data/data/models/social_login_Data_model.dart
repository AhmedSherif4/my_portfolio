
import '../../domain/entity/social_login_data_entity.dart';

class GoogleSignInDataModel extends SocialLoginDataEntity {
  const GoogleSignInDataModel({
    required super.email,
    required super.displayName,
    required super.photoUrl,
    required super.socialId,
  });
}
