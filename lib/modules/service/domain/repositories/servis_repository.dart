import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';

abstract class ServisRepo {
  Future<Servis> createServis(Servis servis);
  Future<Servis> putServis(Servis servis);
  Future<List<Servis>> getServisList({SGDataQuery? query});
  Future<Servis?> getServisById(String id);
}
