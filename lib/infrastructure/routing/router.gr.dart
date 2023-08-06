// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/material.dart' as _i24;
import 'package:flutter/src/widgets/framework.dart' as _i26;
import 'package:service_go/infrastructure/routing/nested/admin_router.dart'
    as _i19;
import 'package:service_go/infrastructure/routing/nested/bengkel_router.dart'
    as _i2;
import 'package:service_go/infrastructure/routing/nested/customer_router.dart'
    as _i1;
import 'package:service_go/infrastructure/types/query.dart' as _i28;
import 'package:service_go/modules/authentication/presentation/screens/login/login_screen.dart'
    as _i18;
import 'package:service_go/modules/authentication/presentation/screens/register/register_screen.dart'
    as _i17;
import 'package:service_go/modules/authentication/presentation/screens/splash/splash_screen.dart'
    as _i16;
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart'
    as _i27;
import 'package:service_go/modules/bengkel/presentation/screens/admin_bengkel_list/admin_bengkel_list_screen.dart'
    as _i20;
import 'package:service_go/modules/bengkel/presentation/screens/admin_jenis_layanan/admin_jenis_layanan_list_screen.dart'
    as _i22;
import 'package:service_go/modules/bengkel/presentation/screens/bengkel_list/bengkel_list_screen.dart'
    as _i6;
import 'package:service_go/modules/bengkel/presentation/screens/jadwal_bengkel/jadwal_bengkel_screen.dart'
    as _i7;
import 'package:service_go/modules/customer/domain/model/customer_profile.dart'
    as _i25;
import 'package:service_go/modules/customer/presentation/screens/admin_customer_list_screen.dart'
    as _i21;
import 'package:service_go/modules/home/presentation/screens/admin/admin_home_screen.dart'
    as _i4;
import 'package:service_go/modules/home/presentation/screens/bengkel/bengkel_home_screen.dart'
    as _i3;
import 'package:service_go/modules/home/presentation/screens/customer/customer_home_screen.dart'
    as _i5;
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile/bengkel_profile_screen.dart'
    as _i8;
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile_form/bengkel_profile_form_screen.dart'
    as _i11;
import 'package:service_go/modules/profile/presentation/screens/customer_profile/customer_profile_screen.dart'
    as _i9;
import 'package:service_go/modules/profile/presentation/screens/customer_profile_form/customer_profile_form_screen.dart'
    as _i10;
import 'package:service_go/modules/service/domain/model/servis.dart' as _i29;
import 'package:service_go/modules/service/presentation/screens/bengkel_detail/servis_bengkel_detail_screen.dart'
    as _i13;
import 'package:service_go/modules/service/presentation/screens/customer_detail/servis_customer_detail_screen.dart'
    as _i15;
import 'package:service_go/modules/service/presentation/screens/customer_form/customer_servis_form_screen.dart'
    as _i12;
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart'
    as _i14;

