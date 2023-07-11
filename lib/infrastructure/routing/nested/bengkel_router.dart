import 'package:auto_route/auto_route.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/profile/domain/usecase/check_is_bengkel_has_profile.dart';

@RoutePage(name: 'BengkelRouter')
class BengkelRouterScreen extends AutoRouter {
  static List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: 'home'),
      ];

  const BengkelRouterScreen({super.key});
}

class BengkelProfileGuard extends AutoRouteGuard {
  final CheckIfBengkelHasProfile _checkIfBengkelHasProfile;

  BengkelProfileGuard(this._checkIfBengkelHasProfile);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final usecase = await _checkIfBengkelHasProfile();
    switch (usecase) {
      case Success():
        final data = usecase.data;
        if (data.isSessionExpired) {
          router.replaceAll([const LoginRoute()]);
        }
        if (data.hasProfile) {
          resolver.next();
        } else {
          resolver
              .redirect(BengkelProfileFormRoute(onBengkelProfileCreated: () {
            resolver.next();
          }));
        }
      case Error():
        router.replaceAll([const LoginRoute()]);
    }
  }
}
