import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/customer/data/mapper/remote/customer_profile_firestore_entity.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';

@injectable
class CustomProfileFirestoreDTS extends FirestoreDatasource<CustomerProfile,
    FireStoreMapper<CustomerProfile>> {
  final FirebaseStorage firebaseStorage;

  CustomProfileFirestoreDTS(
      FirebaseFirestore firebaseFirestore, this.firebaseStorage)
      : super(
            collection: FirestoreCollections.customerProfile,
            firestore: firebaseFirestore,
            mapper: CustomerProfileFirestoreEntity());
}
