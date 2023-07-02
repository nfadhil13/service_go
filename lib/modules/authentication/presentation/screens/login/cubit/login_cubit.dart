import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/exceptions/form_exception.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';
import 'package:service_go/modules/authentication/domain/usecases/login.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final Login _login;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  LoginCubit(this._login) : super(LoginInIdle());

  void login() async {
    if (formKey.currentState?.validate() != true) return;
    emit(LoginLoading());
    final result =
        await _login(LoginParams(email: email.text, password: password.text));
    switch (result) {
      case Success(data: UserSession data):
        emit(LoginSuccess(data));
      case Error():
        final exception = result.exception;
        emit(LoginError(exception.message,
            errors: exception is FormException ? exception.errors : {}));
    }
  }

  void idle() async {
    emit(LoginInIdle());
  }

  String? formError(String key) {
    final state = this.state;
    if (state is LoginError) return state.errors[key];
    return null;
  }

  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    return super.close();
  }
}
