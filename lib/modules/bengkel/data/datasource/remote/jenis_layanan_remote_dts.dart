import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/jenis_layanan_firestore_entity.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

abstract class JenisLayananRemoteDTS {
  Future<List<JenisLayanan>> fetchAllJenisLayanan();
}

@Injectable(as: JenisLayananRemoteDTS)
class JenisLayananRemoteDTSImpl
    extends FirestoreDatasource<JenisLayanan, JenisLayananFirestoreEntity>
    implements JenisLayananRemoteDTS {
  JenisLayananRemoteDTSImpl({required super.firestore})
      : super(
          collection: FirestoreCollections.jenisLayanan,
          mapper: JenisLayananFirestoreEntity(),
        );

  @override
  Future<List<JenisLayanan>> fetchAllJenisLayanan() {
    return collectionRef
        .get()
        .map((value) => value.docs.map((e) => e.data()).toList());
  }
}
