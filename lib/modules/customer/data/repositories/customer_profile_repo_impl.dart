import 'package:injectable/injectable.dart';
import 'package:service_go/modules/customer/data/datasource/remote/customer_profile_remote_dts.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/domain/repositories/customer_profile_repo.dart';

@Injectable(as: CustomerProfileRepo)
class CustomerProfileRepoImpl implements CustomerProfileRepo {
  final CustomerProfileRemoteDTS _remoteDTS;

  CustomerProfileRepoImpl(this._remoteDTS);

  @override
  Future<CustomerProfile?> getCustomerByUserId(String userId) =>
      _remoteDTS.getByUserId(userId);

  @override
  Future<CustomerProfile> createOrUpdatCustomer(
      CustomerProfile customerProfile) async {
    await _remoteDTS.putCustomer(customerProfile);
    return customerProfile;
  }
}
