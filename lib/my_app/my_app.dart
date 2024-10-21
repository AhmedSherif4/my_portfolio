import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/base_local_data_source/app_preferences.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/my_app/deep_link.dart';

import '../config/adaptive/platform_builder.dart';
import '../config/resources/theme_mode/theme_manager.dart';
import '../config/routes/routes_generator.dart';
import '../config/routes/routes_names.dart';
import 'app_reference.dart';
import 'app_settings/app_settings_cubit.dart';

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
    AppReference.getDeviceInfo(context);
    ResponsiveManager.init(context);
    if (mounted) {
      getIt<AppPreferences>()
          .getLocale()
          .then((currentLocale) => context.setLocale(currentLocale));
    }
    super.didChangeDependencies();
  }

  //! for tracking the time the user spends in the app
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       AppTimeData.setStartTime(DateTime.now());
  //       break;
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.paused:
  //       if (getIt<UserLocalDataSource>().getUserData() != null &&
  //           AppReference.userIsChild() &&
  //           !AppReference.userIsGuest()) {
  //         AppTimeData.setEndTime(DateTime.now());
  //         AppTimeData.endTimeGetter()
  //                     .difference(AppTimeData.startTimeGetter())
  //                     .inMinutes <= 3
  //             ? null
  //             : getIt<SendTimeUseCase>()
  //                 .call(
  //                   AppTimeData.endTimeGetter()
  //                       .difference(AppTimeData.startTimeGetter())
  //                       .inMinutes,
  //                 )
  //                 .then((value) {})
  //                 .catchError((onError) {});
  //       }
  //       break;
  //     case AppLifecycleState.hidden:
  //     case AppLifecycleState.detached:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // MaterialApp initialMaterialApp(AppSettingsState state) {
    //   return MaterialApp(
    //
    //   );
    // }
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   // create: (context) => getIt<SplashBloc>()..add(CheckDevice()),
        //   create: (context) => getIt<SplashBloc>(),
        // ),
        BlocProvider(
          create: (context) => getIt<AppSettingsCubit>(),
        ),
        // BlocProvider(
        //   create: (context) => getIt<GlobalBloc>()
        //   // ..add(GetInfoDataEvent())..add(CheckAppVersionEvent())
        //   ,
        // )
      ],
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        textDirection: ui.TextDirection.ltr,
        children: [
          BlocBuilder<AppSettingsCubit, AppSettingsState>(
            builder: (context, state) {
              return PlatformBuilder(
                androidBuilder: _materialApp,
                iosBuilder: _cupertinoApp,
                webBuilder: _materialApp,
                windowsBuilder: _materialApp,
              );
            },
          ),
          //! for checking the internet connection
          // const ConnectionAlert(),
        ],
      ),
    );
  }

  Widget _materialApp(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName.tr(),
      theme: ThemeManager.appThemeData[AppTheme.light],
      darkTheme: ThemeManager.appThemeData[AppTheme.dark],
      themeMode: context.read<AppSettingsCubit>().getThemeMode()
          ? ThemeMode.dark
          : ThemeMode.light,
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      initialRoute: AppRoutesNames.rSplashScreen,
      navigatorKey: navigatorKey,
    );
  }

  Widget _cupertinoApp(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName.tr(),
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      initialRoute: AppRoutesNames.rSplashScreen,
      navigatorKey: navigatorKey,
      theme: CupertinoThemeData(
        brightness: context.read<AppSettingsCubit>().getThemeMode()
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
