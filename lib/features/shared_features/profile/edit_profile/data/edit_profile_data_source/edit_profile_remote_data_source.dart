part of '../../edit_profile.dart';

abstract class EditProfileRemoteDataSource {
  Future<UserEntity> editProfile(EditProfileParameter parameter);
  Future<String> changePassword({
    required oldPassword,
    required newPassword,
  });
}

@LazySingleton(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  EditProfileRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<UserEntity> editProfile(EditProfileParameter parameter) async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()
          ? EndPoints.editProfile
          : AppReference.userIsParent()
              ? EndPoints.parentEditProfile
              : EndPoints.institutionEditProfile,
      body: (parameter.withImage)
          ? FormData.fromMap({
              "name": parameter.name,
              "email": parameter.email,
              "phone": parameter.phone,
              "gendar": parameter.gender,
              "img": (parameter.image != null && parameter.image!.isNotEmpty)
                  ? await MultipartFile.fromFile(parameter.image!)
                  : null,
            })
          : {
              "name": parameter.name,
              "email": parameter.email,
              "phone": parameter.phone,
              "gendar": parameter.gender,
            },
    );
    return UserModel.fromMap(response['data']);
  }
  @override
  Future<String> changePassword({
    required oldPassword,
    required newPassword,
  }) async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()
          ? EndPoints.changePasswordPath
          : AppReference.userIsParent()
          ? EndPoints.parentChangePasswordPath
          : EndPoints.institutionChangePasswordPath,
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );
    return response['message'] as String;
  }
}

class EditProfileParameter extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String? image;
  final bool withImage;

  const EditProfileParameter({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    this.image,
    this.withImage = false,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        gender,
        image,
        withImage,
      ];
}
