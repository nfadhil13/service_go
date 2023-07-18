import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/presentation/cubits/cubit/customer_profile_cubit.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart';

@RoutePage(name: 'CustomerRouter')
class CustomerRouterScreen extends AutoRouter implements AutoRouteWrapper {
  static List<AutoRoute> get routes => [
        AutoRoute(page: CustomerHomeRoute.page, path: 'home', initial: true),
      ];

  final CustomerProfile? profile;

  const CustomerRouterScreen({super.key, this.profile});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (_) => CustomerProfileCubit(profile!), child: this);
  }
}

class CustomerProfileGuard extends AutoRouteGuard {
  final CheckIfCustomerHasProfile _checkIfBengkelHasProfile;

  CustomerProfileGuard(this._checkIfBengkelHasProfile);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    print("Navigaitng to");
    print(
        "args : ${router.routeData.argsAs<CustomerRouterArgs>(orElse: () => const CustomerRouterArgs())}");

    final usecase = await _checkIfBengkelHasProfile();
    switch (usecase) {
      case Success():
        final data = usecase.data;
        if (data.isSessionExpired) {
          router.replaceAll([const LoginRoute()]);
        }
        final profile = data.profile;
        if (profile != null) {
          print("Profile sudah ada $profile");

          router.replaceAll([CustomerRouter(profile: profile)]);
          resolver.resolveNext(false);
        } else {
          resolver.redirect(
              CustomProfileFormRoute(onCustomerProfileCreated: (profile) {
            resolver.next();
          }));
        }
      case Error():
        router.replaceAll([const LoginRoute()]);
    }
  }
}
