part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterIdle extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String email;
  const RegisterSuccess(this.email);
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message);
}
