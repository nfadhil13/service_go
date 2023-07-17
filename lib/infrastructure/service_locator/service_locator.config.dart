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
    as _i12;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i13;
import '../../modules/authentication/data/datasource/remote/user_data_remote_dts.dart'
    as _i11;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i15;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i14;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i22;
import '../../modules/authentication/domain/usecases/login.dart' as _i23;
import '../../modules/authentication/domain/usecases/logout.dart' as _i25;
import '../../modules/authentication/domain/usecases/register.dart' as _i27;
import '../../modules/authentication/presentation/screens/login/cubit/login_cubit.dart'
    as _i24;
import '../../modules/authentication/presentation/screens/register/cubit/register_cubit.dart'
    as _i31;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i29;
import '../../modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart'
    as _i16;
import '../../modules/bengkel/data/datasource/remote/jenis_layanan_remote_dts.dart'
    as _i6;
import '../../modules/bengkel/data/repositories/bengkel_profile_repository_impl.dart'
    as _i18;
import '../../modules/bengkel/data/repositories/jenis_layanan_repository.dart'
    as _i8;
import '../../modules/bengkel/domain/repositories/bengkel_profile_repository.dart'
    as _i17;
import '../../modules/bengkel/domain/repositories/jenis_layanan_repository.dart'
    as _i7;
import '../../modules/bengkel/domain/usecase/get_all_jenis_layanan.dart'
    as _i21;
import '../../modules/profile/domain/usecase/check_is_bengkel_has_profile.dart'
    as _i19;
import '../../modules/profile/domain/usecase/create_bengkel_profile.dart'
    as _i20;
import '../../modules/profile/domain/usecase/prepare_bengkel_profile_form.dart'
    as _i26;
import '../../modules/profile/presentation/screens/bengkel_profile_form/cubit/form/bengkel_profile_form_cubit.dart'
    as _i30;
import '../architecutre/cubits/messenger/messenger_cubit.dart' as _i9;
import '../architecutre/cubits/session/session_cubit.dart' as _i28;
import '../local_storage/secure_storage/secure_storage.dart' as _i10;
import 'modules/core_module.dart' as _i32;

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
    gh.factory<_i6.JenisLayananRemoteDTS>(() =>
        _i6.JenisLayananRemoteDTSImpl(firestore: gh<_i4.FirebaseFirestore>()));
    gh.factory<_i7.JenisLayananRepository>(
        () => _i8.JenisLayananRepositoryImpl(gh<_i6.JenisLayananRemoteDTS>()));
    gh.lazySingleton<_i9.MessengerCubit>(() => _i9.MessengerCubit());
    gh.factory<_i10.SecureStorage>(
        () => _i10.SecureStorageImpl(gh<_i5.FlutterSecureStorage>()));
    gh.factory<_i11.UserDataRemoteDTS>(
        () => _i11.UserDataRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i12.AuthenticationLocalDTS>(() => _i12.AuthLocalDTSImpl(
          gh<_i10.SecureStorage>(),
          gh<_i3.FirebaseAuth>(),
        ));
    gh.factory<_i13.AuthenticationRemoteDTS>(
        () => _i13.AuthenticationRemoteDTSImpl(gh<_i3.FirebaseAuth>()));
    gh.factory<_i14.AuthenticationRepo>(() => _i15.AuthenticationRepoImpl(
          gh<_i13.AuthenticationRemoteDTS>(),
          gh<_i12.AuthenticationLocalDTS>(),
          gh<_i11.UserDataRemoteDTS>(),
        ));
    gh.factory<_i16.BengkelProfileRemoteDTS>(
        () => _i16.BengkelProfileRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i17.BengkelProfileRepository>(() =>
        _i18.BengkelProfileRepositoryImpl(gh<_i16.BengkelProfileRemoteDTS>()));
    gh.factory<_i19.CheckIfBengkelHasProfile>(
        () => _i19.CheckIfBengkelHasProfile(
              gh<_i17.BengkelProfileRepository>(),
              gh<_i14.AuthenticationRepo>(),
            ));
    gh.factory<_i20.CreateBengkelProfile>(
        () => _i20.CreateBengkelProfile(gh<_i17.BengkelProfileRepository>()));
    gh.factory<_i21.GetAllJenisLayanan>(
        () => _i21.GetAllJenisLayanan(gh<_i7.JenisLayananRepository>()));
    gh.factory<_i22.GetCurrentSession>(
        () => _i22.GetCurrentSession(gh<_i14.AuthenticationRepo>()));
    gh.factory<_i23.Login>(() => _i23.Login(gh<_i14.AuthenticationRepo>()));
    gh.factory<_i24.LoginCubit>(() => _i24.LoginCubit(gh<_i23.Login>()));
    gh.factory<_i25.Logout>(() => _i25.Logout(gh<_i14.AuthenticationRepo>()));
    gh.factory<_i26.PrepareBengkelProfileForm>(
        () => _i26.PrepareBengkelProfileForm(
              gh<_i7.JenisLayananRepository>(),
              gh<_i17.BengkelProfileRepository>(),
            ));
    gh.factory<_i27.RegisterUserAccount>(
        () => _i27.RegisterUserAccount(gh<_i14.AuthenticationRepo>()));
    gh.lazySingleton<_i28.SessionCubit>(
        () => _i28.SessionCubit(gh<_i25.Logout>()));
    gh.factory<_i29.SplashCubit>(
        () => _i29.SplashCubit(gh<_i22.GetCurrentSession>()));
    gh.factoryParam<_i30.BengkelProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i30.BengkelProfileFormCubit(
          gh<_i26.PrepareBengkelProfileForm>(),
          userId,
        ));
    gh.factory<_i31.RegisterCubit>(() => _i31.RegisterCubit(
          gh<_i9.MessengerCubit>(),
          gh<_i27.RegisterUserAccount>(),
        ));
    return this;
  }
}

class _$CoreModules extends _i32.CoreModules {}
