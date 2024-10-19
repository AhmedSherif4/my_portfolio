import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/get_social_data/data/get_social_remote_data_source/get_social_remote_data_source.dart';
import '../../../../../../config/resources/app_strings.dart';
import '../../../../../../core/api/network_info.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../config/base_repository/base_repository.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../domain/entity/social_login_data_entity.dart';
import '../../domain/get_social_base_repository/get_social_base_repository.dart';


@LazySingleton(
  as: GetSocialDataBaseRepository,
)
class GetSocialDataRepositoryImpl extends GetSocialDataBaseRepository {
  final BaseRepository baseRepository;
  final UserLocalDataSource userLocalDataSource;
  final GetSocialDataBaseRemoteDataSource getSocialDataBaseRemoteDataSource;
  final NetworkInfo networkInfo;

  GetSocialDataRepositoryImpl(
      {required this.getSocialDataBaseRemoteDataSource,
      required this.userLocalDataSource,
      required this.baseRepository,
      required this.networkInfo});

  @override
  Future<Either<Failure, SocialLoginDataEntity>> getAppleData()async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await getSocialDataBaseRemoteDataSource.getAppleData());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return left(const ServerFailure(AppStrings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, SocialLoginDataEntity>> getGoogleData()async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await getSocialDataBaseRemoteDataSource.getGoogleData());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return left(const ServerFailure(AppStrings.noInternetConnection));
    }
  }
}


