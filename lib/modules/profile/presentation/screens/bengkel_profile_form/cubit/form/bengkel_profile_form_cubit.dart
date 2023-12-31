import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/widgets/form/image/image_picker.dart';
import 'package:service_go/infrastructure/widgets/form/map_field.dart';
import 'package:service_go/infrastructure/widgets/form/multi_select.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/profile/domain/usecase/bengkel/create_bengkel_profile.dart';
import 'package:service_go/modules/profile/domain/usecase/bengkel/prepare_bengkel_profile_form.dart';

part 'bengkel_profile_form_state.dart';

@injectable
class BengkelProfileFormCubit extends Cubit<BengkelProfileFormState> {
  final String userId;

  //Form
  final GlobalKey<FormState> formKey = GlobalKey();
  final SGImagePickerController profilePict = SGImagePickerController();
  final TextEditingController namaBengkel = TextEditingController();
  final TextEditingController nomorTelepon = TextEditingController();
  final SGMultiSelectFieldController<JenisLayanan> jenisLayanan =
      SGMultiSelectFieldController();
  final SGMapPickerFieldController lokasiBengkel = SGMapPickerFieldController();

  //Usecase
  final PrepareBengkelProfileForm _preparForm;
  final CreateBengkelProfile _createBengkelProfile;

  BengkelProfileFormCubit(
      this._preparForm, @factoryParam this.userId, this._createBengkelProfile)
      : super(BengkelProfileFormPrepareLoading());

  void prepareForm() async {
    emit(BengkelProfileFormPrepareLoading());
    final result = await _preparForm((userId,));
    switch (result) {
      case Success():
        final data = result.data;
        namaBengkel.text = data.bengkelProfile?.nama ?? "";
        nomorTelepon.text = data.bengkelProfile?.nomorTelepon ?? "";
        emit(BengkelProfileFormIdle(
            result.data.layananList, result.data.bengkelProfile));
      case Error():
        emit(BengkelProfileFormPrepareError(
            result.exception.message, prepareForm));
    }
  }

  void submit() async {
    final state = this.state;
    if (state is! BengkelProfileFormReady) return;
    final value = this.value;
    if (value == null) return;
    emit(BengkelProfileFormSubmitLoading(
        state.jenisLayanan, state.bengkelProfile));
    final result = await _createBengkelProfile(value);
    switch (result) {
      case Success():
        emit(BengkelProfileFormSubmitSuccess(
            state.jenisLayanan, state.bengkelProfile, result.data));
      case Error():
        emit(BengkelProfileFormSubmitError(
            state.jenisLayanan, state.bengkelProfile));
    }
  }

  BengkelProfile? get value {
    final isValid = formKey.currentState?.validate();
    if (isValid != true) return null;
    return BengkelProfile(
        profile: profilePict.value!,
        alamat: lokasiBengkel.value!.placemark,
        nama: namaBengkel.text,
        id: userId,
        jenisLayanan: jenisLayanan.value,
        isCurrentlyOpen: false,
        jadwalBengkel: const JadwalBengkel(),
        nomorTelepon: nomorTelepon.text,
        lokasi: lokasiBengkel.value!.latLgn);
  }

  // final SGImagePickerController profilePict = SGImagePickerController();
  // final TextEditingController namaBengkel = TextEditingController();
  // final TextEditingController nomorTelepon = TextEditingController();
  // final SGMultiSelectFieldController<JenisLayanan> jenisLayanan =
  //     SGMultiSelectFieldController();
  // final SGMapPickerFieldController lokasiBengkel = SGMapPickerFieldController();

  @override
  Future<void> close() {
    namaBengkel.dispose();
    nomorTelepon.dispose();
    jenisLayanan.dispose();
    lokasiBengkel.dispose();
    return super.close();
  }
}
