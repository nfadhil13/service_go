import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';

class FirestoreDatasource<Entity, Mapper extends FireStoreMapper<Entity>> {
  final Mapper mapper;
  final FirestoreCollections collection;
  final FirebaseFirestore firestore;

  FirestoreDatasource(
      {required this.mapper,
      required this.collection,
      required this.firestore});

  Future<void> put(Entity entity, String id) =>
      collectionRef.doc(id).set(entity);

  Future<Entity?> fetchOne(String id) =>
      collectionRef.doc(id).get().then((value) => value.data());

  Future<List<Entity>> fetchAll() => collectionRef
      .get()
      .map((value) => value.docs.map((e) => e.data()).toList());

  Future<List<Entity>> fetchByIds(List<String> ids) async {
    final List<Entity> result = [];
    final ids2D = ids.mapTo2D(10);
    DocumentSnapshot? lastCursor;
    for (final ids in ids2D) {
      var ref = collectionRef.where(FieldPath.documentId, whereIn: ids);

      if (lastCursor != null) {
        ref = ref.startAfterDocument(lastCursor);
      }

      final list = await ref.get();
      lastCursor = list.docs.last;
      result.addAll(list.docs.map((e) => e.data()));
    }

    return result;
  }

  CollectionReference<Entity> get collectionRef =>
      firestore.collection(collection.collectionName).withConverter(
        fromFirestore: (model, _) {
          return mapper.toResult(model.data()!, model.id);
        },
        toFirestore: (value, options) {
          return mapper.toFirestoreObject(value);
        },
      );
}
