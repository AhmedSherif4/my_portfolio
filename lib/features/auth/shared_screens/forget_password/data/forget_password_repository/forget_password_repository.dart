part of '../../forget_password.dart';

@LazySingleton(
  as: ForgetPasswordBaseRepository,
)
class ForgetPasswordRepository implements ForgetPasswordBaseRepository {
  final ForgetPasswordRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  ForgetPasswordRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> forgetPassword({
    required String email,
    required UsersType userType,
    required SendType sendType,
  }) async {
    final data = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.forgetPassword(
        email: email,
        userType: userType,
        sendType: sendType,
      ),
    );

    return data.fold(
      (failure) {
        return left(failure);
      },
      (success) {
        return right(success);
      },
    );
  }
}
