import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/service/data/mapper/servis/servis_dto.dart';

class ServisFirestoreEntity extends FireStoreMapper<ServisDTO> {
  final FireStoreField<ServisDTO, String> namaMotor =
      FireStoreField("namaMotor", (entity) => entity.namaMotor);

  final FireStoreField<ServisDTO, String> platNomor =
      FireStoreField("platNomor", (entity) => entity.platNomor);

  final FireStoreListField<ServisDTO, String> layananIds =
      FireStoreListField("layananIds", (entity) => entity.layananIds);

  final FireStoreField<ServisDTO, Timestamp> tanggalService =
      FireStoreField("tanggalService", (entity) => entity.tanggalService);

  final FireStoreField<ServisDTO, String> customerId =
      FireStoreField("customerId", (entity) => entity.customerId);

  final FireStoreField<ServisDTO, String> bengkelId =
      FireStoreField("bengkelId", (entity) => entity.bengkelId);

  final FireStoreField<ServisDTO, String> catatan =
      FireStoreField("catatan", (entity) => entity.catatan);

  final FireStoreField<ServisDTO, int> status =
      FireStoreField("status", (entity) => entity.status);

  @override
  List<FireStoreField<ServisDTO, dynamic>> get fields => [
        namaMotor,
        platNomor,
        layananIds,
        tanggalService,
        customerId,
        bengkelId,
        catatan,
        status,
      ];

  @override
  ServisDTO toResult(Map<String, dynamic> firestoreData, String id) {
    return ServisDTO(
        id: id,
        status: status.parseJSON(firestoreData),
        namaMotor: namaMotor.parseJSON(firestoreData),
        platNomor: platNomor.parseJSON(firestoreData),
        layananIds: layananIds.parseJSON(firestoreData),
        tanggalService: tanggalService.parseJSON(firestoreData),
        customerId: customerId.parseJSON(firestoreData),
        bengkelId: bengkelId.parseJSON(firestoreData),
        catatan: catatan.parseJSON(firestoreData));
  }
}
