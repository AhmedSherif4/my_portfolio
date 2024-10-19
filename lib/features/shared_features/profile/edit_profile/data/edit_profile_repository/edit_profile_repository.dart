part of '../../edit_profile.dart';

@LazySingleton(as: EditProfileBaseRepository)
class EditProfileRepository implements EditProfileBaseRepository {
  final EditProfileRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final UserLocalDataSource userLocalDataSource;

  EditProfileRepository({
    required this.remoteDataSource,
    required this.baseRepository,
    required this.userLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> editProfile(
      EditProfileParameter parameter) async {
    final result = await baseRepository
        .checkExceptionForRemoteData(remoteDataSource.editProfile(parameter));

    return result.fold(
      (l) => left(l),
      (updatedUserData) async{
       await userLocalDataSource.saveUserData(userModel: updatedUserData);

        return right(updatedUserData);
      },
    );
  }

  @override
  Future<Either<Failure, String>> changePassword(
      {required oldPassword, required newPassword}) {
    return baseRepository.checkExceptionForRemoteData(
      remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),
    );
  }
}
