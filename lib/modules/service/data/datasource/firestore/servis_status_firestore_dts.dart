import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/service/data/mapper/status/servis_status_dto.dart';
import 'package:service_go/modules/service/data/mapper/status/servis_status_firestore.dart';

@injectable
class ServisStatusFirestoreDTS extends FirestoreDatasource<ServisStatusDataDTO,
    FireStoreMapper<ServisStatusDataDTO>> {
  final FirebaseStorage firebaseStorage;

  ServisStatusFirestoreDTS(
      FirebaseFirestore firebaseFirestore, this.firebaseStorage)
      : super(
            collection: FirestoreCollections.servisLog,
            firestore: firebaseFirestore,
            mapper: ServisStatusFirestoreEntity());
}
