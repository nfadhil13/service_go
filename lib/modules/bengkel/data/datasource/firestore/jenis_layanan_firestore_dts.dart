import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/jenis_layanan_firestore_entity.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

@injectable
class JenisLayananFirestoreDTS
    extends FirestoreDatasource<JenisLayanan, FireStoreMapper<JenisLayanan>> {
  JenisLayananFirestoreDTS(FirebaseFirestore firebaseFirestore)
      : super(
            collection: FirestoreCollections.jenisLayanan,
            firestore: firebaseFirestore,
            mapper: JenisLayananFirestoreEntity());
}
