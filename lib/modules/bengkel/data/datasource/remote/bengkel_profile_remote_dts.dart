import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/bengkel_profile_firestore_entity.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';

abstract class BengkelProfileRemoteDTS {
  Future<BengkelProfile?> fetchByUser(String userId);
  Future<BengkelProfile> put(BengkelProfile bengkelProfile);
}

@Injectable(as: BengkelProfileRemoteDTS)
class BengkelProfileRemoteDTSImpl
    extends FirestoreDatasource<BengkelProfile, BengkelProfileFirestoreEntity>
    implements BengkelProfileRemoteDTS {
  BengkelProfileRemoteDTSImpl(FirebaseFirestore firestore)
      : super(
            mapper: BengkelProfileFirestoreEntity(),
            collection: FirestoreCollections.bengeklProfile,
            firestore: firestore);

  @override
  Future<BengkelProfile?> fetchByUser(String userId) {
    return collectionRef.doc(userId).get().then((value) => value.data());
  }

  @override
  Future<BengkelProfile> put(BengkelProfile bengkelProfile) async {
    await collectionRef.doc(bengkelProfile.id).set(bengkelProfile);
    return bengkelProfile;
  }
}
