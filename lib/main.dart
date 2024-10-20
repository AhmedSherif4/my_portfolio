import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'config/bloc/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'my_app/app_requirement_setup.dart';
import 'my_app/my_app.dart';

// late ByteData clientCertificate;
// late ByteData privateKey;
// late ByteData rootCACertificate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  AppRequirementSetup.registerHiveAdapter();
  // await Firebase.initializeApp();
  // HttpOverrides.global = MyHttpOverrides();
  // clientCertificate = await rootBundle.load("assets/certificates/cert.pem");
  // privateKey = await rootBundle.load("assets/certificates/Key.pem");
  // rootCACertificate = await rootBundle.load("assets/certificates/ca.pem");

  configureDependencies();

  // Dio().post(
  //   'https://tr.snapchat.com/v3/4e9ddf5b-5947-4f7d-96a5-292cc312dee0/events?access_token=eyJhbGciOiJIUzI1NiIsImtpZCI6IkNhbnZhc1MyU0hNQUNQcm9kIiwidHlwIjoiSldUIn0.eyJhdWQiOiJjYW52YXMtY2FudmFzYXBpIiwiaXNzIjoiY2FudmFzLXMyc3Rva2VuIiwibmJmIjoxNzE3MzkyOTQwLCJzdWIiOiJkNDdlZTgzMS1hMTRmLTQxZjItOWY5NS0zYWY1NmM1YWRkOWV-UFJPRFVDVElPTn4xYmMzZDk2Yy03MTc3LTRlMDAtOTNlYy04ZmQ2MmMzMDA4NWQifQ.eYJmHirBvNTdm4BsFwl1Vq1RevW8b69oGL0V1wE9wCk',
  // );

  runApp(MyApp());
  Bloc.observer = MyBlocObserver();
}

// line for generating
// flutter pub run build_runner watch --delete-conflicting-outputs
