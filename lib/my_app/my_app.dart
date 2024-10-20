import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/theme/light_theme.dart';
import 'package:my_portfolio/config/responsive/responsive.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/my_app/deep_link.dart';
import 'package:my_portfolio/my_app/splash/splash_screen.dart';

import '../config/adaptive/platform_builder.dart';
import '../config/resources/localization_logic/presentation/localization_view_model/localization_bloc.dart';
import '../config/resources/localization_logic/presentation/localization_view_model/localization_state.dart';
import '../config/routes/routes_generator.dart';
import '../config/routes/routes_names.dart';
import 'global/global_view_model/global_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   // create: (context) => getIt<SplashBloc>()..add(CheckDevice()),
        //   create: (context) => getIt<SplashBloc>(),
        // ),
        BlocProvider(
          create: (context) => getIt<LanguageBloc>(),
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
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return PlatformBuilder(
                androidBuilder: (context) => MaterialApp(
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
                ),
                iosBuilder: (context) => const CupertinoApp(),
                webBuilder: (context) => const MaterialApp(
                  onGenerateRoute: AppRouteGenerator.onGenerateRoute,
                  initialRoute: AppRoutesNames.rSplashScreen,
                ),
              );
            },
          ),
          // const ConnectionAlert(),
        ],
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
