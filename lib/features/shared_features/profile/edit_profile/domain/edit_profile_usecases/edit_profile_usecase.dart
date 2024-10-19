part of '../../edit_profile.dart';

@LazySingleton()
class EditProfileUseCase extends BaseUseCase<UserEntity, EditProfileParameter> {
  final EditProfileBaseRepository repository;

  EditProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(
      EditProfileParameter parameter) async {
    return await repository.editProfile(parameter);
  }
}
