import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/storage/sg_storage_helper.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/bengkel_firestore_dts.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart';
import 'package:service_go/modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart';
import 'package:service_go/modules/service/data/datasource/firestore/servis_firestore_dts.dart';
import 'package:service_go/modules/service/data/datasource/firestore/servis_status_firestore_dts.dart';
import 'package:service_go/modules/service/data/datasource/remote/servis_status_remote_dts.dart';
import 'package:service_go/modules/service/data/mapper/servis/servis_dto.dart';
import 'package:service_go/modules/service/data/mapper/status/servis_status_dto.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';

abstract class ServisRemoteDTS {
  Future<Servis> createServis(Servis servis);
  Future<Servis> putServis(Servis servis);
  Future<List<Servis>> getServisList(SGDataQuery? query);
  Future<Servis?> getServisById(String id);
  Future<ServisDetail> getServisDetail(String id);
}

@Injectable(as: ServisRemoteDTS)
class ServisRemoteDTSImpl implements ServisRemoteDTS {
  final ServisFirestoreDTS _servisFirestoreDTS;

  final BengkelProfileFirestoreDTS _bengkelProfileFirestoreDTS;
  final CustomerProfileFirestoreDTS _customProfileFirestoreDTS;
  final ServisStatusRemoteDTS _servisStatusRemoteDTS;
  final JenisLayananFirestoreDTS _jenisLayananFirestoreDTS;

  ServisRemoteDTSImpl(
    this._servisFirestoreDTS,
    this._bengkelProfileFirestoreDTS,
    this._customProfileFirestoreDTS,
    this._jenisLayananFirestoreDTS,
    this._servisStatusRemoteDTS,
  );

  Future<ServisDTOParams> _getParams(ServisDTO servisDTO) async {
    final bengkelFuture = _bengkelProfileFirestoreDTS
        .fetchOne(servisDTO.bengkelId)
        .map((value) => ServisBengkel(value!.id, value.nama));
    final customerFuture = _customProfileFirestoreDTS
        .fetchOne(servisDTO.customerId)
        .map((value) => ServisCustomer(value!.id, value.nama));
    final jenisLayananFuture =
        _jenisLayananFirestoreDTS.fetchByIds(servisDTO.layananIds);
    final statusData = _servisStatusRemoteDTS.getById(
        servisDTO.id, servisDTO.status.toString());
    final keteranganServis = _servisStatusRemoteDTS
        .getByIdNullable(
            servisDTO.id, ServisStatus.konfirmasiServis.id.toString())
        .map((value) {
      if (value is ServisStatusUnitKonfirmasiServis) {
        return KeteranganServis(
            value.deskripsiServis, value.attachments, value.timestamp);
      }
      return null;
    });
    return ServisDTOParams(
        keteranganServis: await keteranganServis,
        data: await statusData,
        customer: await customerFuture,
        bengkel: await bengkelFuture,
        jenisLayanan: await jenisLayananFuture);
  }

  @override
  Future<Servis> createServis(Servis servis) async {
    final createdServis =
        await _servisFirestoreDTS.create(ServisDTO.fromDomain(servis));
    await _servisStatusRemoteDTS.put(createdServis.id, servis.statusData);
    final params = await _getParams(createdServis);
    return createdServis.toDomain(params);
  }

  @override
  Future<Servis?> getServisById(String id) => _servisFirestoreDTS
      .fetchOne(id)
      .then((value) async => value?.toDomain(await _getParams(value)));

  @override
  Future<List<Servis>> getServisList(SGDataQuery? query) async {
    final servisList = await _servisFirestoreDTS.fetchAll(query: query);
    return Future.wait(
        servisList.map((e) async => e.toDomain(await _getParams(e))));
  }

  @override
  Future<Servis> putServis(Servis servis) async {
    final id = servis.id.id;
    if (id == null) return createServis(servis);
    await _servisFirestoreDTS.put(ServisDTO.fromDomain(servis), id);
    await _servisStatusRemoteDTS.put(id, servis.statusData);
    return (await getServisById(id))!;
  }

  @override
  Future<ServisDetail> getServisDetail(String id) async {
    final servisDTO = await _servisFirestoreDTS.fetchOne(id);
    if (servisDTO == null) throw const BaseException("Servis tidak ditemukan");

    // Get Bengkel data for corresponding customer
    final bengkelFuture =
        _bengkelProfileFirestoreDTS.fetchOne(servisDTO.bengkelId);

    // Get Customer data for corressponding  servis
    final customerFuture = _customProfileFirestoreDTS
        .fetchOne(servisDTO.customerId)
        .map((value) => ServisCustomer(value!.id, value.nama));

    // Get all jenis layanan ofor corresponding servis
    final jenisLayananFuture =
        _jenisLayananFirestoreDTS.fetchByIds(servisDTO.layananIds);

    // Get All Logs for corresponding servis
    final statusDataLog = await _servisStatusRemoteDTS.getAll(id);
    final bengkel = await bengkelFuture;

    final params = ServisDTOParams(
        keteranganServis: statusDataLog
            .firstWhere((element) =>
                element.status.id == ServisStatus.konfirmasiServis.id)
            .let((value) {
          if (value is ServisStatusUnitKonfirmasiServis) {
            return KeteranganServis(
                value.deskripsiServis, value.attachments, value.timestamp);
          }
          return null;
        }),
        data: statusDataLog
            .firstWhere((element) => element.status.id == servisDTO.status),
        customer: await customerFuture,
        bengkel: ServisBengkel(bengkel!.id, bengkel.nama),
        jenisLayanan: await jenisLayananFuture);
    return ServisDetail(
        servisDTO.toDomain(params), bengkel.toDomain([]), statusDataLog);
  }
}
