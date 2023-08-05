import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/profile/domain/usecase/customer/get_customer_profile.dart';

part 'customer_profile_state.dart';

@injectable
class CustomerProfileScreenCubit extends Cubit<CustomerProfileScreenState> {
  final GetCustomerProfile _getCustomerProfile;
  CustomerProfileScreenCubit(this._getCustomerProfile)
      : super(CustomerProfileScreenLoading());

  void setCustomer(CustomerProfile customerProfile) {
    emit(CustomerProfileScreenSuccess(customerProfile));
  }

  void getCustomerProfile(String userId) async {
    emit(CustomerProfileScreenLoading());
    final result = await _getCustomerProfile((userId,));
    switch (result) {
      case Success():
        final profile = result.data;
        if (profile == null) {
          emit(CustomerProfileScreenError(
              "Profile Not Found", () => getCustomerProfile(userId)));
          return;
        }
        emit(CustomerProfileScreenSuccess(profile));
      case Error():
        emit(CustomerProfileScreenError(
            result.exception.message, () => getCustomerProfile(userId)));
    }
  }
}
