import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/routing/router.dart';

import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: 'init', preferRelativeImports: true, asExtension: true)
Future<void> configureDependencies() async {
  getIt.registerLazySingleton(() => AppRouter());
  getIt.init();
}
