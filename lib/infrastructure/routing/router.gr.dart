// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:flutter/src/widgets/framework.dart' as _i18;
import 'package:service_go/infrastructure/routing/nested/bengkel_router.dart'
    as _i2;
import 'package:service_go/infrastructure/routing/nested/customer_router.dart'
    as _i1;
import 'package:service_go/infrastructure/types/query.dart' as _i20;
import 'package:service_go/modules/authentication/presentation/screens/login/login_screen.dart'
    as _i14;
import 'package:service_go/modules/authentication/presentation/screens/register/register_screen.dart'
    as _i13;
import 'package:service_go/modules/authentication/presentation/screens/splash/splash_screen.dart'
    as _i12;
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart'
    as _i19;
import 'package:service_go/modules/bengkel/presentation/screens/bengkel_list/bengkel_list_screen.dart'
    as _i5;
import 'package:service_go/modules/customer/domain/model/customer_profile.dart'
    as _i17;
import 'package:service_go/modules/home/presentation/screens/bengkel/bengkel_home_screen.dart'
    as _i3;
import 'package:service_go/modules/home/presentation/screens/customer/customer_home_screen.dart'
    as _i4;
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile_form/bengkel_profile_form_screen.dart'
    as _i7;
import 'package:service_go/modules/profile/presentation/screens/customer_profile_form/customer_profile_form_screen.dart'
    as _i6;
import 'package:service_go/modules/service/domain/model/servis.dart' as _i21;
import 'package:service_go/modules/service/presentation/screens/bengkel_detail/servis_bengkel_detail_screen.dart'
    as _i9;
import 'package:service_go/modules/service/presentation/screens/customer_detail/servis_customer_detail_screen.dart'
    as _i11;
