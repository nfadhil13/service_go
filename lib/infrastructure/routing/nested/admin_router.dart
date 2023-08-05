import 'package:auto_route/auto_route.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';

@RoutePage(name: 'AdminRouter')
class AdminRouterList extends AutoRouter {
  static List<AutoRoute> get routes => [
        AutoRoute(page: AdmminHomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: ServisListRoute.page, path: 'pesanan'),
        AutoRoute(page: AdminBengkelListRoute.page, path: 'bengkel'),
        AutoRoute(page: BengkelProfileRoute.page, path: 'bengkel/:id'),
        AutoRoute(page: ServisCustomerDetailRoute.page, path: 'pesanan/:id')
      ];

  const AdminRouterList({super.key});
}
