// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:my_portfolio/config/base_local_data_source/base_local_data_source.dart'
    as _i603;
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart'
    as _i852;
import 'package:my_portfolio/config/base_repository/base_repository.dart'
    as _i318;
import 'package:my_portfolio/config/notification/notification_setup.dart'
    as _i465;
import 'package:my_portfolio/config/resources/localization_logic/presentation/localization_view_model/localization_bloc.dart'
    as _i979;
import 'package:my_portfolio/config/storages/secure_storage.dart' as _i170;
import 'package:my_portfolio/core/api/api_consumer.dart' as _i569;
import 'package:my_portfolio/core/api/dio_consumer.dart' as _i259;
import 'package:my_portfolio/core/api/interceptors.dart' as _i282;
import 'package:my_portfolio/core/api/network_info.dart' as _i494;
import 'package:my_portfolio/core/services/third_party_instance.dart' as _i360;
import 'package:my_portfolio/core/shared_models/user/data/user_local_data_source/user_local_data_source.dart'
    as _i608;
import 'package:my_portfolio/core/shared_widget/image_pick/image_pick_view_model/image_pick_bloc.dart'
    as _i183;
import 'package:my_portfolio/my_app/global/global_view_model/global_bloc.dart'
    as _i436;
import 'package:my_portfolio/my_app/splash/splash_screen.dart' as _i640;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i979.LanguageBloc>(() => _i979.LanguageBloc());
    gh.factory<_i183.ImagePickBloc>(() => _i183.ImagePickBloc());
    gh.factory<_i436.GlobalBloc>(() => _i436.GlobalBloc());
    gh.factory<_i640.SplashBloc>(() => _i640.SplashBloc());
    gh.lazySingleton<_i282.AppInterceptors>(() => _i282.AppInterceptors());
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dio);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => injectableModule.internetConnectionChecker);
    gh.lazySingleton<_i494.NetworkInfo>(
        () => _i494.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i603.BaseLocalDataSource>(
        () => _i603.BaseLocalDataSourceImpl());
    gh.lazySingleton<_i608.UserLocalDataSource>(() =>
        _i608.UserLocalDataSourceImpl(
            baseLocalDataSource: gh<_i603.BaseLocalDataSource>()));
    gh.lazySingleton<_i318.BaseRepository>(() => _i318.BaseRepositoryImpl());
    gh.lazySingleton<_i170.BaseAppSecurityData>(() => _i170.AppSecurityData(
        localDataSource: gh<_i603.BaseLocalDataSource>()));
    gh.lazySingleton<_i569.ApiConsumer>(
        () => _i259.DioConsumer(client: gh<_i361.Dio>()));
    gh.lazySingleton<_i852.BaseRemoteDataSource>(
        () => _i852.BaseRemoteDataSourceImpl(
              apiConsumer: gh<_i569.ApiConsumer>(),
              networkInfo: gh<_i494.NetworkInfo>(),
            ));
    gh.lazySingleton<_i465.NotificationSetup>(
        () => _i465.NotificationSetup(apiConsumer: gh<_i569.ApiConsumer>()));
    return this;
  }
}

class _$InjectableModule extends _i360.InjectableModule {}
