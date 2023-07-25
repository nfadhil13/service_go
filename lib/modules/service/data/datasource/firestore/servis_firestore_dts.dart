import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/service/data/mapper/servis/servis_firestore_entity.dart';
import 'package:service_go/modules/service/data/mapper/servis/servis_dto.dart';

@injectable
class ServisFirestoreDTS
    extends FirestoreDatasource<ServisDTO, FireStoreMapper<ServisDTO>> {
  final FirebaseStorage firebaseStorage;

  ServisFirestoreDTS(FirebaseFirestore firebaseFirestore, this.firebaseStorage)
      : super(
            collection: FirestoreCollections.servis,
            firestore: firebaseFirestore,
            mapper: ServisFirestoreEntity());
}
