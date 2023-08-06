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
import 'package:firebase_messaging/firebase_messaging.dart' as _i6;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/authentication/data/datasource/local/authentication_local_dts.dart'
    as _i25;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i26;
import '../../modules/authentication/data/datasource/remote/user_data_remote_dts.dart'
    as _i24;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i28;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i27;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i44;
import '../../modules/authentication/domain/usecases/login.dart' as _i48;
import '../../modules/authentication/domain/usecases/logout.dart' as _i50;
import '../../modules/authentication/domain/usecases/register.dart' as _i55;
import '../../modules/authentication/presentation/screens/login/cubit/login_cubit.dart'
    as _i49;
import '../../modules/authentication/presentation/screens/register/cubit/register_cubit.dart'
    as _i79;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i62;
import '../../modules/bengkel/data/datasource/firestore/bengkel_firestore_dts.dart'
    as _i29;
import '../../modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart'
    as _i9;
import '../../modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart'
    as _i30;
import '../../modules/bengkel/data/datasource/remote/jenis_layanan_remote_dts.dart'
    as _i10;
import '../../modules/bengkel/data/repositories/bengkel_profile_repository_impl.dart'
    as _i32;
import '../../modules/bengkel/data/repositories/jenis_layanan_repository.dart'
    as _i12;
import '../../modules/bengkel/domain/repositories/bengkel_profile_repository.dart'
    as _i31;
import '../../modules/bengkel/domain/repositories/jenis_layanan_repository.dart'
    as _i11;
import '../../modules/bengkel/domain/usecase/create_new_jenis_layanan.dart'
    as _i35;
import '../../modules/bengkel/domain/usecase/get_all_bengkel.dart' as _i40;
import '../../modules/bengkel/domain/usecase/get_all_jenis_layanan.dart'
    as _i42;
import '../../modules/bengkel/domain/usecase/get_jadwal_bengkel.dart' as _i46;
import '../../modules/bengkel/domain/usecase/update_jadwal_bengkel.dart'
    as _i63;
import '../../modules/bengkel/presentation/cubits/bengkel_list/bengkel_list_cubit.dart'
    as _i66;
import '../../modules/bengkel/presentation/screens/admin_jenis_layanan/cubit/admin_jenis_layanan_cubit.dart'
    as _i65;
import '../../modules/bengkel/presentation/screens/jadwal_bengkel/cubit/jadwal_bengkel_cubit.dart'
    as _i76;
import '../../modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart'
    as _i36;
import '../../modules/customer/data/datasource/remote/customer_profile_remote_dts.dart'
    as _i37;
import '../../modules/customer/data/repositories/customer_profile_repo_impl.dart'
    as _i39;
import '../../modules/customer/domain/repositories/customer_profile_repo.dart'
    as _i38;
import '../../modules/customer/domain/usecases/get_all_customer.dart' as _i41;
import '../../modules/customer/presentation/screens/cubit/admin_customer_list_cubit.dart'
    as _i64;
import '../../modules/home/domain/usecases/prerpare_admin_home.dart' as _i77;
import '../../modules/home/presentation/screens/admin/cubit/admin_home_screen_cubit.dart'
    as _i82;
import '../../modules/profile/domain/usecase/bengkel/check_is_bengkel_has_profile.dart'
    as _i33;
import '../../modules/profile/domain/usecase/bengkel/create_bengkel_profile.dart'
    as _i34;
import '../../modules/profile/domain/usecase/bengkel/get_customer_profile.dart'
    as _i43;
import '../../modules/profile/domain/usecase/bengkel/prepare_bengkel_profile_form.dart'
    as _i51;
import '../../modules/profile/domain/usecase/customer/check_if_customer_has_profile.dart'
    as _i69;
import '../../modules/profile/domain/usecase/customer/craete_or_update_customer.dart'
    as _i70;
import '../../modules/profile/domain/usecase/customer/get_customer_profile.dart'
    as _i45;
import '../../modules/profile/domain/usecase/customer/prepare_customer_form.dart'
    as _i52;
