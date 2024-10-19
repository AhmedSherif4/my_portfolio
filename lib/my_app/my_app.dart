
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/theme/light_theme.dart';
import 'package:my_portfolio/config/responsive/responsive.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/features/intro/global/data/app_time_data.dart';
import 'package:my_portfolio/features/intro/splash/presentation/splash_view_model/splash_bloc.dart';
import 'package:my_portfolio/features/intro/splash/presentation/splash_view_model/splash_event.dart';
import 'package:my_portfolio/features/shared_logic/localization_logic/presentation/localization_view_model/localization_bloc.dart';
import 'package:my_portfolio/my_app/deep_link.dart';
import '../config/internet_connection/internet_connection_setup.dart';
import '../config/routes/routes_generator.dart';
import '../config/routes/routes_names.dart';
import '../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../features/intro/global/domain/global_usecases/global_usecase.dart';
import '../features/intro/global/global_view_model/global_bloc.dart';
import '../features/intro/global/global_view_model/global_event.dart';
import '../features/shared_logic/localization_logic/presentation/localization_view_model/localization_state.dart';
import 'app_reference.dart';
import 'dart:ui' as ui;

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    DeepLinkManager.instance.initDeepLink();
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    ResponsiveManager.init(context);

    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        AppTimeData.setStartTime(DateTime.now());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        if (getIt<UserLocalDataSource>().getUserData() != null &&
            AppReference.userIsChild() &&
            !AppReference.userIsGuest()) {
          AppTimeData.setEndTime(DateTime.now());
          AppTimeData.endTimeGetter()
                      .difference(AppTimeData.startTimeGetter())
                      .inMinutes <= 3
              ? null
              : getIt<SendTimeUseCase>()
                  .call(
                    AppTimeData.endTimeGetter()
                        .difference(AppTimeData.startTimeGetter())
                        .inMinutes,
                  )
                  .then((value) {})
                  .catchError((onError) {});
        }
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          // create: (context) => getIt<SplashBloc>()..add(CheckDevice()),
          create: (context) => getIt<SplashBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LanguageBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GlobalBloc>()..add(GetInfoDataEvent())..add(CheckAppVersionEvent()),
        )
      ],
      child:  Stack(
        alignment: AlignmentDirectional.bottomStart,
        textDirection: ui.TextDirection.ltr,
        children: [
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar', 'SA'),
                ],
                locale: state.selectedLanguage.value,

                debugShowCheckedModeBanner: false,
                title: AppStrings.appNameArabic,
                themeMode: ThemeMode.light,
                theme: appLightTheme(),
                onGenerateRoute: AppRouteGenerator.onGenerateRoute,
                initialRoute: AppRoutesNames.rSplashScreen,
                navigatorKey: navigatorKey,
              );
            },
          ),
          const ConnectionAlert(),
        ],
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

