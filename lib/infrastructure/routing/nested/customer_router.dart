import 'package:auto_route/auto_route.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/profile/domain/usecase/bengkel/check_is_bengkel_has_profile.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart';

@RoutePage(name: 'CustomerRouter')
class CustomerRouterScreen extends AutoRouter {
  static List<AutoRoute> get routes => [
        AutoRoute(page: CustomerHomeRoute.page, path: 'home'),
      ];

  const CustomerRouterScreen({super.key});
}

class CustomerProfileGuard extends AutoRouteGuard {
  final CheckIfCustomerHasProfile _checkIfBengkelHasProfile;

  CustomerProfileGuard(this._checkIfBengkelHasProfile);

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
              .redirect(CustomProfileFormRoute(onCustomerProfileCreated: () {
            resolver.next();
          }));
        }
      case Error():
        router.replaceAll([const LoginRoute()]);
    }
  }
}
