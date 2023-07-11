// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/authentication/data/datasource/local/authentication_local_dts.dart'
    as _i9;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i10;
import '../../modules/authentication/data/datasource/remote/user_data_remote_dts.dart'
    as _i8;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i12;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i11;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i17;
import '../../modules/authentication/domain/usecases/login.dart' as _i18;
import '../../modules/authentication/domain/usecases/logout.dart' as _i20;
import '../../modules/authentication/domain/usecases/register.dart' as _i21;
import '../../modules/authentication/presentation/screens/login/cubit/login_cubit.dart'
    as _i19;
import '../../modules/authentication/presentation/screens/register/cubit/register_cubit.dart'
    as _i24;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i23;
import '../../modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart'
    as _i13;
import '../../modules/bengkel/data/repositories/bengkel_profile_repository_impl.dart'
    as _i15;
import '../../modules/bengkel/domain/repositories/bengkel_profile_repository.dart'
    as _i14;
import '../../modules/profile/domain/usecase/check_is_bengkel_has_profile.dart'
    as _i16;
import '../architecutre/cubits/messenger/messenger_cubit.dart' as _i6;
import '../architecutre/cubits/session/session_cubit.dart' as _i22;
import '../local_storage/secure_storage/secure_storage.dart' as _i7;
import 'modules/core_module.dart' as _i25;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModules = _$CoreModules();
    gh.singleton<_i3.FirebaseAuth>(coreModules.getFirebaseUAuth());
    gh.singleton<_i4.FirebaseFirestore>(coreModules.getFirebaseFirestore());
    gh.factory<_i5.FlutterSecureStorage>(
        () => coreModules.getFlutterSecureStorage());
    gh.lazySingleton<_i6.MessengerCubit>(() => _i6.MessengerCubit());
    gh.factory<_i7.SecureStorage>(
        () => _i7.SecureStorageImpl(gh<_i5.FlutterSecureStorage>()));
    gh.factory<_i8.UserDataRemoteDTS>(
        () => _i8.UserDataRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i9.AuthenticationLocalDTS>(() => _i9.AuthLocalDTSImpl(
          gh<_i7.SecureStorage>(),
          gh<_i3.FirebaseAuth>(),
        ));
    gh.factory<_i10.AuthenticationRemoteDTS>(
        () => _i10.AuthenticationRemoteDTSImpl(gh<_i3.FirebaseAuth>()));
    gh.factory<_i11.AuthenticationRepo>(() => _i12.AuthenticationRepoImpl(
          gh<_i10.AuthenticationRemoteDTS>(),
          gh<_i9.AuthenticationLocalDTS>(),
          gh<_i8.UserDataRemoteDTS>(),
        ));
    gh.factory<_i13.BengkelProfileRemoteDTS>(
        () => _i13.BengkelProfileRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i14.BengkelProfileRepository>(() =>
        _i15.BengkelProfileRepositoryImpl(gh<_i13.BengkelProfileRemoteDTS>()));
    gh.factory<_i16.CheckIfBengkelHasProfile>(
        () => _i16.CheckIfBengkelHasProfile(
              gh<_i14.BengkelProfileRepository>(),
              gh<_i11.AuthenticationRepo>(),
            ));
    gh.factory<_i17.GetCurrentSession>(
        () => _i17.GetCurrentSession(gh<_i11.AuthenticationRepo>()));
    gh.factory<_i18.Login>(() => _i18.Login(gh<_i11.AuthenticationRepo>()));
    gh.factory<_i19.LoginCubit>(() => _i19.LoginCubit(gh<_i18.Login>()));
    gh.factory<_i20.Logout>(() => _i20.Logout(gh<_i11.AuthenticationRepo>()));
    gh.factory<_i21.RegisterUserAccount>(
        () => _i21.RegisterUserAccount(gh<_i11.AuthenticationRepo>()));
    gh.lazySingleton<_i22.SessionCubit>(
        () => _i22.SessionCubit(gh<_i20.Logout>()));
    gh.factory<_i23.SplashCubit>(
        () => _i23.SplashCubit(gh<_i17.GetCurrentSession>()));
    gh.factory<_i24.RegisterCubit>(() => _i24.RegisterCubit(
          gh<_i6.MessengerCubit>(),
          gh<_i21.RegisterUserAccount>(),
        ));
    return this;
  }
}

class _$CoreModules extends _i25.CoreModules {}
