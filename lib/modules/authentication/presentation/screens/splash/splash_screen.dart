import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/architecutre/cubits/session/session_cubit.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/icons/service_geo.dart';
import 'package:service_go/modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashCubit>()..getLastSession(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccess) {
              context.read<SessionCubit>().setCurrenetUser(state.userSession);
              final session = state.userSession;
              final router = context.router;
              PageRouteInfo? info;
              if (session != null) {
                if (session.userData.isAdmin) {
                  router.replaceAll([const AdminRouter()]);
                  return;
                }
                List<PageRouteInfo>? children;
                final routeNavNotif = state.navNotif;
                if (routeNavNotif != null &&
                    routeNavNotif.path.isBengkel == session.isBengkel) {
                  children = routeNavNotif.getRouter()?.let((value) => [value]);
                }
                info = session.isBengkel
                    ? BengkelRouter(children: children) as PageRouteInfo
                    : CustomerRouter(children: children);
              }
              router.replace(info ?? const LoginRoute());
            }
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: double.infinity,
            child: SGIcon(
              size: 55.w,
            ),
          ),
        ),
      ),
    );
  }
}
