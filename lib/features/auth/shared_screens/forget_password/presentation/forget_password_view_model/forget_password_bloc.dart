part of '../../forget_password.dart';

@Injectable()
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordBloc(this.forgetPasswordUseCase)
      : super(const ForgetPasswordState()) {
    on<SentEmailForForgettingPassword>(
      (event, emit) async {
        emit(state.copyWith(forgetPasswordStates: RequestStates.loading));
        final result = await forgetPasswordUseCase(
          ForgetPasswordParameter(
            email: event.email,
            userType: event.userType,
            sendType: event.sendType,
          ),
        );
        result.fold(
          (failure) => emit(state.copyWith(
              forgetPasswordStates: RequestStates.error,
              forgetPasswordMessage: failure.message)),
          (success) => emit(
            state.copyWith(
              forgetPasswordStates: RequestStates.loaded,
              forgetPasswordMessage: success,
            ),
          ),
        );
      },
    );
  }
}
