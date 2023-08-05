import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/domain/repositories/customer_profile_repo.dart';

@injectable
class GetCustomerProfile extends Usecase<(String userId,), CustomerProfile?> {
  final CustomerProfileRepo _customerProfileRepo;

  GetCustomerProfile(this._customerProfileRepo);

  @override
  Future<Resource<CustomerProfile?>> execute((String userId,) params) =>
      _customerProfileRepo.getCustomerByUserId(params.$1).asResource;
}
