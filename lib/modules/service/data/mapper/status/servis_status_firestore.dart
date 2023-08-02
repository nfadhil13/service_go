import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/service/data/mapper/status/servis_status_dto.dart';

class ServisStatusFirestoreEntity extends FireStoreMapper<ServisStatusDataDTO> {
  final timestamp = FireStoreField<ServisStatusDataDTO, Timestamp>(
      "timestamp", (entity) => entity.timestamp);

  @override
  List<FireStoreField<ServisStatusDataDTO, dynamic>> get fields => [timestamp];

  @override
  Map<String, dynamic> toFirestoreObject(ServisStatusDataDTO result) {
    return {...result.detailData, ...super.toFirestoreObject(result)};
  }

  @override
  ServisStatusDataDTO toResult(Map<String, dynamic> firestoreData, String id) {
    return ServisStatusDataDTO(
        id, timestamp.parseJSON(firestoreData), firestoreData);
  }
}
