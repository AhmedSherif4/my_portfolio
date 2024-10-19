import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/shared_models/auth_entity/auth_entity.dart';

import '../../../../../../core/failure/failure.dart';
import '../social_register_usecases/social_register_usecase.dart';

abstract class SocialRegisterBaseRepository {
  Future<Either<Failure, AuthEntity>> socialRegister({
    required SocialRegisterData signUpParameter,
  });
}