import '../../modules/profile/presentation/screens/bengkel_profile/cubit/bengkel_profile_cubit.dart'
    as _i68;
import '../../modules/profile/presentation/screens/bengkel_profile_form/cubit/form/bengkel_profile_form_cubit.dart'
    as _i67;
import '../../modules/profile/presentation/screens/customer_profile/cubit/customer_profile_cubit.dart'
    as _i73;
import '../../modules/profile/presentation/screens/customer_profile_form/cubit/customer_profile_form_cubit.dart'
    as _i72;
import '../../modules/service/data/datasource/firestore/servis_firestore_dts.dart'
    as _i18;
import '../../modules/service/data/datasource/firestore/servis_status_firestore_dts.dart'
    as _i22;
import '../../modules/service/data/datasource/remote/servis_remote_dts.dart'
    as _i58;
import '../../modules/service/data/datasource/remote/servis_status_remote_dts.dart'
    as _i23;
import '../../modules/service/data/repositories/servis_notif_repo_impl.dart'
    as _i57;
import '../../modules/service/data/repositories/servis_repository_impl.dart'
    as _i60;
import '../../modules/service/domain/repositories/servis_notif_repo.dart'
    as _i56;
import '../../modules/service/domain/repositories/servis_repository.dart'
    as _i59;
import '../../modules/service/domain/usecases/create_or_update_servis.dart'
    as _i71;
import '../../modules/service/domain/usecases/get_servis_by_id.dart' as _i74;
import '../../modules/service/domain/usecases/get_servis_list.dart' as _i75;
import '../../modules/service/domain/usecases/prepare_customer_servis_create_form.dart'
    as _i53;
import '../../modules/service/domain/usecases/prepare_customer_servis_form.dart'
    as _i78;
import '../../modules/service/presentation/cubits/detail/servis_detail_cubit.dart'
    as _i80;
import '../../modules/service/presentation/cubits/servis_list/servis_list_cubit.dart'
    as _i81;
import '../../modules/service/presentation/screens/customer_form/cubit/customer_servis_form_cubit.dart'
    as _i83;
import '../../modules/service/presentation/screens/list/cubit/servis_list_filter_cubit.dart'
    as _i19;
import '../../modules/service/presentation/screens/list/servist_list_screen.dart'
    as _i21;
