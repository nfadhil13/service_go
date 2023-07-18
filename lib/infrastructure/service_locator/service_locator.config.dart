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
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/authentication/data/datasource/local/authentication_local_dts.dart'
    as _i15;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i16;
import '../../modules/authentication/data/datasource/remote/user_data_remote_dts.dart'
    as _i14;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i18;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i17;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i30;
import '../../modules/authentication/domain/usecases/login.dart' as _i31;
import '../../modules/authentication/domain/usecases/logout.dart' as _i33;
import '../../modules/authentication/domain/usecases/register.dart' as _i36;
import '../../modules/authentication/presentation/screens/login/cubit/login_cubit.dart'
    as _i32;
import '../../modules/authentication/presentation/screens/register/cubit/register_cubit.dart'
    as _i43;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i38;
import '../../modules/bengkel/data/datasource/firestore/bengkel_firestore_dts.dart'
    as _i19;
import '../../modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart'
    as _i7;
import '../../modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart'
    as _i20;
import '../../modules/bengkel/data/datasource/remote/jenis_layanan_remote_dts.dart'
    as _i8;
import '../../modules/bengkel/data/repositories/bengkel_profile_repository_impl.dart'
    as _i22;
import '../../modules/bengkel/data/repositories/jenis_layanan_repository.dart'
    as _i10;
import '../../modules/bengkel/domain/repositories/bengkel_profile_repository.dart'
    as _i21;
import '../../modules/bengkel/domain/repositories/jenis_layanan_repository.dart'
    as _i9;
import '../../modules/bengkel/domain/usecase/get_all_jenis_layanan.dart'
    as _i29;
import '../../modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart'
    as _i25;
import '../../modules/customer/data/datasource/remote/customer_profile_remote_dts.dart'
    as _i26;
import '../../modules/customer/data/repositories/customer_profile_repo_impl.dart'
    as _i28;
import '../../modules/customer/domain/repositories/customer_profile_repo.dart'
    as _i27;
import '../../modules/profile/domain/usecase/bengkel/check_is_bengkel_has_profile.dart'
    as _i23;
import '../../modules/profile/domain/usecase/bengkel/create_bengkel_profile.dart'
    as _i24;
import '../../modules/profile/domain/usecase/bengkel/prepare_bengkel_profile_form.dart'
    as _i34;
import '../../modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart'
    as _i40;
import '../../modules/profile/domain/usecase/customer/craete_or_update_customer.dart'
    as _i41;
import '../../modules/profile/domain/usecase/customer/prepare_customer_form.dart'
    as _i35;
import '../../modules/profile/presentation/screens/bengkel_profile_form/cubit/form/bengkel_profile_form_cubit.dart'
    as _i39;
import '../../modules/profile/presentation/screens/customer_profile_form/cubit/customer_profile_form_cubit.dart'
    as _i42;
