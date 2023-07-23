// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/authentication/data/datasource/local/authentication_local_dts.dart'
    as _i18;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i19;
import '../../modules/authentication/data/datasource/remote/user_data_remote_dts.dart'
    as _i17;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i21;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i20;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i34;
import '../../modules/authentication/domain/usecases/login.dart' as _i36;
import '../../modules/authentication/domain/usecases/logout.dart' as _i38;
import '../../modules/authentication/domain/usecases/register.dart' as _i41;
import '../../modules/authentication/presentation/screens/login/cubit/login_cubit.dart'
    as _i37;
import '../../modules/authentication/presentation/screens/register/cubit/register_cubit.dart'
    as _i49;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i43;
import '../../modules/bengkel/data/datasource/firestore/bengkel_firestore_dts.dart'
    as _i22;
import '../../modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart'
    as _i9;
import '../../modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart'
    as _i23;
import '../../modules/bengkel/data/datasource/remote/jenis_layanan_remote_dts.dart'
    as _i10;
import '../../modules/bengkel/data/repositories/bengkel_profile_repository_impl.dart'
    as _i25;
import '../../modules/bengkel/data/repositories/jenis_layanan_repository.dart'
    as _i12;
import '../../modules/bengkel/domain/model/bengkel_profile.dart' as _i4;
import '../../modules/bengkel/domain/repositories/bengkel_profile_repository.dart'
    as _i24;
import '../../modules/bengkel/domain/repositories/jenis_layanan_repository.dart'
    as _i11;
import '../../modules/bengkel/domain/usecase/get_all_bengkel.dart' as _i32;
import '../../modules/bengkel/domain/usecase/get_all_jenis_layanan.dart'
    as _i33;
import '../../modules/bengkel/presentation/cubits/bengkel_list/bengkel_list_cubit.dart'
    as _i44;
import '../../modules/bengkel/presentation/cubits/bengkel_profile/bengkel_profile_cubit.dart'
    as _i3;
import '../../modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart'
    as _i28;
import '../../modules/customer/data/datasource/remote/customer_profile_remote_dts.dart'
    as _i29;
import '../../modules/customer/data/repositories/customer_profile_repo_impl.dart'
    as _i31;
import '../../modules/customer/domain/repositories/customer_profile_repo.dart'
    as _i30;
import '../../modules/profile/domain/usecase/bengkel/check_is_bengkel_has_profile.dart'
    as _i26;
import '../../modules/profile/domain/usecase/bengkel/create_bengkel_profile.dart'
    as _i27;
import '../../modules/profile/domain/usecase/bengkel/prepare_bengkel_profile_form.dart'
    as _i39;
import '../../modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart'
    as _i46;
import '../../modules/profile/domain/usecase/customer/craete_or_update_customer.dart'
    as _i47;
import '../../modules/profile/domain/usecase/customer/prepare_customer_form.dart'
    as _i40;
import '../../modules/profile/presentation/screens/bengkel_profile_form/cubit/form/bengkel_profile_form_cubit.dart'
    as _i45;
import '../../modules/profile/presentation/screens/customer_profile_form/cubit/customer_profile_form_cubit.dart'
    as _i48;
