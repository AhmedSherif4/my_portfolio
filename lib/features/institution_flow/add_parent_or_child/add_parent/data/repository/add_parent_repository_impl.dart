import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/use_case/add_parent_use_case.dart';

import '../../../../../../config/base_repository/base_repository.dart';
import '../../domain/repository/add_parent_repositoty.dart';
import '../remote_data/add_parent_remote_data.dart';

@LazySingleton(
  as: AddParentRepository,
)
class AddParentRepositoryImpl implements AddParentRepository {
  final AddParentRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  AddParentRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> addNewParent(
      {required AddParentParameter addParentParameter}) async {
    final data = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.addParent(
        addParentParameter: addParentParameter,
      ),
    );
    return data.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
