part of '../../edit_profile.dart';

abstract class EditProfileBaseRepository {
  Future<Either<Failure, UserEntity>> editProfile(
      EditProfileParameter parameter);
  Future<Either<Failure, String>> changePassword({
    required oldPassword,
    required newPassword,
  });
}
