import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/repositories/servis_notif_repo.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class CreateOrUpdateServis extends Usecase<Servis, Servis> {
  final ServisRepo _repo;
  final ServisNotifRepo _notifRepo;

  CreateOrUpdateServis(this._repo, this._notifRepo);

  @override
  Future<Resource<Servis>> execute(Servis params) async {
    final result = await _repo.putServis(params);
    _notifRepo.addNotif(result);
    return Resource.success(result);
  }
}
