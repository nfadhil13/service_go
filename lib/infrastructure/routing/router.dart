import 'package:auto_route/auto_route.dart';
import 'package:service_go/infrastructure/routing/nested/bengkel_router.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
        AutoRoute(
            page: BengkelProfileFormRoute.page, path: '/bengkel-register'),
        AutoRoute(
          page: BengkelRouter.page,
          path: '/bengekel',
          guards: [BengkelProfileGuard(getIt())],
          children: BengkelRouterScreen.routes,
        )
      ];
}
