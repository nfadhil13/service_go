import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

abstract class JenisLayananRepository {
  Future<List<JenisLayanan>> getAllJenisLayanan();
}
