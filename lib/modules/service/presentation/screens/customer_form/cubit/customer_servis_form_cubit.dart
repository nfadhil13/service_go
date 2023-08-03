import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/widgets/form/date_time_picker.dart';
import 'package:service_go/infrastructure/widgets/form/multi_select.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/craete_or_update_customer.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';
import 'package:service_go/modules/service/domain/usecases/create_or_update_servis.dart';
import 'package:service_go/modules/service/domain/usecases/prepare_customer_servis_create_form.dart';
import 'package:service_go/modules/service/domain/usecases/prepare_customer_servis_form.dart';
import 'package:service_go/modules/service/presentation/screens/customer_form/customer_servis_form_screen.dart';

part 'customer_servis_form_state.dart';

@injectable
class CustomerServisFormCubit extends Cubit<CustomerServisFormState> {
  // Usecases
  final PrepareCustomerServisEditForm _prepareEditForm;
  final PrepareCustomerServisCreateForm _prepareCreateForm;
  final CreateOrUpdateServis _createOrUpdateServis;

  //Form Items
  final GlobalKey<FormState> form = GlobalKey();
  final namaMotor = TextEditingController();
  final platNomor = TextEditingController();
  final layanan = SGMultiSelectFieldController<JenisLayanan>();
  final tanggal = SGDateTimeController();
  final catatan = TextEditingController();

  CustomerServisFormCubit(this._prepareEditForm, this._prepareCreateForm,
      this._createOrUpdateServis)
      : super(CustomerServisFormPrepareLoading());

  void init(CustomerServisFormScreenMode mode) async {
    switch (mode) {
      case CustomerServisFormEdit():
        prepareEditData(mode.servisId);
      case CustomerServisFormCreate():
        prepareCreateData(
            bengkelId: mode.bengkelId, bengkelProfile: mode.bengkelProfile);
    }
  }

  void prepareEditData(String servisId) async {
    emit(CustomerServisFormPrepareLoading());
    final usecase = await _prepareEditForm(servisId);
    switch (usecase) {
      case Success():
        final data = usecase.data;
        emit(CustomerServisReadyIdle(
            bengkelProfile: data.bengkelProfile, servis: data.servis));
      case Error():
        emit(CustomerServisFormPrepareError(usecase.exception.message));
    }
  }

  void prepareCreateData({
    required String bengkelId,
    BengkelProfile? bengkelProfile,
  }) async {
    if (bengkelProfile != null) {
      emit(CustomerServisReadyIdle(
          bengkelProfile: bengkelProfile, servis: null));
      return;
    }
    emit(CustomerServisFormPrepareLoading());
    final usecase = await _prepareCreateForm(bengkelId);
    switch (usecase) {
      case Success():
        emit(CustomerServisReadyIdle(
            bengkelProfile: usecase.data, servis: null));
      case Error():
        emit(CustomerServisFormPrepareError(usecase.exception.message));
    }
  }

  void submit(String customerId) async {
    final state = this.state;
    if (state is! CustomerServisFormPrepareSuccess) return;
    final newServis = getValue(
        bengkelProfile: state.bengkelProfile,
        customerId: customerId,
        oldServis: state.servis);
    if (newServis == null) return;
    emit(CustomerServisReadyLoading(
        bengkelProfile: state.bengkelProfile, servis: state.servis));
    final result = await _createOrUpdateServis(newServis);
    switch (result) {
      case Success():
        emit(CustomerServisReadySuccess(
            bengkelProfile: state.bengkelProfile,
            servis: state.servis,
            successServis: result.data));
      case Error():
        emit(CustomerServisReadyError(
            bengkelProfile: state.bengkelProfile,
            message: result.exception.message));
    }
  }

  Servis? getValue(
      {Servis? oldServis,
      required BengkelProfile bengkelProfile,
      required String customerId}) {
    final isValid = form.currentState?.validate();
    if (isValid != true) return null;
    return Servis(
        waktuMulaiPengerjaan: null,
        keteranganServis: null,
        namaMotor: namaMotor.text,
        platNomor: platNomor.text,
        statusData: oldServis?.statusData ?? ServisStatusDiajukan(),
        layanan: layanan.value,
        catatan: oldServis?.catatan ?? catatan.text,
        customer: oldServis?.customer ?? ServisCustomer(customerId, ""),
        bengkel: oldServis?.bengkel ??
            ServisBengkel(bengkelProfile.id, bengkelProfile.nama),
        tanggalService: tanggal.value!);
  }

  @override
  Future<void> close() {
    namaMotor.dispose();
    platNomor.dispose();
    layanan.dispose();
    tanggal.dispose();
    catatan.dispose();
    return super.close();
  }
}
