import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import '../../../../config/base_local_data_source/base_local_data_source.dart';
import '../../../../config/storages/keys.dart';
import '../../../../config/storages/secure_storage.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../intro/onboarding/on_boarding.dart';
import '../../../shared_features/contact_us/domain/entity/contact_us_entity.dart';
import '../domain/more_usecases/more_usecase.dart';
import 'more_event.dart';
import 'more_state.dart';

@Injectable()
class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final LogoutUseCase logout;

  bool isLogoutButton = false;
  bool goToWelcome = false;
  bool refreshToken = false;
  bool fromRegister = false;
  late String token ;
  late UserEntity userData;

  MoreBloc(
    this.logout,
  ) : super(const MoreState()) {
    on<LogoutEvent>(
      (LogoutEvent event, Emitter<MoreState> emit) async {
        emit(state.copyWith(
          logoutState: RequestStates.loading,
        ));
        await logout(const NoParameter());
        add(ReOpenBoxesEvent());
        emit(
          state.copyWith(
            logoutState: RequestStates.loaded,
          ),
        );
      },
    );

    on<ReOpenBoxesEvent>(
        (ReOpenBoxesEvent event, Emitter<MoreState> emit) async {
     await Hive.deleteFromDisk().then((value) async {
        await Future.wait([
          Hive.openBox<String>(
              AppKeys.getExpirationKey(AppKeys.onBoardingViewed)),
          Hive.openBox<bool>(AppKeys.onBoardingViewed),
          Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.accessToken)),
          Hive.openBox<String>(AppKeys.accessToken),
          Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.contactUs)),
          Hive.openBox<ContactUsEntity>(AppKeys.contactUs),
          Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.userData)),
          Hive.openBox<UserEntity>(AppKeys.userData),
          Hive.openBox<String>(
              AppKeys.getExpirationKey(AppKeys.showcaseViewed)),
          Hive.openBox<bool>(AppKeys.showcaseViewed),
        ]);
        Future.delayed(const Duration(seconds: 2));

        getIt<OnBoardingLocalData>().saveOnBoardingValue(isShowed: true);
        getIt<BaseLocalDataSource>().saveDataInLocal<bool>(
          labelKey: AppKeys.showcaseViewed,
          data: true,
          expirationDuration: const Duration(days: 365),
        );
      });
    });

    on<GetScreens>((GetScreens event, Emitter<MoreState> emit) async {
      emit(state.copyWith(
        getScreenState: RequestStates.loading,
      ));
      try {
        final result = await Dio().get('https://taseese.org/screens/images');
        if (result.data != null) {
          emit(state.copyWith(
            getScreenState: RequestStates.loaded,
            childScreens: (result.data['child_view'] as List)
                .map((e) => e as String)
                .toList(),
            parentScreens: (result.data['parent_view'] as List)
                .map((e) => e as String)
                .toList(),
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          getScreenState: RequestStates.error,
        ));
      }
    });


    on<FormatAppEvent>((FormatAppEvent event, Emitter<MoreState> emit) async {
      emit(state.copyWith(formattedAppState: FormattedAppState.loading,));
      try {
         token = getIt<BaseAppSecurityData>().getToken()!;
        userData = getIt<UserLocalDataSource>().getUserData()!;
        // Future.delayed(const Duration(seconds: 3));
        await Hive.deleteFromDisk().then((value) async {
          await Future.wait([
            Hive.openBox<String>(
                AppKeys.getExpirationKey(AppKeys.onBoardingViewed)),
            Hive.openBox<bool>(AppKeys.onBoardingViewed),
            Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.accessToken)),
            Hive.openBox<String>(AppKeys.accessToken),
            Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.contactUs)),
            Hive.openBox<ContactUsEntity>(AppKeys.contactUs),
            Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.userData)),
            Hive.openBox<UserEntity>(AppKeys.userData),
            Hive.openBox<String>(
                AppKeys.getExpirationKey(AppKeys.showcaseViewed)),
            Hive.openBox<bool>(AppKeys.showcaseViewed),
          ]);
          Future.delayed(const Duration(seconds: 2));

          getIt<OnBoardingLocalData>().saveOnBoardingValue(isShowed: true);
          getIt<BaseLocalDataSource>().saveDataInLocal<bool>(
            labelKey: AppKeys.showcaseViewed,
            data: true,
            expirationDuration: const Duration(days: 365),
          );
        });

        // Future.delayed(const Duration(seconds: 3), () {
        //   getIt<BaseAppSecurityData>().saveToken(token: token);
        //   getIt<UserLocalDataSource>().saveUserData(userModel: userData);
        //   //     .then((value) => navigatorKey.currentState!.pushNamedAndRemoveUntil(
        //   //   AppRoutesNames.rHomeLayoutView,
        //   //   (route) => false,
        //   //   arguments: userData,
        //   //     ));
        // });
        emit(state.copyWith(formattedAppState: FormattedAppState.loaded,),);
      } catch (e) {
        emit(state.copyWith(formattedAppState: FormattedAppState.error,),);
      }

    });
  }
}
