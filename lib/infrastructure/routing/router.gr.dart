// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:service_go/infrastructure/routing/nested/bengkel_router.dart'
    as _i1;
import 'package:service_go/modules/authentication/presentation/screens/login/login_screen.dart'
    as _i6;
import 'package:service_go/modules/authentication/presentation/screens/register/register_screen.dart'
    as _i5;
import 'package:service_go/modules/authentication/presentation/screens/splash/splash_screen.dart'
    as _i4;
import 'package:service_go/modules/home/presentation/screens/home/home_screen.dart'
    as _i2;
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile_form/bengkel_profile_form_screen.dart'
    as _i3;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    BengkelRouter.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BengkelRouterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    BengkelProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<BengkelProfileFormRouteArgs>(
          orElse: () => const BengkelProfileFormRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BengkelProfileFormScreen(
          key: args.key,
          onBengkelProfileCreated: args.onBengkelProfileCreated,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RegisterScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BengkelRouterScreen]
class BengkelRouter extends _i7.PageRouteInfo<void> {
  const BengkelRouter({List<_i7.PageRouteInfo>? children})
      : super(
          BengkelRouter.name,
          initialChildren: children,
        );

  static const String name = 'BengkelRouter';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BengkelProfileFormScreen]
class BengkelProfileFormRoute
    extends _i7.PageRouteInfo<BengkelProfileFormRouteArgs> {
  BengkelProfileFormRoute({
    _i8.Key? key,
    void Function()? onBengkelProfileCreated,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          BengkelProfileFormRoute.name,
          args: BengkelProfileFormRouteArgs(
            key: key,
            onBengkelProfileCreated: onBengkelProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'BengkelProfileFormRoute';

  static const _i7.PageInfo<BengkelProfileFormRouteArgs> page =
      _i7.PageInfo<BengkelProfileFormRouteArgs>(name);
}

class BengkelProfileFormRouteArgs {
  const BengkelProfileFormRouteArgs({
    this.key,
    this.onBengkelProfileCreated,
  });

  final _i8.Key? key;

  final void Function()? onBengkelProfileCreated;

  @override
  String toString() {
    return 'BengkelProfileFormRouteArgs{key: $key, onBengkelProfileCreated: $onBengkelProfileCreated}';
  }
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RegisterScreen]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
