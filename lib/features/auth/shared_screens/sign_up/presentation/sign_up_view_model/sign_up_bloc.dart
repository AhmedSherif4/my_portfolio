part of '../.././sign_up.dart';

@Injectable()
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SendVerificationCodeUseCase signUpUseCase;
  final SocialLoginUseCase socialLoginUseCase;
  late UserEntity userData;

  SignUpBloc(
    this.signUpUseCase,
    this.socialLoginUseCase,
  ) : super(const SignUpState()) {
    on<VerificationCodeSentEvent>(_sendVerificationCode);
    on<SocialSignUpEvent>(_socialSignUp);
    //on<GetGoogleIdAndUserDataByGoogleAccountEvent>(_getGoogleID);
    //on<ImagePickEvent>(_getImage);
  }

  void _sendVerificationCode(event, emit) async {
    emit(state.copyWith(
      sendVerificationCodeStates: RequestStates.loading,
      getGoogleIdAndUserDataByGoogleAccountState: RequestStates.initial,
      pickImageState: PickImageState.init,
    ));
    final result = await signUpUseCase(
      event.sendVerificationCodeParams,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        sendVerificationCodeStates: RequestStates.error,
        sendVerificationCodeMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        sendVerificationCodeStates: RequestStates.loaded,
        sendVerificationCodeMessage: success,
      )),
    );
  }
  void _socialSignUp(event, emit) async {
    emit(
      state.copyWith(
        socialSignUpStates: RequestStates.loading,
        getGoogleIdAndUserDataByGoogleAccountState: RequestStates.initial,
        sendVerificationCodeStates: RequestStates.initial,
      ),
    );
    final result = await socialLoginUseCase(event.socialId);
    result.fold(
          (failure) {
        emit(
          state.copyWith(
            socialSignUpStates: RequestStates.error,
          ),
        );
      },
          (data) {
        emit(
          state.copyWith(
            socialSignUpStates: RequestStates.loaded,
          ),
        );
        userData = data.user;
      },
    );
  }
  // void _getGoogleID(event, emit) async {
  //   emit(state.copyWith(
  //     getGoogleIdAndUserDataByGoogleAccountState: RequestStates.loading,
  //     sendVerificationCodeStates: RequestStates.initial,
  //     pickImageState: PickImageState.init,
  //   ));
  //   try {
  //     final result = await getGoogleIdAndUserDataByGoogleAccountUserCase();
  //     result.fold(
  //         (l) => emit(state.copyWith(
  //             getGoogleIdAndUserDataByGoogleAccountState: RequestStates.error)),
  //         (r) {
  //       emit(
  //         state.copyWith(
  //           getGoogleIdAndUserDataByGoogleAccountState: RequestStates.loaded,
  //           socialLoginDataEntity: r,
  //         ),
  //       );
  //     });
  //   } catch (e) {
  //     emit(state.copyWith(
  //         getGoogleIdAndUserDataByGoogleAccountState: RequestStates.error));
  //   }
  // }

  // File? imageFile;
  //
  // void _getImage(ImagePickEvent event, Emitter<SignUpState> emit) async {
  //   emit(state.copyWith(
  //     pickImageState: PickImageState.startLoadingImage,
  //     getGoogleIdAndUserDataByGoogleAccountState: RequestStates.initial,
  //     sendVerificationCodeStates: RequestStates.initial,
  //   ));
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile == null) {
  //     emit(state.copyWith(
  //       pickImageState: PickImageState.imagePickedError,
  //       pickImageErrorMessage: 'لم يتم اختيار صورة',
  //     ));
  //     return;
  //   }
  //   imageFile = File(pickedFile.path);
  //   final isPngOrJpg = ['png', 'jpg', 'jpeg'].contains(
  //     imageFile!.path.split('.').last.toLowerCase(),
  //   );
  //   if (!isPngOrJpg) {
  //     emit(state.copyWith(
  //       pickImageState: PickImageState.imagePickedInValidFormat,
  //       pickImageErrorMessage: 'صيغة الصوره غير صحيحه',
  //     ));
  //     return;
  //   }
  //   final fileLength = await imageFile!.length();
  //   final fileSizeInMegabytes = fileLength / (1024 * 1024);
  //   if (fileSizeInMegabytes > 1) {
  //     final originalImage = File(pickedFile.path);
  //     final resizedImage = await _resizeImage(originalImage, 1);
  //     await originalImage.writeAsBytes(resizedImage.readAsBytesSync());
  //     imageFile = originalImage;
  //   }
  //   emit(state.copyWith(
  //     pickImageState: PickImageState.imagePickedSuccessfully,
  //     pickImageErrorMessage: '',
  //   ));
  // }
  //
  // Future<File> _resizeImage(File file, int maxSizeInMB) async {
  //   final originalImage = img.decodeImage(await file.readAsBytes());
  //
  //   final fileSizeInBytes = await file.length();
  //   final maxSizeInBytes = maxSizeInMB * 1024 * 1024;
  //   final scaleFactor = (maxSizeInBytes / fileSizeInBytes).clamp(0.0, 1.0);
  //
  //   final newWidth = (originalImage!.width * scaleFactor).round();
  //   final newHeight = (originalImage.height * scaleFactor).round();
  //
  //   final resizedImage = img.copyResize(originalImage,
  //       width: newWidth,
  //       height: newHeight,
  //       interpolation: img.Interpolation.linear);
  //
  //   final resizedFile =
  //       File(file.path.replaceAll(RegExp(r'\.\w+$'), '_resized.jpg'));
  //   await resizedFile.writeAsBytes(img.encodeJpg(resizedImage, quality: 85));
  //
  //   return resizedFile;
  // }
}
