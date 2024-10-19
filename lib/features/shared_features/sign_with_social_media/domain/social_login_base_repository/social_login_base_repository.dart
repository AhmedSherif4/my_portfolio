import 'package:dartz/dartz.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../core/shared_models/auth_entity/auth_entity.dart';
import '../../../get_social_data/domain/entity/social_login_data_entity.dart';

abstract class SocialLoginBaseRepository {
  Future<Either<Failure, SocialLoginDataEntity>> getGoogleIdAndUserDataByGoogleAccount();
  Future<Either<Failure, AuthEntity>> socialLogin({
    required String socialId,
  });
}
