import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/exceptions/form_exception.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/widgets/form/dropdown.dart';
import 'package:service_go/modules/authentication/domain/model/user_register_data.dart';
import 'package:service_go/modules/authentication/domain/model/user_type.dart';
import 'package:service_go/modules/authentication/domain/usecases/register.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserAccount _registerUserAccount;
  final MessengerCubit messengerCubit;
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final SGDropdownController<bool?> isBengkel = SGDropdownController();
  final GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> errors = {};

  RegisterCubit(
    this.messengerCubit,
    this._registerUserAccount,
  ) : super(RegisterIdle());

  void register() async {
    final userData = getDataIfValid();
    if (userData == null) return;
    emit(RegisterLoading());
    final result = await _registerUserAccount(userData);
    switch (result) {
      case Success():
        emit(RegisterSuccess(userData.email));
      case Error(exception: BaseException exception):
        if (exception is FormException) {
          _addErrorAndValidate(exception.errors);
        } else {
          messengerCubit.showErrorSnackbar(exception.message);
        }
        emit(RegisterIdle());
    }
  }

  UserRegisterData? getDataIfValid() {
    if (formKey.currentState?.validate() != true) return null;
    if (password.text != confirmPassword.text) {
      _addErrorAndValidate({"confirmPassword": "Password tidak sesuai"});
      return null;
    }
    return UserRegisterData(
        username: username.text,
        email: email.text,
        password: password.text,
        isBengkel: isBengkel.value! ? UserType.bengkel : UserType.customer);
  }

  void _addErrorAndValidate(Map<String, dynamic> newErrors) {
    errors = newErrors;
    formKey.currentState?.validate();
    errors = {};
  }

  @override
  Future<void> close() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    isBengkel.dispose();
    return super.close();
  }
}