abstract class $AppRouter extends _i23.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    CustomerRouter.name: (routeData) {
      final args = routeData.argsAs<CustomerRouterArgs>(
          orElse: () => const CustomerRouterArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.WrappedRoute(
            child: _i1.CustomerRouterScreen(
          key: args.key,
          profile: args.profile,
        )),
      );
    },
    BengkelRouter.name: (routeData) {
      final args = routeData.argsAs<BengkelRouterArgs>(
          orElse: () => const BengkelRouterArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.WrappedRoute(
            child: _i2.BengkelRouterScreen(
          key: args.key,
          bengkelProfile: args.bengkelProfile,
        )),
      );
    },
    BengkelHomeRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BengkelHomeScreen(),
      );
    },
    AdmminHomeRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AdmminHomeScreen(),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CustomerHomeScreen(),
      );
    },
    BengkelListRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.BengkelListScreen(),
      );
    },
    JadwalBengkelFormRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.JadwalBengkelFormScreen(),
      );
    },
    BengkelProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BengkelProfileRouteArgs>(
          orElse: () =>
              BengkelProfileRouteArgs(userId: pathParams.getString('id')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.BengkelProfileScreen(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    CustomerProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CustomerProfileRouteArgs>(
          orElse: () =>
              CustomerProfileRouteArgs(userId: pathParams.getString('id')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.CustomerProfileScreen(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    CustomProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomProfileFormRouteArgs>(
          orElse: () => const CustomProfileFormRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.CustomProfileFormScreen(
          key: args.key,
          onCustomerProfileCreated: args.onCustomerProfileCreated,
        ),
      );
    },
    BengkelProfileFormRoute.name: (routeData) {
      final args = routeData.argsAs<BengkelProfileFormRouteArgs>(
          orElse: () => const BengkelProfileFormRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.BengkelProfileFormScreen(
          key: args.key,
          onBengkelProfileCreated: args.onBengkelProfileCreated,
        ),
      );
    },
    CustomerServisFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerServisFormRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.CustomerServisFormScreen(
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
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ServisBengkelDetailScreen(
          key: args.key,
          servisId: args.servisId,
        ),
      );
    },
    ServisListRoute.name: (routeData) {
      final args = routeData.argsAs<ServisListRouteArgs>(
          orElse: () => const ServisListRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.ServisListScreen(
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
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.ServisCustomerDetailScreen(
          key: args.key,
          servisId: args.servisId,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.SplashScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.RegisterScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.LoginScreen(),
      );
    },
    AdminRouter.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.AdminRouterList(),
      );
    },
    AdminBengkelListRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.AdminBengkelListScreen(),
      );
    },
    AdminCustomerListRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.AdminCustomerListScreen(),
      );
    },
    AdminJenisLayananListRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.AdminJenisLayananListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CustomerRouterScreen]
