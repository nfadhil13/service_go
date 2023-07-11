import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/architecutre/cubits/session/session_cubit.dart';
import 'package:service_go/infrastructure/architecutre/error_handler/global_errror_catcher.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/routing/router.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/styles/color.dart';
import 'package:service_go/infrastructure/styles/text_theme.dart';
import 'package:sizer/sizer.dart';

class ServiceGoApp extends StatelessWidget {
  final AppRouter appRouter;
  const ServiceGoApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MessengerCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SessionCubit>(),
        ),
      ],
      child: Sizer(builder: (context, _, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          builder: (context, child) {
            return GlobalErrorCatcher(
              child: ServiceGoMessengerListener(
                child: child,
              ),
              onSessionExpire: () {
                context.messenger.showErrorSnackbar("Session Expired");
                context.logout();
              },
            );
          },
          routeInformationParser: appRouter.defaultRouteParser(),
          theme: ThemeData(
            textTheme: SGTextTheme.textTheme,
            colorScheme: SGColorTheme.lightColorScheme,
          ),
        );
      }),
    );
  }
}

class ServiceGoMessengerListener extends StatelessWidget {
  final Widget? child;
  const ServiceGoMessengerListener({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessengerCubit, MessengerState>(
      listener: (context, state) {
        if (state is MessengerIdle) return;
        if (state is MessengerSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: state.backgroundColor(context),
          ));
        }
        context.read<MessengerCubit>().idle();
      },
      child: child,
    );
  }
}
