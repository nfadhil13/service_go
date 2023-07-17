import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/jenis_layanan_firestore_entity.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

abstract class JenisLayananRemoteDTS {
  Future<List<JenisLayanan>> fetchAllJenisLayanan();
}

@Injectable(as: JenisLayananRemoteDTS)
class JenisLayananRemoteDTSImpl implements JenisLayananRemoteDTS {
  final JenisLayananFirestoreDTS _jenisLayananFirestore;
  JenisLayananRemoteDTSImpl(this._jenisLayananFirestore);

  @override
  Future<List<JenisLayanan>> fetchAllJenisLayanan() async {
    final result = await _jenisLayananFirestore.fetchAll();
    return _jenisLayananFirestore.fetchByIds(result.map((e) => e.id).toList());
  }
}