class CustomerRouter extends _i23.PageRouteInfo<CustomerRouterArgs> {
  CustomerRouter({
    _i24.Key? key,
    _i25.CustomerProfile? profile,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          CustomerRouter.name,
          args: CustomerRouterArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomerRouter';

  static const _i23.PageInfo<CustomerRouterArgs> page =
      _i23.PageInfo<CustomerRouterArgs>(name);
}

class CustomerRouterArgs {
  const CustomerRouterArgs({
    this.key,
    this.profile,
  });

  final _i24.Key? key;

  final _i25.CustomerProfile? profile;

  @override
  String toString() {
    return 'CustomerRouterArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i2.BengkelRouterScreen]
class BengkelRouter extends _i23.PageRouteInfo<BengkelRouterArgs> {
  BengkelRouter({
    _i26.Key? key,
    _i27.BengkelProfile? bengkelProfile,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          BengkelRouter.name,
          args: BengkelRouterArgs(
            key: key,
            bengkelProfile: bengkelProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'BengkelRouter';

  static const _i23.PageInfo<BengkelRouterArgs> page =
      _i23.PageInfo<BengkelRouterArgs>(name);
}

class BengkelRouterArgs {
  const BengkelRouterArgs({
    this.key,
    this.bengkelProfile,
  });

  final _i26.Key? key;

  final _i27.BengkelProfile? bengkelProfile;

  @override
  String toString() {
    return 'BengkelRouterArgs{key: $key, bengkelProfile: $bengkelProfile}';
  }
}

/// generated route for
/// [_i3.BengkelHomeScreen]
class BengkelHomeRoute extends _i23.PageRouteInfo<void> {
  const BengkelHomeRoute({List<_i23.PageRouteInfo>? children})
      : super(
          BengkelHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'BengkelHomeRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AdmminHomeScreen]
class AdmminHomeRoute extends _i23.PageRouteInfo<void> {
  const AdmminHomeRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AdmminHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdmminHomeRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CustomerHomeScreen]
class CustomerHomeRoute extends _i23.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i23.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i6.BengkelListScreen]
class BengkelListRoute extends _i23.PageRouteInfo<void> {
  const BengkelListRoute({List<_i23.PageRouteInfo>? children})
      : super(
          BengkelListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BengkelListRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i7.JadwalBengkelFormScreen]
class JadwalBengkelFormRoute extends _i23.PageRouteInfo<void> {
  const JadwalBengkelFormRoute({List<_i23.PageRouteInfo>? children})
      : super(
          JadwalBengkelFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'JadwalBengkelFormRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i8.BengkelProfileScreen]
class BengkelProfileRoute extends _i23.PageRouteInfo<BengkelProfileRouteArgs> {
  BengkelProfileRoute({
    _i24.Key? key,
    required String userId,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          BengkelProfileRoute.name,
          args: BengkelProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'BengkelProfileRoute';

  static const _i23.PageInfo<BengkelProfileRouteArgs> page =
      _i23.PageInfo<BengkelProfileRouteArgs>(name);
}

class BengkelProfileRouteArgs {
  const BengkelProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i24.Key? key;

  final String userId;

  @override
  String toString() {
    return 'BengkelProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i9.CustomerProfileScreen]
class CustomerProfileRoute
    extends _i23.PageRouteInfo<CustomerProfileRouteArgs> {
  CustomerProfileRoute({
    _i24.Key? key,
    required String userId,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          CustomerProfileRoute.name,
          args: CustomerProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'CustomerProfileRoute';

  static const _i23.PageInfo<CustomerProfileRouteArgs> page =
      _i23.PageInfo<CustomerProfileRouteArgs>(name);
}

class CustomerProfileRouteArgs {
  const CustomerProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i24.Key? key;

  final String userId;

  @override
  String toString() {
    return 'CustomerProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i10.CustomProfileFormScreen]
class CustomProfileFormRoute
    extends _i23.PageRouteInfo<CustomProfileFormRouteArgs> {
  CustomProfileFormRoute({
    _i24.Key? key,
    void Function(_i25.CustomerProfile)? onCustomerProfileCreated,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          CustomProfileFormRoute.name,
          args: CustomProfileFormRouteArgs(
            key: key,
            onCustomerProfileCreated: onCustomerProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomProfileFormRoute';

  static const _i23.PageInfo<CustomProfileFormRouteArgs> page =
      _i23.PageInfo<CustomProfileFormRouteArgs>(name);
}

class CustomProfileFormRouteArgs {
  const CustomProfileFormRouteArgs({
    this.key,
    this.onCustomerProfileCreated,
  });

  final _i24.Key? key;

  final void Function(_i25.CustomerProfile)? onCustomerProfileCreated;

  @override
  String toString() {
    return 'CustomProfileFormRouteArgs{key: $key, onCustomerProfileCreated: $onCustomerProfileCreated}';
  }
}

/// generated route for
/// [_i11.BengkelProfileFormScreen]
class BengkelProfileFormRoute
    extends _i23.PageRouteInfo<BengkelProfileFormRouteArgs> {
  BengkelProfileFormRoute({
    _i24.Key? key,
    void Function(_i27.BengkelProfile)? onBengkelProfileCreated,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          BengkelProfileFormRoute.name,
          args: BengkelProfileFormRouteArgs(
            key: key,
            onBengkelProfileCreated: onBengkelProfileCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'BengkelProfileFormRoute';

  static const _i23.PageInfo<BengkelProfileFormRouteArgs> page =
      _i23.PageInfo<BengkelProfileFormRouteArgs>(name);
}

class BengkelProfileFormRouteArgs {
  const BengkelProfileFormRouteArgs({
    this.key,
    this.onBengkelProfileCreated,
  });

  final _i24.Key? key;

  final void Function(_i27.BengkelProfile)? onBengkelProfileCreated;

  @override
  String toString() {
    return 'BengkelProfileFormRouteArgs{key: $key, onBengkelProfileCreated: $onBengkelProfileCreated}';
  }
}

/// generated route for
/// [_i12.CustomerServisFormScreen]
class CustomerServisFormRoute
    extends _i23.PageRouteInfo<CustomerServisFormRouteArgs> {
  CustomerServisFormRoute({
    _i24.Key? key,
    required _i12.CustomerServisFormScreenMode mode,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          CustomerServisFormRoute.name,
          args: CustomerServisFormRouteArgs(
            key: key,
            mode: mode,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomerServisFormRoute';

  static const _i23.PageInfo<CustomerServisFormRouteArgs> page =
      _i23.PageInfo<CustomerServisFormRouteArgs>(name);
}

class CustomerServisFormRouteArgs {
  const CustomerServisFormRouteArgs({
    this.key,
    required this.mode,
  });

  final _i24.Key? key;

  final _i12.CustomerServisFormScreenMode mode;

  @override
  String toString() {
    return 'CustomerServisFormRouteArgs{key: $key, mode: $mode}';
  }
}

/// generated route for
/// [_i13.ServisBengkelDetailScreen]
class ServisBengkelDetailRoute
    extends _i23.PageRouteInfo<ServisBengkelDetailRouteArgs> {
  ServisBengkelDetailRoute({
    _i24.Key? key,
    required String servisId,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<ServisBengkelDetailRouteArgs> page =
      _i23.PageInfo<ServisBengkelDetailRouteArgs>(name);
}

class ServisBengkelDetailRouteArgs {
  const ServisBengkelDetailRouteArgs({
    this.key,
    required this.servisId,
  });

  final _i24.Key? key;

  final String servisId;

  @override
  String toString() {
    return 'ServisBengkelDetailRouteArgs{key: $key, servisId: $servisId}';
  }
}

/// generated route for
/// [_i14.ServisListScreen]
class ServisListRoute extends _i23.PageRouteInfo<ServisListRouteArgs> {
  ServisListRoute({
    _i24.Key? key,
    _i28.SGDataQuery? initialQuery,
    void Function(
      _i29.Servis,
      void Function(),
    )? onServisClick,
    _i14.ServisListType? type,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<ServisListRouteArgs> page =
      _i23.PageInfo<ServisListRouteArgs>(name);
}

class ServisListRouteArgs {
  const ServisListRouteArgs({
    this.key,
    this.initialQuery,
    this.onServisClick,
    this.type,
  });

  final _i24.Key? key;

  final _i28.SGDataQuery? initialQuery;

  final void Function(
    _i29.Servis,
    void Function(),
  )? onServisClick;

  final _i14.ServisListType? type;

  @override
  String toString() {
    return 'ServisListRouteArgs{key: $key, initialQuery: $initialQuery, onServisClick: $onServisClick, type: $type}';
  }
}

/// generated route for
/// [_i15.ServisCustomerDetailScreen]
class ServisCustomerDetailRoute
    extends _i23.PageRouteInfo<ServisCustomerDetailRouteArgs> {
  ServisCustomerDetailRoute({
    _i24.Key? key,
    required String servisId,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<ServisCustomerDetailRouteArgs> page =
      _i23.PageInfo<ServisCustomerDetailRouteArgs>(name);
}

class ServisCustomerDetailRouteArgs {
  const ServisCustomerDetailRouteArgs({
    this.key,
    required this.servisId,
  });

  final _i24.Key? key;

  final String servisId;

  @override
  String toString() {
    return 'ServisCustomerDetailRouteArgs{key: $key, servisId: $servisId}';
  }
}

/// generated route for
/// [_i16.SplashScreen]
class SplashRoute extends _i23.PageRouteInfo<void> {
  const SplashRoute({List<_i23.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i17.RegisterScreen]
class RegisterRoute extends _i23.PageRouteInfo<void> {
  const RegisterRoute({List<_i23.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i18.LoginScreen]
class LoginRoute extends _i23.PageRouteInfo<void> {
  const LoginRoute({List<_i23.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i19.AdminRouterList]
class AdminRouter extends _i23.PageRouteInfo<void> {
  const AdminRouter({List<_i23.PageRouteInfo>? children})
      : super(
          AdminRouter.name,
          initialChildren: children,
        );

  static const String name = 'AdminRouter';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i20.AdminBengkelListScreen]
class AdminBengkelListRoute extends _i23.PageRouteInfo<void> {
  const AdminBengkelListRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AdminBengkelListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminBengkelListRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i21.AdminCustomerListScreen]
class AdminCustomerListRoute extends _i23.PageRouteInfo<void> {
  const AdminCustomerListRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AdminCustomerListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminCustomerListRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i22.AdminJenisLayananListScreen]
class AdminJenisLayananListRoute extends _i23.PageRouteInfo<void> {
  const AdminJenisLayananListRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AdminJenisLayananListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminJenisLayananListRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}
