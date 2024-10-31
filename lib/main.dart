import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/adapters.dart';

import 'config/bloc/bloc_observer.dart';
import 'config/resources/localization_logic/localization_model.dart';
import 'core/services/services_locator.dart';
import 'my_app/app_requirement_setup.dart';
import 'my_app/my_app.dart';

//! for SSL/TLS connections (Secure Sockets Layer/Transport Layer Security)
// late ByteData clientCertificate;
// late ByteData privateKey;
// late ByteData rootCACertificate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  AppRequirementSetup.registerHiveAdapter();
  //! for SSL/TLS connections (Secure Sockets Layer/Transport Layer Security)
  // HttpOverrides.global = MyHttpOverrides();
  // clientCertificate = await rootBundle.load("assets/certificates/cert.pem");
  // privateKey = await rootBundle.load("assets/certificates/Key.pem");
  // rootCACertificate = await rootBundle.load("assets/certificates/ca.pem");

  configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocale, arabicLocale],
      path: assetPathLocalization,
      // phoenix for restart app when we change the language
      //! for Localization
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
  Bloc.observer = MyBlocObserver();
}

// line for generating
// flutter pub run build_runner watch --delete-conflicting-outputs
