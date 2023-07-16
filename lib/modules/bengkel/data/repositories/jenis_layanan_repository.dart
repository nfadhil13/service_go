import 'package:injectable/injectable.dart';
import 'package:service_go/modules/bengkel/data/datasource/remote/jenis_layanan_remote_dts.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/bengkel/domain/repositories/jenis_layanan_repository.dart';

@Injectable(as: JenisLayananRepository)
class JenisLayananRepositoryImpl implements JenisLayananRepository {
  final JenisLayananRemoteDTS _jenisLayananRemoteDTS;

  JenisLayananRepositoryImpl(this._jenisLayananRemoteDTS);

  @override
  Future<List<JenisLayanan>> getAllJenisLayanan() =>
      _jenisLayananRemoteDTS.fetchAllJenisLayanan();
}
