import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class GetServisList extends Usecase<SGDataQuery?, List<Servis>> {
  final ServisRepo _servisRepo;

  GetServisList(this._servisRepo);

  @override
  Future<Resource<List<Servis>>> execute(SGDataQuery? params) =>
      _servisRepo.getServisList(query: params).asResource;
}
