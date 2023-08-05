import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/presentation/cubits/bengkel_profile/bengkel_profile_cubit.dart';
import 'package:service_go/modules/profile/domain/usecase/bengkel/check_is_bengkel_has_profile.dart';

@RoutePage(name: 'BengkelRouter')
class BengkelRouterScreen extends AutoRouter implements AutoRouteWrapper {
  static List<AutoRoute> get routes => [
        AutoRoute(page: JadwalBengkelFormRoute.page, path: 'jadwal'),
        AutoRoute(page: BengkelHomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: ServisBengkelDetailRoute.page, path: 'pesanan/:id')
      ];

  final BengkelProfile? bengkelProfile;

  const BengkelRouterScreen({super.key, this.bengkelProfile});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (_) => BengkelProfileCubit(bengkelProfile!), child: this);
  }
}

class BengkelProfileGuard extends AutoRouteGuard {
  final CheckIfBengkelHasProfile _checkIfBengkelHasProfile;

  BengkelProfileGuard(this._checkIfBengkelHasProfile);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final args = resolver.route.args;
    if (args is BengkelRouterArgs && args.bengkelProfile != null) {
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
          router.replaceAll([BengkelRouter(bengkelProfile: profile)]);
        } else {
          resolver.redirect(
              BengkelProfileFormRoute(onBengkelProfileCreated: (profile) {
            router.replaceAll([BengkelRouter(bengkelProfile: profile)]);
          }));
        }
      case Error():
        router.replaceAll([const LoginRoute()]);
    }
  }
}
