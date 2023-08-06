import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/domain/usecases/get_all_customer.dart';

part 'admin_customer_list_state.dart';

@injectable
class AdminCustomerListCubit extends Cubit<AdminCustomerListState> {
  final GetAllCustomer _getAllCustomer;
  AdminCustomerListCubit(this._getAllCustomer)
      : super(AdminCustomerListLoading());

  void getAllCustomer({SGDataQuery? query}) async {
    emit(AdminCustomerListLoading());
    final result = await _getAllCustomer(query);
    switch (result) {
      case Success():
        emit(AdminCustomerListSuccess(result.data));
      case Error():
        emit(AdminCustomerListError(result.exception.message));
    }
  }
}
