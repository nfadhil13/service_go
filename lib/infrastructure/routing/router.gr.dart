// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:service_go/infrastructure/routing/nested/bengkel_router.dart'
    as _i1;
import 'package:service_go/infrastructure/routing/nested/customer_router.dart'
    as _i8;
import 'package:service_go/modules/authentication/presentation/screens/login/login_screen.dart'
    as _i6;
import 'package:service_go/modules/authentication/presentation/screens/register/register_screen.dart'
    as _i5;
import 'package:service_go/modules/authentication/presentation/screens/splash/splash_screen.dart'
    as _i4;
import 'package:service_go/modules/home/presentation/screens/customer/customer_home_screen.dart'
    as _i9;
import 'package:service_go/modules/home/presentation/screens/home/home_screen.dart'
    as _i2;
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile_form/bengkel_profile_form_screen.dart'
    as _i3;
import 'package:service_go/modules/profile/presentation/screens/customer_profile_form/customer_profile_form_screen.dart'
    as _i7;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    BengkelRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BengkelRouterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    BengkelProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<BengkelProfileFormRouteArgs>(
          orElse: () => const BengkelProfileFormRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BengkelProfileFormScreen(
          key: args.key,
          onBengkelProfileCreated: args.onBengkelProfileCreated,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RegisterScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginScreen(),
      );
    },
    CustomProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomProfileFormRouteArgs>(
          orElse: () => const CustomProfileFormRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.CustomProfileFormScreen(
          key: args.key,
          onCustomerProfileCreated: args.onCustomerProfileCreated,
        ),
      );
    },
    CustomerRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.CustomerRouterScreen(),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CustomerHomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BengkelRouterScreen]
class BengkelRouter extends _i10.PageRouteInfo<void> {
  const BengkelRouter({List<_i10.PageRouteInfo>? children})
      : super(
          BengkelRouter.name,
          initialChildren: children,
        );

  static const String name = 'BengkelRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BengkelProfileFormScreen]
class BengkelProfileFormRoute
    extends _i10.PageRouteInfo<BengkelProfileFormRouteArgs> {
  BengkelProfileFormRoute({
    _i11.Key? key,
    void Function()? onBengkelProfileCreated,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          BengkelProfileFormRoute.name,
          args: BengkelProfileFormRouteArgs(
            key: key,
            onBengkelProfileCreated: onBengkelProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'BengkelProfileFormRoute';

  static const _i10.PageInfo<BengkelProfileFormRouteArgs> page =
      _i10.PageInfo<BengkelProfileFormRouteArgs>(name);
}

class BengkelProfileFormRouteArgs {
  const BengkelProfileFormRouteArgs({
    this.key,
    this.onBengkelProfileCreated,
  });

  final _i11.Key? key;

  final void Function()? onBengkelProfileCreated;

  @override
  String toString() {
    return 'BengkelProfileFormRouteArgs{key: $key, onBengkelProfileCreated: $onBengkelProfileCreated}';
  }
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RegisterScreen]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CustomProfileFormScreen]
class CustomProfileFormRoute
    extends _i10.PageRouteInfo<CustomProfileFormRouteArgs> {
  CustomProfileFormRoute({
    _i11.Key? key,
    void Function()? onCustomerProfileCreated,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CustomProfileFormRoute.name,
          args: CustomProfileFormRouteArgs(
            key: key,
            onCustomerProfileCreated: onCustomerProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomProfileFormRoute';

  static const _i10.PageInfo<CustomProfileFormRouteArgs> page =
      _i10.PageInfo<CustomProfileFormRouteArgs>(name);
}

class CustomProfileFormRouteArgs {
  const CustomProfileFormRouteArgs({
    this.key,
    this.onCustomerProfileCreated,
  });

  final _i11.Key? key;

  final void Function()? onCustomerProfileCreated;

  @override
  String toString() {
    return 'CustomProfileFormRouteArgs{key: $key, onCustomerProfileCreated: $onCustomerProfileCreated}';
  }
}

/// generated route for
/// [_i8.CustomerRouterScreen]
class CustomerRouter extends _i10.PageRouteInfo<void> {
  const CustomerRouter({List<_i10.PageRouteInfo>? children})
      : super(
          CustomerRouter.name,
          initialChildren: children,
        );

  static const String name = 'CustomerRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CustomerHomeScreen]
class CustomerHomeRoute extends _i10.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
