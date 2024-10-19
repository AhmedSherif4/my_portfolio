
part of '../../login.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  final SocialLoginUseCase socialLoginUseCase;

  late UserEntity userData;

  LoginBloc(
      {required this.loginUseCase,
        required this.socialLoginUseCase})
      : super(const LoginState()) {
    on<LoggedIn>(
          (event, emit) async {
        emit(state.copyWith(
          loginStates: RequestStates.loading,
          socialLoginStates: RequestStates.initial,
        ));
        final result = await loginUseCase(LoginParameter(
            email: event.email,
            password: event.password,
            userType: event.userType));
        result.fold(
              (failure) {
            emit(
              state.copyWith(
                loginStates: RequestStates.error,
                loginMessage: failure.message,
              ),
            );
          },
              (data) {
            emit(
              state.copyWith(
                loginStates: RequestStates.loaded,
                loginMessage: data.message.isEmpty
                    ? AppStrings.loginSuccessfully
                    : data.message,
              ),
            );
            userData = data.user;
          },
        );
      },
    );


    on<SocialLoginEvent>(
          (SocialLoginEvent event, emit) async {
        emit(
          state.copyWith(
            socialLoginStates: RequestStates.loading,
            loginStates: RequestStates.initial,
          ),
        );
        final result = await socialLoginUseCase(event.socialId);
        result.fold(
              (failure) {
            emit(
              state.copyWith(
                socialLoginStates: RequestStates.error,
              ),
            );
          },
              (data) {
            emit(
              state.copyWith(
                socialLoginStates: RequestStates.loaded,
              ),
            );
            userData = data.user;
          },
        );
      },
    );

  }
}
