part of 'bengkel_profile_cubit.dart';

sealed class BengkelProfileScreenState extends Equatable {
  const BengkelProfileScreenState();

  @override
  List<Object> get props => [];
}

class BengkelProfileScreenLoading extends BengkelProfileScreenState {}

class BengkelProfileScreenSuccess extends BengkelProfileScreenState {
  final BengkelProfile bengkelProfile;

  const BengkelProfileScreenSuccess(this.bengkelProfile);

  @override
  List<Object> get props => [bengkelProfile];
}

class BengkelProfileScreenError extends BengkelProfileScreenState {
  final void Function() refresh;
  final String message;

  const BengkelProfileScreenError(this.message, this.refresh);
}
