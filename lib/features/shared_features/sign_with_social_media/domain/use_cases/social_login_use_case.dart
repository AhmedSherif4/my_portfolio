import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import 'package:my_portfolio/features/shared_features/sign_with_social_media/domain/social_login_base_repository/social_login_base_repository.dart';

import '../../../../../core/shared_models/auth_entity/auth_entity.dart';

@LazySingleton()
class SocialLoginUseCase extends BaseUseCase<AuthEntity, String> {
  final SocialLoginBaseRepository repository;

  SocialLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call(String parameter) async {
    return await repository.socialLogin(
      socialId: parameter,
    );
  }
}
