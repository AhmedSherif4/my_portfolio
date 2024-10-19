import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/get_social_data/domain/use_cases/get_google_data.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../domain/use_cases/get_apple_data.dart';
import 'get_social_data_event.dart';
import 'get_social_data_state.dart';

@injectable
class GetSocialDataBloc extends Bloc<GetSocialDataEvent, GetSocialDataState> {
  final GetGoogleDataUseCase getGoogleDataUseCase;
  final GetAppleDataUseCase getAppleDataUseCase;
  late UserEntity userData;

  GetSocialDataBloc(
      {
      required this.getGoogleDataUseCase,
        required this.getAppleDataUseCase,
      })
      : super(const GetSocialDataState()) {
    on<GetGoogleDataEvent>((event, emit) async {
      emit(state.copyWith(
        getGoogleDataState: RequestStates.loading,
        getAppleDataState: RequestStates.initial,
      ));
      try {
        final result = await getGoogleDataUseCase();
        result.fold(
            (l) => emit(
                  state.copyWith(
                    getGoogleDataState: RequestStates.error,
                  ),
                ), (r) {
          emit(
            state.copyWith(
              getGoogleDataState: RequestStates.loaded,
              socialLoginDataEntity: r,
            ),
          );
        });
      } catch (e) {
        emit(state.copyWith(
            getGoogleDataState: RequestStates.error));
      }
    });
    on<GetAppleDataEvent>((event, emit) async {
      emit(state.copyWith(
        getAppleDataState: RequestStates.loading,
        getGoogleDataState: RequestStates.initial,
      ));
      try {
        final result = await getAppleDataUseCase();
        result.fold(
            (l) => emit(
                  state.copyWith(
                    getAppleDataState: RequestStates.error,
                  ),
                ), (r) {
          emit(
            state.copyWith(
              getAppleDataState: RequestStates.loaded,
              socialLoginDataEntity: r,
            ),
          );
        });
      } catch (e) {
        emit(state.copyWith(
            getAppleDataState: RequestStates.error));
      }
    });
  }
}
