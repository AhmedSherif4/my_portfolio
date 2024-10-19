import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../config/resources/app_strings.dart';
import '../../../../../../core/api/network_info.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../config/base_repository/base_repository.dart';
import '../../../../../config/storages/secure_storage.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';

import '../../../../../core/shared_models/auth_entity/auth_entity.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../get_social_data/domain/entity/social_login_data_entity.dart';
import '../../domain/social_login_base_repository/social_login_base_repository.dart';
import '../social_login_remote_data_source/social_login_remote_data_source.dart';

@LazySingleton(
  as: SocialLoginBaseRepository,
)
class SocialLoginRepositoryImpl extends SocialLoginBaseRepository {
  final BaseRepository baseRepository;
  final UserLocalDataSource userLocalDataSource;
  final SocialLoginBaseRemoteDataSource socialLoginBaseRemoteDataSource;
  final NetworkInfo networkInfo;

  SocialLoginRepositoryImpl(
      {required this.socialLoginBaseRemoteDataSource,
      required this.userLocalDataSource,
      required this.baseRepository,
      required this.networkInfo});

  @override
  Future<Either<Failure, SocialLoginDataEntity>>
      getGoogleIdAndUserDataByGoogleAccount() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await socialLoginBaseRemoteDataSource
            .getGoogleIdAndUserDataByGoogleAccount());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return left(const ServerFailure(AppStrings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> socialLogin(
      {required String socialId}) async {
    final data = await baseRepository.checkExceptionForRemoteData(
      socialLoginBaseRemoteDataSource.socialLogin(
        socialID: socialId,
      ),
    );
    return data.fold(
          (failure) => left(failure),
          (data) async {
        if (data.user.type != UsersType.child.name) {
          await userLocalDataSource.saveUserData(userModel: data.user);
          await getIt<BaseAppSecurityData>().saveToken(token: data.token);
          return Right(data);
        } else {
          if (data.user.lock == 'yes') {
            return Right(data);
          } else {
            await userLocalDataSource.saveUserData(userModel: data.user);
            await getIt<BaseAppSecurityData>().saveToken(token: data.token);
            return Right(data);
          }
        }
      },
    );
  }
}


