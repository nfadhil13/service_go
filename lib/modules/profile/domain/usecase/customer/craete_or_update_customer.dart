import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/nothing.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/domain/repositories/customer_profile_repo.dart';

@injectable
class CraeteOrUpdateCustomer extends Usecase<CustomerProfile, Nothing> {
  final CustomerProfileRepo _customerProfileRepo;

  CraeteOrUpdateCustomer(this._customerProfileRepo);

  @override
  Future<Resource<Nothing>> execute(CustomerProfile params) =>
      _customerProfileRepo.createOrUpdatCustomer(params).asResourceOfNothing;
}
