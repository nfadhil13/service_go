import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/service/data/datasource/remote/servis_remote_dts.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@Injectable(as: ServisRepo)
class ServisRepoImpl implements ServisRepo {
  final ServisRemoteDTS _servisRemoteDTS;

  ServisRepoImpl(this._servisRemoteDTS);

  @override
  Future<Servis> createServis(Servis servis) =>
      _servisRemoteDTS.createServis(servis);

  @override
  Future<Servis?> getServisById(String id) =>
      _servisRemoteDTS.getServisById(id);

  @override
  Future<List<Servis>> getServisList({SGDataQuery? query}) =>
      _servisRemoteDTS.getServisList(query);

  @override
  Future<Servis> putServis(Servis servis) => _servisRemoteDTS.putServis(servis);
}
