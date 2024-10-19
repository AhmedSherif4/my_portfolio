part of '../../login.dart';

@LazySingleton(
  as: LoginBaseRepository,
)
class LoginRepository implements LoginBaseRepository {
  final LoginRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final UserLocalDataSource userLocalDataSource;

  LoginRepository({
    required this.remoteDataSource,
    required this.baseRepository,
    required this.userLocalDataSource,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
      {required String email,
      required String password,
      required UsersType userType}) async {
    final userModelFromRemoteData = remoteDataSource.login(
      email: email,
      password: password,
      userType: userType,
    );
    final data = await baseRepository
        .checkExceptionForRemoteData<AuthEntity>(userModelFromRemoteData);
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

  @override
  Future<Either<Failure, AuthEntity>> socialLogin(
      {required String socialId}) async {
    final data = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.socialLogin(
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
