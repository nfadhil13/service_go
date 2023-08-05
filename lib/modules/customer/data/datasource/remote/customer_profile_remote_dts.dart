import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';

abstract class CustomerProfileRemoteDTS {
  Future<CustomerProfile?> getByUserId(String userId);
  Future<void> putCustomer(CustomerProfile customerProfile);
  Future<int> count({SGDataQuery? query});
}

@Injectable(as: CustomerProfileRemoteDTS)
class CustomerProfileRemoteDTSImpl implements CustomerProfileRemoteDTS {
  final CustomerProfileFirestoreDTS _firestoreDTS;

  CustomerProfileRemoteDTSImpl(this._firestoreDTS);

  @override
  Future<CustomerProfile?> getByUserId(String userId) =>
      _firestoreDTS.fetchOne(userId);

  @override
  Future<void> putCustomer(CustomerProfile customerProfile) =>
      _firestoreDTS.put(customerProfile, customerProfile.id);

  @override
  Future<int> count({SGDataQuery? query}) => _firestoreDTS.count(query: query);
}
