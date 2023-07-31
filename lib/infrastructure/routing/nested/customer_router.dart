import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/architecutre/cubits/location/location_cubit.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/infrastructure/widgets/map/map_picker.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/presentation/cubits/cubit/customer_profile_cubit.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart';

@RoutePage(name: 'CustomerRouter')
class CustomerRouterScreen extends AutoRouter implements AutoRouteWrapper {
  static List<AutoRoute> get routes => [
        AutoRoute(page: CustomerHomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: BengkelListRoute.page, path: 'bengkel'),
        AutoRoute(page: CustomerServisFormRoute.page, path: 'pesan'),
        AutoRoute(page: ServisListRoute.page, path: 'pesanan-customer'),
        AutoRoute(
            page: ServisCustomerDetailRoute.page, path: 'pesanan-customer/:id')
      ];

  final CustomerProfile? profile;

  const CustomerRouterScreen({super.key, this.profile});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CustomerProfileCubit(profile!)),
        BlocProvider(
          create: (context) => getIt<InitialLocationCubit>()..getLocation(),
        ),
      ],
      child: SGLocationPermissionGuard(
        builder: (context) {
          return BlocBuilder<InitialLocationCubit, LocationState>(
            builder: (context, state) {
              return switch (state) {
                LocationLoading() => const Scaffold(
                    body: SGLoadingOverlay(),
                  ),
                LocationSuccess() =>
                  LocationProvider(location: state.location, child: this)
              };
            },
          );
        },
      ),
    );
  }
}

class CustomerProfileGuard extends AutoRouteGuard {
  final CheckIfCustomerHasProfile _checkIfBengkelHasProfile;

  CustomerProfileGuard(this._checkIfBengkelHasProfile);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final args = resolver.route.args;
    if (args is CustomerRouterArgs && args.profile != null) {
      resolver.next();
      return;
    }
    final usecase = await _checkIfBengkelHasProfile();
    switch (usecase) {
      case Success():
        final data = usecase.data;
        if (data.isSessionExpired) {
          router.replaceAll([const LoginRoute()]);
        }
        final profile = data.profile;
        if (profile != null) {
          router.replaceAll([CustomerRouter(profile: profile)]);
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
