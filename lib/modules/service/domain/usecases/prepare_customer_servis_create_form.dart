import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class PrepareCustomerServisCreateForm extends Usecase<String, BengkelProfile> {
  final BengkelProfileRepository _bengkelRepo;

  PrepareCustomerServisCreateForm(this._bengkelRepo);

  @override
  Future<Resource<BengkelProfile>> execute(String params) async {
    final bengkel = await _bengkelRepo.getBengkelProfile(params);
    if (bengkel == null) throw const BaseException("Bengkel Not Found");
    return Resource.success(bengkel);
  }
}
