import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/shared_models/auth_entity/auth_entity.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import 'package:my_portfolio/features/auth/shared_screens/login/login.dart';

@LazySingleton()
class SocialLoginUseCase extends BaseUseCase<AuthEntity, String> {
  final LoginBaseRepository repository;

  SocialLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call(String parameter) async {
    return await repository.socialLogin(
      socialId: parameter,
    );
  }
}

