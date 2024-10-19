import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';

import '../../../../../config/base_repository/base_repository.dart';
import '../../domain/repository/institution_repo.dart';
import '../remote_data_source/institutions_remote_data_source.dart';

@LazySingleton(as: InstitutionHomeBaseRepository)
class InstitutionHomeRepository extends InstitutionHomeBaseRepository {
  final BaseRepository registry;
  final InstitutionHomeRemoteDataSource remoteDataSource;

  InstitutionHomeRepository({
    required this.registry,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>>
      getAllParentsForInstitution() async {
    final jsonData = await registry.checkExceptionForRemoteData(
      remoteDataSource.getAllParentsForInstitution(),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        return Right(data);
      },
    );
  }
}