import '../architecutre/cubits/location/location_cubit.dart' as _i47;
import '../architecutre/cubits/messenger/messenger_cubit.dart' as _i14;
import '../architecutre/cubits/session/session_cubit.dart' as _i61;
import '../local_storage/secure_storage/secure_storage.dart' as _i17;
import '../types/query.dart' as _i20;
import '../utils/firebase_messanger_util.dart' as _i5;
import '../utils/location/location_util.dart' as _i13;
import '../utils/notification/notification_service.dart' as _i15;
import '../utils/notification/push_notification_util.dart' as _i54;
import '../utils/storage/sg_storage_helper.dart' as _i16;
import 'modules/core_module.dart' as _i84;

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
    gh.factory<_i5.FirebaseHelper>(() => _i5.FirebaseHelper());
    gh.singleton<_i6.FirebaseMessaging>(coreModules.getFirebaseMessaging());
    gh.singleton<_i7.FirebaseStorage>(coreModules.getFirebaseStorage());
    gh.factory<_i8.FlutterSecureStorage>(
        () => coreModules.getFlutterSecureStorage());
    gh.factory<_i9.JenisLayananFirestoreDTS>(
        () => _i9.JenisLayananFirestoreDTS(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i10.JenisLayananRemoteDTS>(() =>
        _i10.JenisLayananRemoteDTSImpl(gh<_i9.JenisLayananFirestoreDTS>()));
    gh.factory<_i11.JenisLayananRepository>(() =>
        _i12.JenisLayananRepositoryImpl(gh<_i10.JenisLayananRemoteDTS>()));
    gh.factory<_i13.LocationUtil>(() => _i13.LocationUtilImpl());
    gh.lazySingleton<_i14.MessengerCubit>(() => _i14.MessengerCubit());
    gh.factory<_i15.NotificationService>(() => _i15.NotificationService());
    gh.factory<_i16.SGStorageHelper>(
        () => _i16.SGStorageHelperImpl(gh<_i7.FirebaseStorage>()));
    gh.factory<_i17.SecureStorage>(
        () => _i17.SecureStorageImpl(gh<_i8.FlutterSecureStorage>()));
    gh.factory<_i18.ServisFirestoreDTS>(() => _i18.ServisFirestoreDTS(
          gh<_i4.FirebaseFirestore>(),
          gh<_i7.FirebaseStorage>(),
        ));
    gh.factoryParam<_i19.ServisListFilterCubit, _i20.SGDataQuery?,
        _i21.ServisListType?>((
      initialQuery,
      type,
    ) =>
        _i19.ServisListFilterCubit(
          initialQuery,
          type,
        ));
    gh.factory<_i22.ServisStatusFirestoreDTS>(
        () => _i22.ServisStatusFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i7.FirebaseStorage>(),
            ));
    gh.factory<_i23.ServisStatusRemoteDTS>(() => _i23.ServisStatusRemoteDTSImpl(
          gh<_i22.ServisStatusFirestoreDTS>(),
          gh<_i16.SGStorageHelper>(),
        ));
    gh.factory<_i24.UserDataRemoteDTS>(
        () => _i24.UserDataRemoteDTSImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i25.AuthenticationLocalDTS>(() => _i25.AuthLocalDTSImpl(
          gh<_i17.SecureStorage>(),
          gh<_i3.FirebaseAuth>(),
        ));
    gh.factory<_i26.AuthenticationRemoteDTS>(
        () => _i26.AuthenticationRemoteDTSImpl(gh<_i3.FirebaseAuth>()));
    gh.factory<_i27.AuthenticationRepo>(() => _i28.AuthenticationRepoImpl(
          gh<_i26.AuthenticationRemoteDTS>(),
          gh<_i25.AuthenticationLocalDTS>(),
          gh<_i24.UserDataRemoteDTS>(),
          gh<_i6.FirebaseMessaging>(),
        ));
    gh.factory<_i29.BengkelProfileFirestoreDTS>(
        () => _i29.BengkelProfileFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i7.FirebaseStorage>(),
            ));
    gh.factory<_i30.BengkelProfileRemoteDTS>(
        () => _i30.BengkelProfileRemoteDTSImpl(
              gh<_i29.BengkelProfileFirestoreDTS>(),
              gh<_i9.JenisLayananFirestoreDTS>(),
              gh<_i16.SGStorageHelper>(),
            ));
    gh.factory<_i31.BengkelProfileRepository>(() =>
        _i32.BengkelProfileRepositoryImpl(gh<_i30.BengkelProfileRemoteDTS>()));
    gh.factory<_i33.CheckIfBengkelHasProfile>(
        () => _i33.CheckIfBengkelHasProfile(
              gh<_i31.BengkelProfileRepository>(),
              gh<_i27.AuthenticationRepo>(),
            ));
    gh.factory<_i34.CreateBengkelProfile>(
        () => _i34.CreateBengkelProfile(gh<_i31.BengkelProfileRepository>()));
    gh.factory<_i35.CreateOrUpdateJenisLayanan>(() =>
        _i35.CreateOrUpdateJenisLayanan(gh<_i11.JenisLayananRepository>()));
    gh.factory<_i36.CustomerProfileFirestoreDTS>(
        () => _i36.CustomerProfileFirestoreDTS(
              gh<_i4.FirebaseFirestore>(),
              gh<_i7.FirebaseStorage>(),
            ));
    gh.factory<_i37.CustomerProfileRemoteDTS>(() =>
        _i37.CustomerProfileRemoteDTSImpl(
            gh<_i36.CustomerProfileFirestoreDTS>()));
    gh.factory<_i38.CustomerProfileRepo>(() =>
        _i39.CustomerProfileRepoImpl(gh<_i37.CustomerProfileRemoteDTS>()));
    gh.factory<_i40.GetAllBengkel>(
        () => _i40.GetAllBengkel(gh<_i31.BengkelProfileRepository>()));
    gh.factory<_i41.GetAllCustomer>(
        () => _i41.GetAllCustomer(gh<_i38.CustomerProfileRepo>()));
    gh.factory<_i42.GetAllJenisLayanan>(
        () => _i42.GetAllJenisLayanan(gh<_i11.JenisLayananRepository>()));
    gh.factory<_i43.GetBengkelProfile>(
        () => _i43.GetBengkelProfile(gh<_i31.BengkelProfileRepository>()));
    gh.factory<_i44.GetCurrentSession>(
        () => _i44.GetCurrentSession(gh<_i27.AuthenticationRepo>()));
    gh.factory<_i45.GetCustomerProfile>(
        () => _i45.GetCustomerProfile(gh<_i38.CustomerProfileRepo>()));
    gh.factory<_i46.GetJadwalBengkel>(
        () => _i46.GetJadwalBengkel(gh<_i31.BengkelProfileRepository>()));
    gh.factory<_i47.InitialLocationCubit>(
        () => _i47.InitialLocationCubit(gh<_i13.LocationUtil>()));
    gh.factory<_i48.Login>(() => _i48.Login(gh<_i27.AuthenticationRepo>()));
    gh.factory<_i49.LoginCubit>(() => _i49.LoginCubit(gh<_i48.Login>()));
    gh.factory<_i50.Logout>(() => _i50.Logout(gh<_i27.AuthenticationRepo>()));
    gh.factory<_i51.PrepareBengkelProfileForm>(
        () => _i51.PrepareBengkelProfileForm(
              gh<_i11.JenisLayananRepository>(),
              gh<_i31.BengkelProfileRepository>(),
            ));
    gh.factory<_i52.PrepareCustomerForm>(
        () => _i52.PrepareCustomerForm(gh<_i38.CustomerProfileRepo>()));
    gh.factory<_i53.PrepareCustomerServisCreateForm>(() =>
        _i53.PrepareCustomerServisCreateForm(
            gh<_i31.BengkelProfileRepository>()));
    gh.factory<_i54.PushNotificationUtil>(
        () => _i54.PushNotificationUtilImpl(gh<_i24.UserDataRemoteDTS>()));
    gh.factory<_i55.RegisterUserAccount>(
        () => _i55.RegisterUserAccount(gh<_i27.AuthenticationRepo>()));
    gh.factory<_i56.ServisNotifRepo>(
        () => _i57.ServisNotifRepoImpl(gh<_i54.PushNotificationUtil>()));
    gh.factory<_i58.ServisRemoteDTS>(() => _i58.ServisRemoteDTSImpl(
          gh<_i18.ServisFirestoreDTS>(),
          gh<_i29.BengkelProfileFirestoreDTS>(),
          gh<_i36.CustomerProfileFirestoreDTS>(),
          gh<_i9.JenisLayananFirestoreDTS>(),
          gh<_i23.ServisStatusRemoteDTS>(),
        ));
    gh.factory<_i59.ServisRepo>(
        () => _i60.ServisRepoImpl(gh<_i58.ServisRemoteDTS>()));
    gh.lazySingleton<_i61.SessionCubit>(
        () => _i61.SessionCubit(gh<_i50.Logout>()));
    gh.factory<_i62.SplashCubit>(
        () => _i62.SplashCubit(gh<_i44.GetCurrentSession>()));
    gh.factory<_i63.UpdateJadwalBengkel>(
        () => _i63.UpdateJadwalBengkel(gh<_i31.BengkelProfileRepository>()));
    gh.factory<_i64.AdminCustomerListCubit>(
        () => _i64.AdminCustomerListCubit(gh<_i41.GetAllCustomer>()));
    gh.factory<_i65.AdminJenisLayananCubit>(() => _i65.AdminJenisLayananCubit(
          gh<_i42.GetAllJenisLayanan>(),
          gh<_i35.CreateOrUpdateJenisLayanan>(),
          gh<_i14.MessengerCubit>(),
        ));
    gh.factory<_i66.BengkelListCubit>(
        () => _i66.BengkelListCubit(gh<_i40.GetAllBengkel>()));
    gh.factoryParam<_i67.BengkelProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i67.BengkelProfileFormCubit(
          gh<_i51.PrepareBengkelProfileForm>(),
          userId,
          gh<_i34.CreateBengkelProfile>(),
        ));
    gh.factory<_i68.BengkelProfileScreenCubit>(
        () => _i68.BengkelProfileScreenCubit(gh<_i43.GetBengkelProfile>()));
    gh.factory<_i69.CheckIfCustomerHasProfile>(
        () => _i69.CheckIfCustomerHasProfile(
              gh<_i38.CustomerProfileRepo>(),
              gh<_i27.AuthenticationRepo>(),
            ));
    gh.factory<_i70.CreateOrUpdateCustomer>(
        () => _i70.CreateOrUpdateCustomer(gh<_i38.CustomerProfileRepo>()));
    gh.factory<_i71.CreateOrUpdateServis>(() => _i71.CreateOrUpdateServis(
          gh<_i59.ServisRepo>(),
          gh<_i56.ServisNotifRepo>(),
        ));
    gh.factoryParam<_i72.CustomerProfileFormCubit, String, dynamic>((
      userId,
      _,
    ) =>
        _i72.CustomerProfileFormCubit(
          gh<_i52.PrepareCustomerForm>(),
          userId,
          gh<_i70.CreateOrUpdateCustomer>(),
        ));
    gh.factory<_i73.CustomerProfileScreenCubit>(
        () => _i73.CustomerProfileScreenCubit(gh<_i45.GetCustomerProfile>()));
    gh.factory<_i74.GetServisById>(
        () => _i74.GetServisById(gh<_i59.ServisRepo>()));
    gh.factory<_i75.GetServisList>(
        () => _i75.GetServisList(gh<_i59.ServisRepo>()));
    gh.factory<_i76.JadwalBengkelCubit>(() => _i76.JadwalBengkelCubit(
          gh<_i14.MessengerCubit>(),
          gh<_i46.GetJadwalBengkel>(),
          gh<_i63.UpdateJadwalBengkel>(),
        ));
    gh.factory<_i77.PrepareAdminHome>(() => _i77.PrepareAdminHome(
          gh<_i31.BengkelProfileRepository>(),
          gh<_i38.CustomerProfileRepo>(),
          gh<_i59.ServisRepo>(),
          gh<_i11.JenisLayananRepository>(),
        ));
    gh.factory<_i78.PrepareCustomerServisEditForm>(
        () => _i78.PrepareCustomerServisEditForm(
              gh<_i31.BengkelProfileRepository>(),
              gh<_i59.ServisRepo>(),
            ));
    gh.factory<_i79.RegisterCubit>(() => _i79.RegisterCubit(
          gh<_i14.MessengerCubit>(),
          gh<_i55.RegisterUserAccount>(),
        ));
    gh.factory<_i80.ServisDetailCubit>(() => _i80.ServisDetailCubit(
          gh<_i74.GetServisById>(),
          gh<_i71.CreateOrUpdateServis>(),
          gh<_i14.MessengerCubit>(),
        ));
    gh.factory<_i81.ServisListCubit>(
        () => _i81.ServisListCubit(gh<_i75.GetServisList>()));
    gh.factory<_i82.AdminHomeScreenCubit>(
        () => _i82.AdminHomeScreenCubit(gh<_i77.PrepareAdminHome>()));
    gh.factory<_i83.CustomerServisFormCubit>(() => _i83.CustomerServisFormCubit(
          gh<_i78.PrepareCustomerServisEditForm>(),
          gh<_i53.PrepareCustomerServisCreateForm>(),
          gh<_i71.CreateOrUpdateServis>(),
        ));
    return this;
  }
}

class _$CoreModules extends _i84.CoreModules {}
