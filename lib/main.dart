import 'package:flutter/material.dart';
import 'package:service_go/app.dart';
import 'package:service_go/infrastructure/architecutre/error_handler/global_error_handler.dart';
import 'package:service_go/infrastructure/env/env.dart';
import 'package:service_go/infrastructure/routing/router.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/firebase_messanger_util.dart';
import 'package:service_go/infrastructure/utils/notification/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await NotificationService.requestPermissionsNotification();
  await initializeDateFormatting('id_ID');
  await FirebaseHelper.setupFirebase();
  await configureDependencies();
  SGGlobalErrorHandler.setUpErrorHandler();
  ENV.setEnv(ENV.dev);

  runApp(ServiceGoApp(
    appRouter: getIt<AppRouter>(),
  ));
}
