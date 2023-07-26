import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class PrepareCustomerServisEditForm
    extends Usecase<String, ({BengkelProfile bengkelProfile, Servis servis})> {
  final BengkelProfileRepository _bengkelRepo;
  final ServisRepo _servisRepo;

  PrepareCustomerServisEditForm(this._bengkelRepo, this._servisRepo);

  @override
  Future<Resource<({BengkelProfile bengkelProfile, Servis servis})>> execute(
      String params) async {
    final servis = await _servisRepo.getServisById(params);
    if (servis == null) throw const BaseException("Servis Not Found");
    final bengkel = await _bengkelRepo.getBengkelProfile(servis.bengkel.id);
    if (bengkel == null) throw const BaseException("Bengkel Not Found");
    return Resource.success((bengkelProfile: bengkel, servis: servis));
  }
}
