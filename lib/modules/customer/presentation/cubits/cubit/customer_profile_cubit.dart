import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';

part 'customer_profile_state.dart';

class CustomerProfileCubit extends Cubit<CustomerProfile> {
  CustomerProfileCubit(super.initialState);

  void setValue(CustomerProfile profile) {
    emit(profile);
  }
}
