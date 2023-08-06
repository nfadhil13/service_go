import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/domain/repositories/customer_profile_repo.dart';

@injectable
class GetAllCustomer extends Usecase<SGDataQuery?, List<CustomerProfile>> {
  final CustomerProfileRepo _customerProfileRepo;

  GetAllCustomer(this._customerProfileRepo);

  @override
  Future<Resource<List<CustomerProfile>>> execute(SGDataQuery? params) =>
      _customerProfileRepo.getCutomerList(query: params).asResource;
}
