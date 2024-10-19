import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';

abstract class InstitutionHomeBaseRepository {
  Future<Either<Failure, List<UserEntity>>> getAllParentsForInstitution();
}
