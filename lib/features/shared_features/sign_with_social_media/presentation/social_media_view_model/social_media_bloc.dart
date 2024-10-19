import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../domain/use_cases/get_google_id_and_user_data_by_google_account.dart';
import '../../domain/use_cases/social_login_use_case.dart';
import 'social_media_event.dart';
import 'social_media_state.dart';
@injectable
class SignWithSocialMediaBloc extends Bloc<SignWithSocialMediaEvent, SignWithSocialMediaState> {
  final GetGoogleIdAndUserDataByGoogleAccountUseCase getGoogleIdAndUserDataByGoogleAccountUserCase;
  final SocialLoginUseCase socialLoginUseCase;
  late UserEntity userData;

  SignWithSocialMediaBloc(
      {
      required this.getGoogleIdAndUserDataByGoogleAccountUserCase,
        required this.socialLoginUseCase
      })
      : super(const SignWithSocialMediaState()) {
    on<GetGoogleIdAndUserDataByGoogleAccountEvent>((event, emit) async {
      emit(state.copyWith(
         socialLoginStates: RequestStates.initial,
        getGoogleIdAndUserDataByGoogleAccountState: RequestStates.loading,
      ));
      try {
        final result = await getGoogleIdAndUserDataByGoogleAccountUserCase();
        result.fold(
            (l) => emit(
                  state.copyWith(
                    getGoogleIdAndUserDataByGoogleAccountState: RequestStates.error,
                  ),
                ), (r) {
          emit(
            state.copyWith(
              getGoogleIdAndUserDataByGoogleAccountState: RequestStates.loaded,
              socialLoginDataEntity: r,
            ),
          );
        });
      } catch (e) {
        emit(state.copyWith(
            getGoogleIdAndUserDataByGoogleAccountState: RequestStates.error));
      }
    });

    on<SocialLoginEvent>(
          (SocialLoginEvent event, emit) async {
        emit(
          state.copyWith(
            socialLoginStates: RequestStates.loading,
            getGoogleIdAndUserDataByGoogleAccountState: RequestStates.initial,
          ),
        );
        final result = await socialLoginUseCase(event.socialId);
        result.fold(
              (failure) {
            emit(
              state.copyWith(
                socialLoginStates: RequestStates.error,
                loginMessage: failure.message
              ),
            );
          },
              (data) {
            emit(
              state.copyWith(
                socialLoginStates: RequestStates.loaded,
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

  }
}
