import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';

abstract class FireStoreMapper<Result> {
  List<FireStoreField<Result, dynamic>> get fields;

  Result toResult(Map<String, dynamic> firestoreData, String id);

  FireStoreMapper();

  Map<String, dynamic> toFirestoreObject(Result result) {
    final firestoreObject = <String, dynamic>{};
    for (final field in fields) {
      firestoreObject[field.key] = field.toField(field.data(result));
    }
    return firestoreObject;
  }

  // FireStoreField<Entity, Result> asField<Entity>(
  //   String key,
  //   Result Function(Entity data) data, {
  //   String? id,
  // }) {
  //   return FireStoreField(
  //     key,
  //     data,
  //     parser: (firestoreData) {
  //       return toResult(firestoreData, firestoreData["id"]);
  //     },
  //   );
  // }
}
