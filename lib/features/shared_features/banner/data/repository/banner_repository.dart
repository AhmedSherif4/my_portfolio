import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/shared_features/banner/data/remote_data_source/banner_remote_data_source.dart';
import 'package:my_portfolio/features/shared_features/banner/domain/repository/banner_repository.dart';
import '../../../../../config/base_repository/base_repository.dart';
import '../../domain/entity/banner_entity_outputs.dart';


@LazySingleton(as:BannerRepository )
class BannerRepositoryImpl implements BannerRepository {
  final BaseRepository _baseRepository;
  final GetBannerRemoteDataSource _remoteDataSource;

  BannerRepositoryImpl(this._baseRepository, this._remoteDataSource);

  @override
  Future<Either<Failure, BannerEntityOutputs?>> getBanner() async{
    final response =
    await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.getBanner());
    return response;
  }
}
