import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';

@injectable
class GetAllBengkel
    extends Usecase<SGDataQuery?, List<BengkelProfileWithDistance>> {
  final BengkelProfileRepository _repo;

  GetAllBengkel(this._repo);

  @override
  Future<Resource<List<BengkelProfileWithDistance>>> execute(
          SGDataQuery? params) =>
      _repo.getBengkelList(queryData: params).asResource;
}
