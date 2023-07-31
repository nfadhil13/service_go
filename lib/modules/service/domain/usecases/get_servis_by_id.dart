import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class GetServisById extends Usecase<String, ServisDetail> {
  final ServisRepo _repo;

  GetServisById(this._repo);

  @override
  Future<Resource<ServisDetail>> execute(String params) =>
      _repo.getServisDetailById(params).asResource;
}
