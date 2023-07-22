part of 'bengkel_profile_form_cubit.dart';

sealed class BengkelProfileFormState extends Equatable {
  const BengkelProfileFormState();

  @override
  List<Object> get props => [];
}

class BengkelProfileFormPrepareLoading extends BengkelProfileFormState {}

class BengkelProfileFormPrepareError extends BengkelProfileFormState {
  final String message;
  final void Function() retry;

  const BengkelProfileFormPrepareError(this.message, this.retry);
}

sealed class BengkelProfileFormReady extends BengkelProfileFormState {
  final List<JenisLayanan> jenisLayanan;
  final BengkelProfile? bengkelProfile;

  const BengkelProfileFormReady(this.jenisLayanan, this.bengkelProfile);
}

class BengkelProfileFormIdle extends BengkelProfileFormReady {
  const BengkelProfileFormIdle(super.jenisLayanan, super.bengkelProfile);
}

class BengkelProfileFormSubmitLoading extends BengkelProfileFormReady {
  const BengkelProfileFormSubmitLoading(
      super.jenisLayanan, super.bengkelProfile);
}

class BengkelProfileFormSubmitSuccess extends BengkelProfileFormReady {
  final BengkelProfile profile;
  const BengkelProfileFormSubmitSuccess(
      super.jenisLayanan, super.bengkelProfile, this.profile);
}

class BengkelProfileFormSubmitError extends BengkelProfileFormReady {
  const BengkelProfileFormSubmitError(super.jenisLayanan, super.bengkelProfile);
}
