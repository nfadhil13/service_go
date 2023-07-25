import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class CreateServis extends Usecase<Servis, Servis> {
  final ServisRepo _repo;

  CreateServis(this._repo);

  @override
  Future<Resource<Servis>> execute(Servis params) =>
      _repo.createServis(params).asResource;
}
