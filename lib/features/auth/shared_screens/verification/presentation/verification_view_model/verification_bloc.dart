part of '../../verification.dart';

@Injectable()
class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final CheckVerificationCodeUseCase checkVerificationCodeUseCase;
  final ResendVerificationCodeUseCase resendVerificationCodeUseCase;
  final SignUpUseCase signUpUseCase;

  VerificationBloc(this.checkVerificationCodeUseCase,
      this.resendVerificationCodeUseCase, this.signUpUseCase)
      : super(const VerificationState()) {
    on<VerificationCodeChecked>(_checkVerificationCode);
    on<VerificationCodeResent>(_resendVerificationCode);
    on<SignedUp>(_signUp);
  }

  void _checkVerificationCode(event, emit) async {
    emit(state.copyWith(
      checkVerificationStates: RequestStates.loading,
      resendVerificationCodeStates: RequestStates.initial,
      signUpStates: RequestStates.initial,
    ));
    final result = await checkVerificationCodeUseCase(
      CheckVerificationCodeParameter(
        code: event.code,
        emailOrPhone: event.email,
      ),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
            checkVerificationStates: RequestStates.error,
            checkVerificationErrorMessage: failure.message));
      },
      (success) {
        emit(
          state.copyWith(
            checkVerificationStates: RequestStates.loaded,
            isCodeVerified: success,
          ),
        );
      },
    );
  }

  void _resendVerificationCode(event, emit) async {
    emit(state.copyWith(
      resendVerificationCodeStates: RequestStates.loading,
      checkVerificationStates: RequestStates.initial,
      signUpStates: RequestStates.initial,
    ));
    final result = await resendVerificationCodeUseCase(
      event.sendVerificationCodeParams,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
            resendVerificationCodeStates: RequestStates.error,
            resendVerificationCodeMessage: failure.message));
      },
      (success) {
        emit(
          state.copyWith(
            resendVerificationCodeStates: RequestStates.loaded,
            resendVerificationCodeMessage: success,
          ),
        );
      },
    );
  }

  late UserEntity userData;

  void _signUp(event, emit) async {
    emit(state.copyWith(
      signUpStates: RequestStates.loading,
      checkVerificationStates: RequestStates.initial,
      resendVerificationCodeStates: RequestStates.initial,
    ));
    final result = await signUpUseCase(event.signUpParameter);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            signUpStates: RequestStates.error,
            signUpMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            signUpStates: RequestStates.loaded,
            signUpMessage: success.message,
          ),
        );
        userData = success.user;
      },
    );
  }
}
