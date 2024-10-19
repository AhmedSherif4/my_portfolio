part of '../../edit_profile.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class EditProfile extends EditProfileEvent {
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final bool withImage;
  final String? gender;

  const EditProfile({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.withImage = false,
    this.gender,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        image,
        withImage,
    gender,
      ];
}


class ChangePassword extends EditProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [
    oldPassword,
    newPassword,
  ];
}

