part of '../../edit_profile.dart';

class EditProfileState extends Equatable {
  final RequestStates editStates;
  final String editMessage;

  final RequestStates changePasswordStates;
  final String changePasswordMessage;

  const EditProfileState({
    this.editStates = RequestStates.initial,
    this.editMessage = '',
    this.changePasswordStates = RequestStates.initial,
    this.changePasswordMessage = '',
  });

  EditProfileState copyWith({
    RequestStates? editStates,
    String? editMessage,
    PickImageState? editImageProfileState,
    String? editImageProfileMessage,
    File? imageFile,
    RequestStates? changePasswordStates,
    String? changePasswordMessage,
  }) {
    return EditProfileState(
      editStates: editStates ?? this.editStates,
      editMessage: editMessage ?? this.editMessage,
      changePasswordStates: changePasswordStates ?? this.changePasswordStates,
      changePasswordMessage: changePasswordMessage ?? this.changePasswordMessage,
    );
  }

  @override
  List<Object?> get props => [
        editStates,
        editMessage,
        changePasswordStates,
        changePasswordMessage,
      ];
}
