part of 'customer_profile_form_cubit.dart';

sealed class CustomerProfileFormState extends Equatable {
  const CustomerProfileFormState();

  @override
  List<Object> get props => [];
}

class CustomerProfileFormPrepareLoading extends CustomerProfileFormState {}

class CustomerProfileFormPrepareError extends CustomerProfileFormState {
  final String message;
  final void Function() retry;

  const CustomerProfileFormPrepareError(this.message, this.retry);
}

sealed class CustomerProfileFormReady extends CustomerProfileFormState {
  final CustomerProfile? customerProfile;

  const CustomerProfileFormReady(this.customerProfile);
}

class CustomerProfileFormIdle extends CustomerProfileFormReady {
  const CustomerProfileFormIdle(super.customerProfile);
}

class CustomerProfileFormSubmitLoading extends CustomerProfileFormReady {
  const CustomerProfileFormSubmitLoading(super.customerProfile);
}

class CustomerProfileFormSubmitSuccess extends CustomerProfileFormReady {
  final CustomerProfile newProfile;
  const CustomerProfileFormSubmitSuccess(
      super.customerProfile, this.newProfile);
}

class CustomerProfileFormSubmitError extends CustomerProfileFormReady {
  const CustomerProfileFormSubmitError(super.customerProfile);
}
