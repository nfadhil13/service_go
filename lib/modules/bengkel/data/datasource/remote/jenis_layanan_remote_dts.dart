import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/jenis_layanan_firestore_entity.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

abstract class JenisLayananRemoteDTS {
  Future<List<JenisLayanan>> fetchAllJenisLayanan();
  Future<void> update(JenisLayanan jenisLayanan);
  Future<void> create(String name);
  Future<void> temp();
}

@Injectable(as: JenisLayananRemoteDTS)
class JenisLayananRemoteDTSImpl implements JenisLayananRemoteDTS {
  final JenisLayananFirestoreDTS _jenisLayananFirestore;
  JenisLayananRemoteDTSImpl(this._jenisLayananFirestore);

  @override
  Future<List<JenisLayanan>> fetchAllJenisLayanan() async =>
      _jenisLayananFirestore.fetchAll(
          query: SGDataQuery(sort: [
        SGSort(key: FireStoreField.updatedAtKey, type: SGSortType.desc)
      ]));

  @override
  Future<void> update(JenisLayanan jenisLayanan) =>
      _jenisLayananFirestore.put(jenisLayanan, jenisLayanan.id);

  @override
  Future<void> create(String name) =>
      _jenisLayananFirestore.create(JenisLayanan(id: "", name: name));

  @override
  Future<void> temp() {
    // TODO: implement temp
    throw UnimplementedError();
  }
}
