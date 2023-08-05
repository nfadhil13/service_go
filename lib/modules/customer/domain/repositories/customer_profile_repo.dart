import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';

abstract class CustomerProfileRepo {
  Future<CustomerProfile?> getCustomerByUserId(String userId);
  Future<CustomerProfile> createOrUpdatCustomer(
      CustomerProfile customerProfile);
  Future<int> count({SGDataQuery? query});
}
