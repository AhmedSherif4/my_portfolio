import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_repository/base_repository.dart';
import '../../../../../../core/failure/failure.dart';
import '../../domain/parent_add_new_child_base_repository/parent_add_new_child_base_repository.dart';
import '../parent_add_new_child_data_source/parent_add_new_child_remote_data_source.dart';

@LazySingleton(
  as: ParentAddNewChildBaseRepository,
)
class ParentAddNewChildRepository implements ParentAddNewChildBaseRepository {
  final ParentAddNewChildRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  ParentAddNewChildRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> parentAddNewChild({
    required String mailOrPhone,
  }) async {
    final data = remoteDataSource.parentAddNewChild(
      mailOrPhone: mailOrPhone,
    );
    final jsonData =
        await baseRepository.checkExceptionForRemoteData<String>(data);
    return jsonData.fold(
      (failure) => left(failure),
      (data) => right(data),
    );
  }
}
