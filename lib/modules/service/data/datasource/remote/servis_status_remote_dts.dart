import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/storage/sg_storage_helper.dart';
import 'package:service_go/modules/service/data/datasource/firestore/servis_status_firestore_dts.dart';
import 'package:service_go/modules/service/data/mapper/status/servis_status_dto.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';

abstract class ServisStatusRemoteDTS {
  Future<ServisStatusData> getById(String servisId, String id);
  Future<ServisStatusData?> getByIdNullable(String servisId, String id);
  Future<ServisStatusData> put(String servisId, ServisStatusData servisStatus);
  Future<List<ServisStatusData>> getAll(String servisId);
}

@Injectable(as: ServisStatusRemoteDTS)
class ServisStatusRemoteDTSImpl implements ServisStatusRemoteDTS {
  final ServisStatusFirestoreDTS _servisStatusFirestoreDTS;
  final SGStorageHelper _storageHelper;

  ServisStatusRemoteDTSImpl(
      this._servisStatusFirestoreDTS, this._storageHelper);

  String _servisStatusDataCollectionBuilder(
      {required String collectionName, required String servisId}) {
    return "${FirestoreCollections.servis.collectionName}/$servisId/$collectionName";
  }

  @override
  Future<List<ServisStatusData>> getAll(String servisId) async {
    return await _servisStatusFirestoreDTS
        .fetchAll(
          pathBuilder: (collectionName) => _servisStatusDataCollectionBuilder(
              collectionName: collectionName, servisId: servisId),
        )
        .map((value) => value.map((e) => e.toDomain()).toList());
  }

  @override
  Future<ServisStatusData> put(
      String servisId, ServisStatusData servisStatus) async {
    ServisStatusData finalStatusData = servisStatus;
    switch (finalStatusData) {
      case ServisStatusUnitKonfirmasiServis():
        final attachments = finalStatusData.attachments;
        final uploadedAttachments =
            await Future.wait(attachments.map((e) async {
          final finalImage = e is SGFileImage
              ? SGNetworkImage(await _storageHelper.uploadImage(e))
              : e;
          return finalImage;
        }));
        finalStatusData =
            finalStatusData.copyWith(attachments: uploadedAttachments);
        break;
      case ServisStatusSelesai():
        final image = finalStatusData.bukti;
        final finalImage = image is SGFileImage
            ? SGNetworkImage(await _storageHelper.uploadImage(image))
            : image;

        finalStatusData = finalStatusData.copyWith(bukti: finalImage);
        break;
      default:
        break;
    }
    await _servisStatusFirestoreDTS.put(
      ServisStatusDataDTO.fromParent(finalStatusData),
      finalStatusData.status.id.toString(),
      pathBuilder: (collectionName) => _servisStatusDataCollectionBuilder(
          collectionName: collectionName, servisId: servisId),
    );
    return getById(servisId, finalStatusData.status.id.toString());
  }

  @override
  Future<ServisStatusData> getById(String servisId, String id) async {
    return _servisStatusFirestoreDTS
        .fetchOne(
          id,
          pathBuilder: (collectionName) => _servisStatusDataCollectionBuilder(
              collectionName: collectionName, servisId: servisId),
        )
        .map((value) => value!.toDomain());
  }

  @override
  Future<ServisStatusData?> getByIdNullable(String servisId, String id) {
    return _servisStatusFirestoreDTS
        .fetchOne(
          id,
          pathBuilder: (collectionName) => _servisStatusDataCollectionBuilder(
              collectionName: collectionName, servisId: servisId),
        )
        .map((value) => value?.toDomain());
  }
}
