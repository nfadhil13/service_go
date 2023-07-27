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
    as _i17;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i18;
import '../../modules/authentication/data/datasource/remote/user_data_remote_dts.dart'
    as _i16;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i20;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i19;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i33;
import '../../modules/authentication/domain/usecases/login.dart' as _i35;
import '../../modules/authentication/domain/usecases/logout.dart' as _i37;
import '../../modules/authentication/domain/usecases/register.dart' as _i41;
import '../../modules/authentication/presentation/screens/login/cubit/login_cubit.dart'
    as _i36;
import '../../modules/authentication/presentation/screens/register/cubit/register_cubit.dart'
    as _i55;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i46;
import '../../modules/bengkel/data/datasource/firestore/bengkel_firestore_dts.dart'
    as _i21;
import '../../modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart'
    as _i7;
import '../../modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart'
    as _i22;
import '../../modules/bengkel/data/datasource/remote/jenis_layanan_remote_dts.dart'
    as _i8;
import '../../modules/bengkel/data/repositories/bengkel_profile_repository_impl.dart'
    as _i24;
import '../../modules/bengkel/data/repositories/jenis_layanan_repository.dart'
    as _i10;
import '../../modules/bengkel/domain/repositories/bengkel_profile_repository.dart'
    as _i23;
import '../../modules/bengkel/domain/repositories/jenis_layanan_repository.dart'
    as _i9;
import '../../modules/bengkel/domain/usecase/get_all_bengkel.dart' as _i31;
import '../../modules/bengkel/domain/usecase/get_all_jenis_layanan.dart'
    as _i32;
import '../../modules/bengkel/presentation/cubits/bengkel_list/bengkel_list_cubit.dart'
    as _i47;
import '../../modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart'
    as _i27;
import '../../modules/customer/data/datasource/remote/customer_profile_remote_dts.dart'
    as _i28;
import '../../modules/customer/data/repositories/customer_profile_repo_impl.dart'
    as _i30;
import '../../modules/customer/domain/repositories/customer_profile_repo.dart'
    as _i29;
import '../../modules/profile/domain/usecase/bengkel/check_is_bengkel_has_profile.dart'
    as _i25;
import '../../modules/profile/domain/usecase/bengkel/create_bengkel_profile.dart'
    as _i26;
import '../../modules/profile/domain/usecase/bengkel/prepare_bengkel_profile_form.dart'
    as _i38;
import '../../modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart'
    as _i49;
import '../../modules/profile/domain/usecase/customer/craete_or_update_customer.dart'
    as _i50;
import '../../modules/profile/domain/usecase/customer/prepare_customer_form.dart'
    as _i39;
import '../../modules/profile/presentation/screens/bengkel_profile_form/cubit/form/bengkel_profile_form_cubit.dart'
    as _i48;
import '../../modules/profile/presentation/screens/customer_profile_form/cubit/customer_profile_form_cubit.dart'
    as _i52;
import '../../modules/service/data/datasource/firestore/servis_firestore_dts.dart'
    as _i15;
import '../../modules/service/data/datasource/remote/servis_remote_dts.dart'
    as _i42;
import '../../modules/service/data/repositories/servis_repository_impl.dart'
    as _i44;
import '../../modules/service/domain/repositories/servis_repository.dart'
    as _i43;
import '../../modules/service/domain/usecases/create_or_update_servis.dart'
    as _i51;
import '../../modules/service/domain/usecases/get_servis_list.dart' as _i53;
import '../../modules/service/domain/usecases/prepare_customer_servis_create_form.dart'
    as _i40;
import '../../modules/service/domain/usecases/prepare_customer_servis_form.dart'
    as _i54;
import '../../modules/service/presentation/cubits/cubit/servis_list_cubit.dart'
    as _i56;
import '../../modules/service/presentation/screens/customer_form/cubit/customer_servis_form_cubit.dart'
    as _i57;