import '../architecutre/cubits/location/location_cubit.dart' as _i35;
import '../architecutre/cubits/messenger/messenger_cubit.dart' as _i14;
import '../architecutre/cubits/session/session_cubit.dart' as _i42;
import '../local_storage/secure_storage/secure_storage.dart' as _i16;
import '../utils/location/location_util.dart' as _i13;
import '../utils/storage/sg_storage_helper.dart' as _i15;
import 'modules/core_module.dart' as _i50;

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
    gh.factory<_i3.BengkelProfileCubit>(
        () => _i3.BengkelProfileCubit(gh<_i4.BengkelProfile>()));
    gh.singleton<_i5.FirebaseAuth>(coreModules.getFirebaseUAuth());
    gh.singleton<_i6.FirebaseFirestore>(coreModules.getFirebaseFirestore());
    gh.singleton<_i7.FirebaseStorage>(coreModules.getFirebaseStorage());
    gh.factory<_i8.FlutterSecureStorage>(
        () => coreModules.getFlutterSecureStorage());
    gh.factory<_i9.JenisLayananFirestoreDTS>(
        () => _i9.JenisLayananFirestoreDTS(gh<_i6.FirebaseFirestore>()));
    gh.factory<_i10.JenisLayananRemoteDTS>(() =>
        _i10.JenisLayananRemoteDTSImpl(gh<_i9.JenisLayananFirestoreDTS>()));
    gh.factory<_i11.JenisLayananRepository>(() =>
        _i12.JenisLayananRepositoryImpl(gh<_i10.JenisLayananRemoteDTS>()));
    gh.factory<_i13.LocationUtil>(() => _i13.LocationUtilImpl());
    gh.lazySingleton<_i14.MessengerCubit>(() => _i14.MessengerCubit());
    gh.factory<_i15.SGStorageHelper>(
        () => _i15.SGStorageHelperImpl(gh<_i7.FirebaseStorage>()));
    gh.factory<_i16.SecureStorage>(
        () => _i16.SecureStorageImpl(gh<_i8.FlutterSecureStorage>()));
    gh.factory<_i17.UserDataRemoteDTS>(
        () => _i17.UserDataRemoteDTSImpl(gh<_i6.FirebaseFirestore>()));
    gh.factory<_i18.AuthenticationLocalDTS>(() => _i18.AuthLocalDTSImpl(
          gh<_i16.SecureStorage>(),
          gh<_i5.FirebaseAuth>(),
        ));
    gh.factory<_i19.AuthenticationRemoteDTS>(
        () => _i19.AuthenticationRemoteDTSImpl(gh<_i5.FirebaseAuth>()));
    gh.factory<_i20.AuthenticationRepo>(() => _i21.AuthenticationRepoImpl(
          gh<_i19.AuthenticationRemoteDTS>(),
          gh<_i18.AuthenticationLocalDTS>(),
          gh<_i17.UserDataRemoteDTS>(),
        ));
    gh.factory<_i22.BengkelProfileFirestoreDTS>(
        () => _i22.BengkelProfileFirestoreDTS(
              gh<_i6.FirebaseFirestore>(),
              gh<_i7.FirebaseStorage>(),
            ));
    gh.factory<_i23.BengkelProfileRemoteDTS>(
        () => _i23.BengkelProfileRemoteDTSImpl(
              gh<_i22.BengkelProfileFirestoreDTS>(),
              gh<_i9.JenisLayananFirestoreDTS>(),
              gh<_i15.SGStorageHelper>(),
            ));
    gh.factory<_i24.BengkelProfileRepository>(() =>
        _i25.BengkelProfileRepositoryImpl(gh<_i23.BengkelProfileRemoteDTS>()));
    gh.factory<_i26.CheckIfBengkelHasProfile>(
        () => _i26.CheckIfBengkelHasProfile(
              gh<_i24.BengkelProfileRepository>(),
              gh<_i20.AuthenticationRepo>(),
            ));
    gh.factory<_i27.CreateBengkelProfile>(
        () => _i27.CreateBengkelProfile(gh<_i24.BengkelProfileRepository>()));
    gh.factory<_i28.CustomProfileFirestoreDTS>(
        () => _i28.CustomProfileFirestoreDTS(
              gh<_i6.FirebaseFirestore>(),
              gh<_i7.FirebaseStorage>(),
            ));
    gh.factory<_i29.CustomerProfileRemoteDTS>(() =>
        _i29.CustomerProfileRemoteDTSImpl(
            gh<_i28.CustomProfileFirestoreDTS>()));
    gh.factory<_i30.CustomerProfileRepo>(() =>
        _i31.CustomerProfileRepoImpl(gh<_i29.CustomerProfileRemoteDTS>()));
    gh.factory<_i32.GetAllBengkel>(
        () => _i32.GetAllBengkel(gh<_i24.BengkelProfileRepository>()));
    gh.factory<_i33.GetAllJenisLayanan>(
        () => _i33.GetAllJenisLayanan(gh<_i11.JenisLayananRepository>()));
    gh.factory<_i34.GetCurrentSession>(
        () => _i34.GetCurrentSession(gh<_i20.AuthenticationRepo>()));
    gh.factory<_i35.InitialLocationCubit>(
        () => _i35.InitialLocationCubit(gh<_i13.LocationUtil>()));
    gh.factory<_i36.Login>(() => _i36.Login(gh<_i20.AuthenticationRepo>()));
    gh.factory<_i37.LoginCubit>(() => _i37.LoginCubit(gh<_i36.Login>()));
    gh.factory<_i38.Logout>(() => _i38.Logout(gh<_i20.AuthenticationRepo>()));
    gh.factory<_i39.PrepareBengkelProfileForm>(
        () => _i39.PrepareBengkelProfileForm(
              gh<_i11.JenisLayananRepository>(),
              gh<_i24.BengkelProfileRepository>(),
            ));
    gh.factory<_i40.PrepareCustomerForm>(
        () => _i40.PrepareCustomerForm(gh<_i30.CustomerProfileRepo>()));
    gh.factory<_i41.RegisterUserAccount>(
        () => _i41.RegisterUserAccount(gh<_i20.AuthenticationRepo>()));
    gh.lazySingleton<_i42.SessionCubit>(
        () => _i42.SessionCubit(gh<_i38.Logout>()));
    gh.factory<_i43.SplashCubit>(
        () => _i43.SplashCubit(gh<_i34.GetCurrentSession>()));
    gh.factory<_i44.BengkelListCubit>(
        () => _i44.BengkelListCubit(gh<_i32.GetAllBengkel>()));
    gh.factoryParam<_i45.BengkelProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i45.BengkelProfileFormCubit(
          gh<_i39.PrepareBengkelProfileForm>(),
          userId,
          gh<_i27.CreateBengkelProfile>(),
        ));
    gh.factory<_i46.CheckIfCustomerHasProfile>(
        () => _i46.CheckIfCustomerHasProfile(
              gh<_i30.CustomerProfileRepo>(),
              gh<_i20.AuthenticationRepo>(),
            ));
    gh.factory<_i47.CraeteOrUpdateCustomer>(
        () => _i47.CraeteOrUpdateCustomer(gh<_i30.CustomerProfileRepo>()));
    gh.factoryParam<_i48.CustomerProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i48.CustomerProfileFormCubit(
          gh<_i40.PrepareCustomerForm>(),
          userId,
          gh<_i47.CraeteOrUpdateCustomer>(),
        ));
    gh.factory<_i49.RegisterCubit>(() => _i49.RegisterCubit(
          gh<_i14.MessengerCubit>(),
          gh<_i41.RegisterUserAccount>(),
        ));
    return this;
  }
}

class _$CoreModules extends _i50.CoreModules {}
