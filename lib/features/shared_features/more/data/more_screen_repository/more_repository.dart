import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import '../../domain/global_base_repository/more_base_repository.dart';
import '../more_data_source/more_remote_data_source.dart';

@LazySingleton(as: MoreBaseRepository)
class MoreRepository implements MoreBaseRepository {
  final MoreBaseRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  MoreRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, bool>> logout() async {
    final json = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.logout(),
    );
    return json.fold(
      (failure) => left(failure),
      (data) => right(data),
    );
  }
}
