import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/features/parent_flow/home/domain/repositories/parent_home_repo.dart';

import '../data_source/remote/parent_home_remote_data_source.dart';

@LazySingleton(as: ParentHomeBaseRepository)
class ParentHomeRepository extends ParentHomeBaseRepository {
  final BaseRepository registry;
  final ParentHomeRemoteDataSource remoteDataSource;

  ParentHomeRepository({
    required this.registry,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getAllChildForParent(
      {int? parentId}) async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getAllChildForParent(parentId: parentId),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }
}
