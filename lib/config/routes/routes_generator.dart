import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/features/home/view_model/home_cubit.dart';

import '../../core/services/services_locator.dart';
import '../../features/home/home.dart';
import '../../my_app/splash/splash_screen.dart';
import 'routes_names.dart';
import 'un_defined_route.dart';

class AppRouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.rSplashScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return const SplashScreen();
          },
        );
      case AppRoutesNames.rHomeScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return BlocProvider(
              create: (context) => getIt<HomeCubit>(),
              child: const HomeScreen(),
            );
          },
        );
      default:
        return unDefinedRoute();
    }
  }
}
