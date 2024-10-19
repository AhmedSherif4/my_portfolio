part of '../../edit_profile.dart';

@LazySingleton()
class ChangePasswordUseCase
    extends BaseUseCase<String, ChangePasswordParameters> {
  final EditProfileBaseRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      ChangePasswordParameters parameter) async {
    return await repository.changePassword(
      oldPassword: parameter.oldPassword,
      newPassword: parameter.newPassword,
    );
  }
}

class ChangePasswordParameters extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParameters({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
      ];
}
