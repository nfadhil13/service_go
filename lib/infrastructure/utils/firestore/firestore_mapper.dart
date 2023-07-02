import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';

abstract class FireStoreMapper<Domain> {
  final List<FireStoreField<Domain, dynamic>> fields;

  Domain toDomain(Map<String, dynamic> firestoreData, String id);

  FireStoreMapper(this.fields);

  Map<String, dynamic> toFirestoreObject(Domain data) {
    final result = <String, dynamic>{};
    for (final field in fields) {
      result[field.key] = field.data(data);
    }
    return result;
  }
}
