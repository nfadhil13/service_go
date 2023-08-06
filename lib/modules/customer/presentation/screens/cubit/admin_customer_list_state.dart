part of 'admin_customer_list_cubit.dart';

sealed class AdminCustomerListState extends Equatable {
  const AdminCustomerListState();

  @override
  List<Object> get props => [];
}

class AdminCustomerListLoading extends AdminCustomerListState {}

class AdminCustomerListSuccess extends AdminCustomerListState {
  final List<CustomerProfile> customerList;

  const AdminCustomerListSuccess(this.customerList);
}

class AdminCustomerListError extends AdminCustomerListState {
  final String message;

  const AdminCustomerListError(this.message);
}
