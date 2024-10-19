import 'package:dartz/dartz.dart';
import '../../../../../../core/failure/failure.dart';
import '../entity/social_login_data_entity.dart';

abstract class GetSocialDataBaseRepository {
  Future<Either<Failure, SocialLoginDataEntity>> getGoogleData();
  Future<Either<Failure, SocialLoginDataEntity>> getAppleData();
}
