import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/bengkel_profile/bengkel_profile_dto.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/bengkel_profile/bengkel_profile_firestore_entity.dart';

@injectable
class BengkelProfileFirestoreDTS extends FirestoreDatasource<BengkelProfileDTO,
    FireStoreMapper<BengkelProfileDTO>> {
  final FirebaseStorage firebaseStorage;

  BengkelProfileFirestoreDTS(
      FirebaseFirestore firebaseFirestore, this.firebaseStorage)
      : super(
            collection: FirestoreCollections.bengeklProfile,
            firestore: firebaseFirestore,
            mapper: BengkelProfileFirestoreEntity());
}
