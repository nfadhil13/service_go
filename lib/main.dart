import 'package:flutter/material.dart';
import 'package:service_go/app.dart';
import 'package:service_go/infrastructure/architecutre/error_handler/global_error_handler.dart';
import 'package:service_go/infrastructure/env/env.dart';
import 'package:service_go/infrastructure/routing/router.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServiceGoGlobalErrorHandler.setUpErrorHandler();
  ENV.setEnv(ENV.dev);
  runApp(ServiceGoApp(
    appRouter: AppRouter(),
  ));
}
