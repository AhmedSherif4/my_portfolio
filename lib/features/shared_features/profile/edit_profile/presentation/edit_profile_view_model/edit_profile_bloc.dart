part of '../../edit_profile.dart';


@Injectable()
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUseCase editProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  EditProfileBloc(this.editProfileUseCase, this.changePasswordUseCase) : super(const EditProfileState()) {
    on<EditProfile>(_editProfile);
    on<ChangePassword>(_onChangePassword);
  }

  FutureOr<void> _editProfile(
      EditProfile event, Emitter<EditProfileState> emit) async {
    final userData = getIt<UserLocalDataSource>().getUserData();
    emit(state.copyWith(editStates: RequestStates.loading));
    final result = await editProfileUseCase(
      EditProfileParameter(
        name: event.name ?? userData?.name ?? 'لا يوجد اسم بعد',
        email: event.email ?? userData?.email ?? '',
        phone: event.phone ?? userData?.phone ?? '',
        image: event.image ?? userData?.imgPath ?? '',
        gender: event.gender ?? userData?.gender ?? 'male',
        withImage: event.withImage,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
            editStates: RequestStates.error, editMessage: failure.message));
      },
      (success) {
        emit(state.copyWith(
          editStates: RequestStates.loaded,
          editMessage: 'تم التعديل بنجاح',
        ));
      },
    );
  }

  FutureOr<void> _onChangePassword(
      ChangePassword event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(changePasswordStates: RequestStates.loading));
    final response = await changePasswordUseCase(
      ChangePasswordParameters(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );
    response.fold(
          (failure) {
        emit(state.copyWith(
          changePasswordStates: RequestStates.error,
          changePasswordMessage: failure.message,
        ));
      },
          (message) {
        emit(state.copyWith(
          changePasswordStates: RequestStates.loaded,
          changePasswordMessage: message,
        ));
      },
    );
  }
}