import '../architecutre/cubits/messenger/messenger_cubit.dart' as _i11;
import '../architecutre/cubits/session/session_cubit.dart' as _i37;
import '../local_storage/secure_storage/secure_storage.dart' as _i13;
import '../utils/storage/sg_storage_helper.dart' as _i12;
import 'modules/core_module.dart' as _i44;

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
    gh.singleton<_i5.FirebaseStorage>(coreModules.getFirebaseStorage());
    gh.factory<_i6.FlutterSecureStorage>(
        () => coreModules.getFlutterSecureStorage());
    gh.factory<_i7.JenisLayananFirestoreDTS>(
        () => _i7.JenisLayananFirestoreDTS(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i8.JenisLayananRemoteDTS>(() =>
        _i8.JenisLayananRemoteDTSImpl(gh<_i7.JenisLayananFirestoreDTS>()));
    gh.factory<_i9.JenisLayananRepository>(
        () => _i10.JenisLayananRepositoryImpl(gh<_i8.JenisLayananRemoteDTS>()));
    gh.lazySingleton<_i11.MessengerCubit>(() => _i11.MessengerCubit());
    gh.factory<_i12.SGStorageHelper>(
        () => _i12.SGStorageHelperImpl(gh<_i5.FirebaseStorage>()));
    gh.factory<_i13.SecureStorage>(
        () => _i13.SecureStorageImpl(gh<_i6.FlutterSecureStorage>()));
    gh.factory<_i14.UserDataRemoteDTS>(
        () => _i14.UserDataRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i15.AuthenticationLocalDTS>(() => _i15.AuthLocalDTSImpl(
          gh<_i13.SecureStorage>(),
          gh<_i3.FirebaseAuth>(),
        ));
    gh.factory<_i16.AuthenticationRemoteDTS>(
        () => _i16.AuthenticationRemoteDTSImpl(gh<_i3.FirebaseAuth>()));
    gh.factory<_i17.AuthenticationRepo>(() => _i18.AuthenticationRepoImpl(
          gh<_i16.AuthenticationRemoteDTS>(),
          gh<_i15.AuthenticationLocalDTS>(),
          gh<_i14.UserDataRemoteDTS>(),
        ));
    gh.factory<_i19.BengkelProfileFirestoreDTS>(
        () => _i19.BengkelProfileFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i5.FirebaseStorage>(),
            ));
    gh.factory<_i20.BengkelProfileRemoteDTS>(
        () => _i20.BengkelProfileRemoteDTSImpl(
              gh<_i19.BengkelProfileFirestoreDTS>(),
              gh<_i7.JenisLayananFirestoreDTS>(),
              gh<_i12.SGStorageHelper>(),
            ));
    gh.factory<_i21.BengkelProfileRepository>(() =>
        _i22.BengkelProfileRepositoryImpl(gh<_i20.BengkelProfileRemoteDTS>()));
    gh.factory<_i23.CheckIfBengkelHasProfile>(
        () => _i23.CheckIfBengkelHasProfile(
              gh<_i21.BengkelProfileRepository>(),
              gh<_i17.AuthenticationRepo>(),
            ));
    gh.factory<_i24.CreateBengkelProfile>(
        () => _i24.CreateBengkelProfile(gh<_i21.BengkelProfileRepository>()));
    gh.factory<_i25.CustomProfileFirestoreDTS>(
        () => _i25.CustomProfileFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i5.FirebaseStorage>(),
            ));
    gh.factory<_i26.CustomerProfileRemoteDTS>(() =>
        _i26.CustomerProfileRemoteDTSImpl(
            gh<_i25.CustomProfileFirestoreDTS>()));
    gh.factory<_i27.CustomerProfileRepo>(() =>
        _i28.CustomerProfileRepoImpl(gh<_i26.CustomerProfileRemoteDTS>()));
    gh.factory<_i29.GetAllJenisLayanan>(
        () => _i29.GetAllJenisLayanan(gh<_i9.JenisLayananRepository>()));
    gh.factory<_i30.GetCurrentSession>(
        () => _i30.GetCurrentSession(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i31.Login>(() => _i31.Login(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i32.LoginCubit>(() => _i32.LoginCubit(gh<_i31.Login>()));
    gh.factory<_i33.Logout>(() => _i33.Logout(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i34.PrepareBengkelProfileForm>(
        () => _i34.PrepareBengkelProfileForm(
              gh<_i9.JenisLayananRepository>(),
              gh<_i21.BengkelProfileRepository>(),
            ));
    gh.factory<_i35.PrepareCustomerForm>(
        () => _i35.PrepareCustomerForm(gh<_i27.CustomerProfileRepo>()));
    gh.factory<_i36.RegisterUserAccount>(
        () => _i36.RegisterUserAccount(gh<_i17.AuthenticationRepo>()));
    gh.lazySingleton<_i37.SessionCubit>(
        () => _i37.SessionCubit(gh<_i33.Logout>()));
    gh.factory<_i38.SplashCubit>(
        () => _i38.SplashCubit(gh<_i30.GetCurrentSession>()));
    gh.factoryParam<_i39.BengkelProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i39.BengkelProfileFormCubit(
          gh<_i34.PrepareBengkelProfileForm>(),
          userId,
          gh<_i24.CreateBengkelProfile>(),
        ));
    gh.factory<_i40.CheckIfCustomerHasProfile>(
        () => _i40.CheckIfCustomerHasProfile(
              gh<_i27.CustomerProfileRepo>(),
              gh<_i17.AuthenticationRepo>(),
            ));
    gh.factory<_i41.CraeteOrUpdateCustomer>(
        () => _i41.CraeteOrUpdateCustomer(gh<_i27.CustomerProfileRepo>()));
    gh.factoryParam<_i42.CustomerProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i42.CustomerProfileFormCubit(
          gh<_i35.PrepareCustomerForm>(),
          userId,
          gh<_i41.CraeteOrUpdateCustomer>(),
        ));
    gh.factory<_i43.RegisterCubit>(() => _i43.RegisterCubit(
          gh<_i11.MessengerCubit>(),
          gh<_i36.RegisterUserAccount>(),
        ));
    return this;
  }
}

class _$CoreModules extends _i44.CoreModules {}