import '../architecutre/cubits/location/location_cubit.dart' as _i34;
import '../architecutre/cubits/messenger/messenger_cubit.dart' as _i12;
import '../architecutre/cubits/session/session_cubit.dart' as _i45;
import '../local_storage/secure_storage/secure_storage.dart' as _i14;
import '../utils/location/location_util.dart' as _i11;
import '../utils/storage/sg_storage_helper.dart' as _i13;
import 'modules/core_module.dart' as _i58;

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
    gh.factory<_i11.LocationUtil>(() => _i11.LocationUtilImpl());
    gh.lazySingleton<_i12.MessengerCubit>(() => _i12.MessengerCubit());
    gh.factory<_i13.SGStorageHelper>(
        () => _i13.SGStorageHelperImpl(gh<_i5.FirebaseStorage>()));
    gh.factory<_i14.SecureStorage>(
        () => _i14.SecureStorageImpl(gh<_i6.FlutterSecureStorage>()));
    gh.factory<_i15.ServisFirestoreDTS>(() => _i15.ServisFirestoreDTS(
          gh<_i4.FirebaseFirestore>(),
          gh<_i5.FirebaseStorage>(),
        ));
    gh.factory<_i16.UserDataRemoteDTS>(
        () => _i16.UserDataRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i17.AuthenticationLocalDTS>(() => _i17.AuthLocalDTSImpl(
          gh<_i14.SecureStorage>(),
          gh<_i3.FirebaseAuth>(),
        ));
    gh.factory<_i18.AuthenticationRemoteDTS>(
        () => _i18.AuthenticationRemoteDTSImpl(gh<_i3.FirebaseAuth>()));
    gh.factory<_i19.AuthenticationRepo>(() => _i20.AuthenticationRepoImpl(
          gh<_i18.AuthenticationRemoteDTS>(),
          gh<_i17.AuthenticationLocalDTS>(),
          gh<_i16.UserDataRemoteDTS>(),
        ));
    gh.factory<_i21.BengkelProfileFirestoreDTS>(
        () => _i21.BengkelProfileFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i5.FirebaseStorage>(),
            ));
    gh.factory<_i22.BengkelProfileRemoteDTS>(
        () => _i22.BengkelProfileRemoteDTSImpl(
              gh<_i21.BengkelProfileFirestoreDTS>(),
              gh<_i7.JenisLayananFirestoreDTS>(),
              gh<_i13.SGStorageHelper>(),
            ));
    gh.factory<_i23.BengkelProfileRepository>(() =>
        _i24.BengkelProfileRepositoryImpl(gh<_i22.BengkelProfileRemoteDTS>()));
    gh.factory<_i25.CheckIfBengkelHasProfile>(
        () => _i25.CheckIfBengkelHasProfile(
              gh<_i23.BengkelProfileRepository>(),
              gh<_i19.AuthenticationRepo>(),
            ));
    gh.factory<_i26.CreateBengkelProfile>(
        () => _i26.CreateBengkelProfile(gh<_i23.BengkelProfileRepository>()));
    gh.factory<_i27.CustomerProfileFirestoreDTS>(
        () => _i27.CustomerProfileFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i5.FirebaseStorage>(),
            ));
    gh.factory<_i28.CustomerProfileRemoteDTS>(() =>
        _i28.CustomerProfileRemoteDTSImpl(
            gh<_i27.CustomerProfileFirestoreDTS>()));
    gh.factory<_i29.CustomerProfileRepo>(() =>
        _i30.CustomerProfileRepoImpl(gh<_i28.CustomerProfileRemoteDTS>()));
    gh.factory<_i31.GetAllBengkel>(
        () => _i31.GetAllBengkel(gh<_i23.BengkelProfileRepository>()));
    gh.factory<_i32.GetAllJenisLayanan>(
        () => _i32.GetAllJenisLayanan(gh<_i9.JenisLayananRepository>()));
    gh.factory<_i33.GetCurrentSession>(
        () => _i33.GetCurrentSession(gh<_i19.AuthenticationRepo>()));
    gh.factory<_i34.InitialLocationCubit>(
        () => _i34.InitialLocationCubit(gh<_i11.LocationUtil>()));
    gh.factory<_i35.Login>(() => _i35.Login(gh<_i19.AuthenticationRepo>()));
    gh.factory<_i36.LoginCubit>(() => _i36.LoginCubit(gh<_i35.Login>()));
    gh.factory<_i37.Logout>(() => _i37.Logout(gh<_i19.AuthenticationRepo>()));
    gh.factory<_i38.PrepareBengkelProfileForm>(
        () => _i38.PrepareBengkelProfileForm(
              gh<_i9.JenisLayananRepository>(),
              gh<_i23.BengkelProfileRepository>(),
            ));
    gh.factory<_i39.PrepareCustomerForm>(
        () => _i39.PrepareCustomerForm(gh<_i29.CustomerProfileRepo>()));
    gh.factory<_i40.PrepareCustomerServisCreateForm>(() =>
        _i40.PrepareCustomerServisCreateForm(
            gh<_i23.BengkelProfileRepository>()));
    gh.factory<_i41.RegisterUserAccount>(
        () => _i41.RegisterUserAccount(gh<_i19.AuthenticationRepo>()));
    gh.factory<_i42.ServisRemoteDTS>(() => _i42.ServisRemoteDTSImpl(
          gh<_i15.ServisFirestoreDTS>(),
          gh<_i21.BengkelProfileFirestoreDTS>(),
          gh<_i27.CustomerProfileFirestoreDTS>(),
          gh<_i7.JenisLayananFirestoreDTS>(),
        ));
    gh.factory<_i43.ServisRepo>(
        () => _i44.ServisRepoImpl(gh<_i42.ServisRemoteDTS>()));
    gh.lazySingleton<_i45.SessionCubit>(
        () => _i45.SessionCubit(gh<_i37.Logout>()));
    gh.factory<_i46.SplashCubit>(
        () => _i46.SplashCubit(gh<_i33.GetCurrentSession>()));
    gh.factory<_i47.BengkelListCubit>(
        () => _i47.BengkelListCubit(gh<_i31.GetAllBengkel>()));
    gh.factoryParam<_i48.BengkelProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i48.BengkelProfileFormCubit(
          gh<_i38.PrepareBengkelProfileForm>(),
          userId,
          gh<_i26.CreateBengkelProfile>(),
        ));
    gh.factory<_i49.CheckIfCustomerHasProfile>(
        () => _i49.CheckIfCustomerHasProfile(
              gh<_i29.CustomerProfileRepo>(),
              gh<_i19.AuthenticationRepo>(),
            ));
    gh.factory<_i50.CreateOrUpdateCustomer>(
        () => _i50.CreateOrUpdateCustomer(gh<_i29.CustomerProfileRepo>()));
    gh.factory<_i51.CreateOrUpdateServis>(
        () => _i51.CreateOrUpdateServis(gh<_i43.ServisRepo>()));
    gh.factoryParam<_i52.CustomerProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i52.CustomerProfileFormCubit(
          gh<_i39.PrepareCustomerForm>(),
          userId,
          gh<_i50.CreateOrUpdateCustomer>(),
        ));
    gh.factory<_i53.GetServisList>(
        () => _i53.GetServisList(gh<_i43.ServisRepo>()));
    gh.factory<_i54.PrepareCustomerServisEditForm>(
        () => _i54.PrepareCustomerServisEditForm(
              gh<_i23.BengkelProfileRepository>(),
              gh<_i43.ServisRepo>(),
            ));
    gh.factory<_i55.RegisterCubit>(() => _i55.RegisterCubit(
          gh<_i12.MessengerCubit>(),
          gh<_i41.RegisterUserAccount>(),
        ));
    gh.factory<_i56.ServisListCubit>(
        () => _i56.ServisListCubit(gh<_i53.GetServisList>()));
    gh.factory<_i57.CustomerServisFormCubit>(() => _i57.CustomerServisFormCubit(
          gh<_i54.PrepareCustomerServisEditForm>(),
          gh<_i40.PrepareCustomerServisCreateForm>(),
          gh<_i51.CreateOrUpdateServis>(),
        ));
    return this;
  }
}

class _$CoreModules extends _i58.CoreModules {}
