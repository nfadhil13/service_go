part of 'customer_servis_form_cubit.dart';

sealed class CustomerServisFormState extends Equatable {
  const CustomerServisFormState();

  @override
  List<Object> get props => [];
}

class CustomerServisFormPrepareLoading extends CustomerServisFormState {}

class CustomerServisFormPrepareError extends CustomerServisFormState {
  final String message;

  const CustomerServisFormPrepareError(this.message);
}

sealed class CustomerServisFormPrepareSuccess extends CustomerServisFormState {
  final BengkelProfile bengkelProfile;
  final Servis? servis;

  const CustomerServisFormPrepareSuccess(
      {required this.bengkelProfile, this.servis});
}

class CustomerServisReadyIdle extends CustomerServisFormPrepareSuccess {
  const CustomerServisReadyIdle({required super.bengkelProfile, super.servis});
}

class CustomerServisReadyLoading extends CustomerServisFormPrepareSuccess {
  const CustomerServisReadyLoading(
      {required super.bengkelProfile, super.servis});
}

class CustomerServisReadyError extends CustomerServisFormPrepareSuccess {
  final String message;
  const CustomerServisReadyError(
      {required super.bengkelProfile, super.servis, required this.message});
}

class CustomerServisReadySuccess extends CustomerServisFormPrepareSuccess {
  final Servis successServis;
  const CustomerServisReadySuccess(
      {required super.bengkelProfile,
      super.servis,
      required this.successServis});
}
