import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/widgets/form/map_field.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/profile/domain/usecase/prepare_bengkel_profile_form.dart';

part 'bengkel_profile_form_state.dart';

@injectable
class BengkelProfileFormCubit extends Cubit<BengkelProfileFormState> {
  final String userId;
  final TextEditingController namaBengkel = TextEditingController();
  final TextEditingController nomorTelepon = TextEditingController();
  final SGMapPickerFieldController lokasiBengkel = SGMapPickerFieldController();
  final PrepareBengkelProfileForm _preparForm;
  BengkelProfileFormCubit(this._preparForm, @factoryParam this.userId)
      : super(BengkelProfileFormPrepareLoading());

  void prepareForm() async {
    emit(BengkelProfileFormPrepareLoading());
    final result = await _preparForm((userId,));
    switch (result) {
      case Success():
        emit(BengkelProfileFormIdle(
            result.data.layananList, result.data.bengkelProfile));
      case Error():
        emit(BengkelProfileFormPrepareError(
            result.exception.message, prepareForm));
    }
  }
}
