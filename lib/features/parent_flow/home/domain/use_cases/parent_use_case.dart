import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/features/parent_flow/home/domain/repositories/parent_home_repo.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';

@LazySingleton()
class GetAllChildForParentUseCase extends BaseUseCase<List<UserEntity>, int> {
  final ParentHomeBaseRepository repository;

  GetAllChildForParentUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(int? parameter) async {
    return await repository.getAllChildForParent(parentId: parameter);
  }
}
