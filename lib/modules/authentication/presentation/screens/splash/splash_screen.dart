import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/gen/assets.gen.dart';
import 'package:service_go/infrastructure/architecutre/cubits/session/session_cubit.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart';

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
              final route = state.userSession != null
                  ? const HomeRoute()
                  : const LoginRoute();
              context.router.replace(route);
            }
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Assets.images.landingpage.provider(),
                    fit: BoxFit.cover)),
            child: const _ServiceGoIcon(),
          ),
        ),
      ),
    );
  }
}

class _ServiceGoIcon extends StatelessWidget {
  const _ServiceGoIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: context.color.primary,
    );
  }
}
