import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';

abstract class FireStoreMapper<Domain> {
  List<FireStoreField<Domain, dynamic>> get fields;

  Domain toDomain(Map<String, dynamic> firestoreData, String id);

  FireStoreMapper();

  Map<String, dynamic> toFirestoreObject(Domain domain) {
    final result = <String, dynamic>{};
    for (final field in fields) {
      result[field.key] = field.toField(field.data(domain));
    }
    return result;
  }
}