import 'package:service_go/modules/service/presentation/screens/customer_form/customer_servis_form_screen.dart'
    as _i8;
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart'
    as _i10;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    CustomerRouter.name: (routeData) {
      final args = routeData.argsAs<CustomerRouterArgs>(
          orElse: () => const CustomerRouterArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.WrappedRoute(
            child: _i1.CustomerRouterScreen(
          key: args.key,
          profile: args.profile,
        )),
      );
    },
    BengkelRouter.name: (routeData) {
      final args = routeData.argsAs<BengkelRouterArgs>(
          orElse: () => const BengkelRouterArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.WrappedRoute(
            child: _i2.BengkelRouterScreen(
          key: args.key,
          bengkelProfile: args.bengkelProfile,
        )),
      );
    },
    BengkelHomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BengkelHomeScreen(),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CustomerHomeScreen(),
      );
    },
    BengkelListRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.BengkelListScreen(),
      );
    },
    CustomProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomProfileFormRouteArgs>(
          orElse: () => const CustomProfileFormRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CustomProfileFormScreen(
          key: args.key,
          onCustomerProfileCreated: args.onCustomerProfileCreated,
        ),
      );
    },
    BengkelProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<BengkelProfileFormRouteArgs>(
          orElse: () => const BengkelProfileFormRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.BengkelProfileFormScreen(
          key: args.key,
          onBengkelProfileCreated: args.onBengkelProfileCreated,
        ),
      );
    },
    CustomerServisFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerServisFormRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.CustomerServisFormScreen(
          key: args.key,
          mode: args.mode,
        ),
      );
    },
    ServisBengkelDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ServisBengkelDetailRouteArgs>(
          orElse: () => ServisBengkelDetailRouteArgs(
              servisId: pathParams.getString('id')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.ServisBengkelDetailScreen(
          key: args.key,
          servisId: args.servisId,
        ),
      );
    },
    ServisListRoute.name: (routeData) {
      final args = routeData.argsAs<ServisListRouteArgs>(
          orElse: () => const ServisListRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ServisListScreen(
          key: args.key,
          initialQuery: args.initialQuery,
          onServisClick: args.onServisClick,
          type: args.type,
        ),
      );
    },
    ServisCustomerDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ServisCustomerDetailRouteArgs>(
          orElse: () => ServisCustomerDetailRouteArgs(
              servisId: pathParams.getString('id')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ServisCustomerDetailScreen(
          key: args.key,
          servisId: args.servisId,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SplashScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RegisterScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.LoginScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CustomerRouterScreen]
class CustomerRouter extends _i15.PageRouteInfo<CustomerRouterArgs> {
  CustomerRouter({
    _i16.Key? key,
    _i17.CustomerProfile? profile,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CustomerRouter.name,
          args: CustomerRouterArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomerRouter';

  static const _i15.PageInfo<CustomerRouterArgs> page =
      _i15.PageInfo<CustomerRouterArgs>(name);
}

class CustomerRouterArgs {
  const CustomerRouterArgs({
    this.key,
    this.profile,
  });

  final _i16.Key? key;

  final _i17.CustomerProfile? profile;

  @override
  String toString() {
    return 'CustomerRouterArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i2.BengkelRouterScreen]
class BengkelRouter extends _i15.PageRouteInfo<BengkelRouterArgs> {
  BengkelRouter({
    _i18.Key? key,
    _i19.BengkelProfile? bengkelProfile,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          BengkelRouter.name,
          args: BengkelRouterArgs(
            key: key,
            bengkelProfile: bengkelProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'BengkelRouter';

  static const _i15.PageInfo<BengkelRouterArgs> page =
      _i15.PageInfo<BengkelRouterArgs>(name);
}

class BengkelRouterArgs {
  const BengkelRouterArgs({
    this.key,
    this.bengkelProfile,
  });

  final _i18.Key? key;

  final _i19.BengkelProfile? bengkelProfile;

  @override
  String toString() {
    return 'BengkelRouterArgs{key: $key, bengkelProfile: $bengkelProfile}';
  }
}

/// generated route for
/// [_i3.BengkelHomeScreen]
class BengkelHomeRoute extends _i15.PageRouteInfo<void> {
  const BengkelHomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          BengkelHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'BengkelHomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CustomerHomeScreen]
class CustomerHomeRoute extends _i15.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.BengkelListScreen]
class BengkelListRoute extends _i15.PageRouteInfo<void> {
  const BengkelListRoute({List<_i15.PageRouteInfo>? children})
      : super(
          BengkelListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BengkelListRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CustomProfileFormScreen]
class CustomProfileFormRoute
    extends _i15.PageRouteInfo<CustomProfileFormRouteArgs> {
  CustomProfileFormRoute({
    _i16.Key? key,
    void Function(_i17.CustomerProfile)? onCustomerProfileCreated,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CustomProfileFormRoute.name,
          args: CustomProfileFormRouteArgs(
            key: key,
            onCustomerProfileCreated: onCustomerProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomProfileFormRoute';

  static const _i15.PageInfo<CustomProfileFormRouteArgs> page =
      _i15.PageInfo<CustomProfileFormRouteArgs>(name);
}

class CustomProfileFormRouteArgs {
  const CustomProfileFormRouteArgs({
    this.key,
    this.onCustomerProfileCreated,
  });

  final _i16.Key? key;

  final void Function(_i17.CustomerProfile)? onCustomerProfileCreated;

  @override
  String toString() {
    return 'CustomProfileFormRouteArgs{key: $key, onCustomerProfileCreated: $onCustomerProfileCreated}';
  }
}

/// generated route for
/// [_i7.BengkelProfileFormScreen]
class BengkelProfileFormRoute
    extends _i15.PageRouteInfo<BengkelProfileFormRouteArgs> {
  BengkelProfileFormRoute({
    _i16.Key? key,
    void Function(_i19.BengkelProfile)? onBengkelProfileCreated,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          BengkelProfileFormRoute.name,
          args: BengkelProfileFormRouteArgs(
            key: key,
            onBengkelProfileCreated: onBengkelProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'BengkelProfileFormRoute';

  static const _i15.PageInfo<BengkelProfileFormRouteArgs> page =
      _i15.PageInfo<BengkelProfileFormRouteArgs>(name);
}

class BengkelProfileFormRouteArgs {
  const BengkelProfileFormRouteArgs({
    this.key,
    this.onBengkelProfileCreated,
  });

  final _i16.Key? key;

  final void Function(_i19.BengkelProfile)? onBengkelProfileCreated;

  @override
  String toString() {
    return 'BengkelProfileFormRouteArgs{key: $key, onBengkelProfileCreated: $onBengkelProfileCreated}';
  }
}

/// generated route for
/// [_i8.CustomerServisFormScreen]
class CustomerServisFormRoute
    extends _i15.PageRouteInfo<CustomerServisFormRouteArgs> {
  CustomerServisFormRoute({
    _i16.Key? key,
    required _i8.CustomerServisFormScreenMode mode,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CustomerServisFormRoute.name,
          args: CustomerServisFormRouteArgs(
            key: key,
            mode: mode,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomerServisFormRoute';

  static const _i15.PageInfo<CustomerServisFormRouteArgs> page =
      _i15.PageInfo<CustomerServisFormRouteArgs>(name);
}

class CustomerServisFormRouteArgs {
  const CustomerServisFormRouteArgs({
    this.key,
    required this.mode,
  });

  final _i16.Key? key;

  final _i8.CustomerServisFormScreenMode mode;

  @override
  String toString() {
    return 'CustomerServisFormRouteArgs{key: $key, mode: $mode}';
  }
}

/// generated route for
/// [_i9.ServisBengkelDetailScreen]
class ServisBengkelDetailRoute
    extends _i15.PageRouteInfo<ServisBengkelDetailRouteArgs> {
  ServisBengkelDetailRoute({
    _i16.Key? key,
    required String servisId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ServisBengkelDetailRoute.name,
          args: ServisBengkelDetailRouteArgs(
            key: key,
            servisId: servisId,
          ),
          rawPathParams: {'id': servisId},
          initialChildren: children,
        );

  static const String name = 'ServisBengkelDetailRoute';

  static const _i15.PageInfo<ServisBengkelDetailRouteArgs> page =
      _i15.PageInfo<ServisBengkelDetailRouteArgs>(name);
}

class ServisBengkelDetailRouteArgs {
  const ServisBengkelDetailRouteArgs({
    this.key,
    required this.servisId,
  });

  final _i16.Key? key;

  final String servisId;

  @override
  String toString() {
    return 'ServisBengkelDetailRouteArgs{key: $key, servisId: $servisId}';
  }
}

/// generated route for
/// [_i10.ServisListScreen]
class ServisListRoute extends _i15.PageRouteInfo<ServisListRouteArgs> {
  ServisListRoute({
    _i16.Key? key,
    _i20.SGDataQuery? initialQuery,
    void Function(_i21.Servis)? onServisClick,
    _i10.ServisListType? type,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ServisListRoute.name,
          args: ServisListRouteArgs(
            key: key,
            initialQuery: initialQuery,
            onServisClick: onServisClick,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'ServisListRoute';

  static const _i15.PageInfo<ServisListRouteArgs> page =
      _i15.PageInfo<ServisListRouteArgs>(name);
}

class ServisListRouteArgs {
  const ServisListRouteArgs({
    this.key,
    this.initialQuery,
    this.onServisClick,
    this.type,
  });

  final _i16.Key? key;

  final _i20.SGDataQuery? initialQuery;

  final void Function(_i21.Servis)? onServisClick;

  final _i10.ServisListType? type;

  @override
  String toString() {
    return 'ServisListRouteArgs{key: $key, initialQuery: $initialQuery, onServisClick: $onServisClick, type: $type}';
  }
}

/// generated route for
/// [_i11.ServisCustomerDetailScreen]
class ServisCustomerDetailRoute
    extends _i15.PageRouteInfo<ServisCustomerDetailRouteArgs> {
  ServisCustomerDetailRoute({
    _i16.Key? key,
    required String servisId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ServisCustomerDetailRoute.name,
          args: ServisCustomerDetailRouteArgs(
            key: key,
            servisId: servisId,
          ),
          rawPathParams: {'id': servisId},
          initialChildren: children,
        );

  static const String name = 'ServisCustomerDetailRoute';

  static const _i15.PageInfo<ServisCustomerDetailRouteArgs> page =
      _i15.PageInfo<ServisCustomerDetailRouteArgs>(name);
}

class ServisCustomerDetailRouteArgs {
  const ServisCustomerDetailRouteArgs({
    this.key,
    required this.servisId,
  });

  final _i16.Key? key;

  final String servisId;

  @override
  String toString() {
    return 'ServisCustomerDetailRouteArgs{key: $key, servisId: $servisId}';
  }
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RegisterScreen]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
