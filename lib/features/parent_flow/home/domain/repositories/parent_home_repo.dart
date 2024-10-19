import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';

import '../../../../../core/failure/failure.dart';

abstract class ParentHomeBaseRepository {
  Future<Either<Failure, List<UserEntity>>> getAllChildForParent(
      {int? parentId});
}
