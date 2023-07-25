import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/bengkel_firestore_dts.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart';
import 'package:service_go/modules/customer/data/datasource/firestore/customer_profile_firestore_dts.dart';
import 'package:service_go/modules/service/data/datasource/firestore/servis_firestore_dts.dart';
import 'package:service_go/modules/service/data/mapper/servis/servis_dto.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';

abstract class ServisRemoteDTS {
  Future<Servis> createServis(Servis servis);
  Future<Servis> putServis(Servis servis);
  Future<List<Servis>> getServisList(SGDataQuery? query);
  Future<Servis?> getServisById(String id);
}

@Injectable(as: ServisRemoteDTS)
class ServisRemoteDTSImpl implements ServisRemoteDTS {
  final ServisFirestoreDTS _servisFirestoreDTS;
  final BengkelProfileFirestoreDTS _bengkelProfileFirestoreDTS;
  final CustomerProfileFirestoreDTS _customProfileFirestoreDTS;
  final JenisLayananFirestoreDTS _jenisLayananFirestoreDTS;

  ServisRemoteDTSImpl(
      this._servisFirestoreDTS,
      this._bengkelProfileFirestoreDTS,
      this._customProfileFirestoreDTS,
      this._jenisLayananFirestoreDTS);

  Future<ServisDTOParams> _getParams(ServisDTO servisDTO) async {
    final bengkelFuture = _bengkelProfileFirestoreDTS
        .fetchOne(servisDTO.bengkelId)
        .map((value) => ServisBengkel(value!.id, value.nama));
    final customerFuture = _customProfileFirestoreDTS
        .fetchOne(servisDTO.customerId)
        .map((value) => ServisCustomer(value!.id, value.nama));
    final jenisLayananFuture =
        _jenisLayananFirestoreDTS.fetchByIds(servisDTO.layananIds);
    return ServisDTOParams(
        customer: await customerFuture,
        bengkel: await bengkelFuture,
        jenisLayanan: await jenisLayananFuture);
  }

  @override
  Future<Servis> createServis(Servis servis) => _servisFirestoreDTS
      .create(ServisDTO.fromDomain(servis))
      .then((value) async => value.toDomain(await _getParams(value)));

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
    return servis;
  }
}
