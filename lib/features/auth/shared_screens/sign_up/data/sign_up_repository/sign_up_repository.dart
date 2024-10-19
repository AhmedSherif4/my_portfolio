part of '../.././sign_up.dart';

@LazySingleton(
  as: SignUpBaseRepository,
)
class SignUpRepository implements SignUpBaseRepository {
  final SignUpRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  SignUpRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> sendVerificationCode({
    required SendVerificationCodeParameter sendVerificationCodeParameter,
  }) async {
    final jsonFromRemoteData = remoteDataSource.sendVerificationCode(
        sendVerificationCodeParameter: sendVerificationCodeParameter);
    final data =
        await baseRepository.checkExceptionForRemoteData(jsonFromRemoteData);
    return data.fold(
      (failure) => Left(failure),
      (message) {
        return Right(message);
      },
    );
  }
}
