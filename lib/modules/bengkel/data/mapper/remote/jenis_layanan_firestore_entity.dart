import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

class JenisLayananFirestoreEntity extends FireStoreMapper<JenisLayanan> {
  final FireStoreField<JenisLayanan, String> name =
      FireStoreField("name", (entity) => entity.name);

  @override
  List<FireStoreField<JenisLayanan, dynamic>> get fields => [name];

  @override
  JenisLayanan toDomain(Map<String, dynamic> firestoreData, String id) {
    return JenisLayanan(id: id, name: name.parseJSON(firestoreData));
  }
}
