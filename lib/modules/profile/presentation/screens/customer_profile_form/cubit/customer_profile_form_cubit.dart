import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/craete_or_update_customer.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/prepare_customer_form.dart';

part 'customer_profile_form_state.dart';

@injectable
class CustomerProfileFormCubit extends Cubit<CustomerProfileFormState> {
  final String userId;

  //Form
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController nomorTelepon = TextEditingController();

  //Usecase
  final PrepareCustomerForm _prepareCustomerForm;
  final CreateOrUpdateCustomer _craeteOrUpdateCustomer;
  CustomerProfileFormCubit(this._prepareCustomerForm, @factoryParam this.userId,
      this._craeteOrUpdateCustomer)
      : super(CustomerProfileFormPrepareLoading());

  void prepareForm() async {
    emit(CustomerProfileFormPrepareLoading());
    final result = await _prepareCustomerForm((userId,));
    switch (result) {
      case Success():
        name.text = result.data?.nama ?? "";
        nomorTelepon.text = result.data?.phoneNumber ?? "";
        emit(CustomerProfileFormIdle(result.data));
      case Error():
        emit(CustomerProfileFormPrepareError(
            result.exception.message, prepareForm));
    }
  }

  void submit() async {
    final state = this.state;
    if (state is! CustomerProfileFormIdle) return;
    final value = customerProfile();
    if (value == null) return;
    final result = await _craeteOrUpdateCustomer(value);
    switch (result) {
      case Success():
        emit(CustomerProfileFormSubmitSuccess(state.customerProfile, value));
      case Error():
        emit(CustomerProfileFormSubmitError(state.customerProfile));
    }
  }

  CustomerProfile? customerProfile() {
    final isValid = formKey.currentState?.validate();
    if (isValid != true) return null;
    return CustomerProfile(
        nama: name.text, phoneNumber: nomorTelepon.text, id: userId);
  }

  @override
  Future<void> close() {
    name.dispose();
    nomorTelepon.dispose();
    return super.close();
  }
}
