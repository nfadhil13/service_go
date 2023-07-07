import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';

abstract class FirestoreDatasource<Entity,
    Mapper extends FireStoreMapper<Entity>> {
  final Mapper mapper;
  final FirestoreCollections collection;
  final FirebaseFirestore firestore;

  FirestoreDatasource(
      {required this.mapper,
      required this.collection,
      required this.firestore});

  CollectionReference<Entity> get collectionRef =>
      firestore.collection(collection.collectionName).withConverter(
        fromFirestore: (model, _) {
          return mapper.toDomain(model.data()!, model.id);
        },
        toFirestore: (value, options) {
          return mapper.toFirestoreObject(value);
        },
      );
}
