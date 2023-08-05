part of 'customer_profile_cubit.dart';

sealed class CustomerProfileScreenState extends Equatable {
  const CustomerProfileScreenState();

  @override
  List<Object> get props => [];
}

class CustomerProfileScreenLoading extends CustomerProfileScreenState {}

class CustomerProfileScreenSuccess extends CustomerProfileScreenState {
  final CustomerProfile customerProfile;

  const CustomerProfileScreenSuccess(this.customerProfile);

  @override
  List<Object> get props => [customerProfile];
}

class CustomerProfileScreenError extends CustomerProfileScreenState {
  final void Function() refresh;
  final String message;

  const CustomerProfileScreenError(this.message, this.refresh);
}
