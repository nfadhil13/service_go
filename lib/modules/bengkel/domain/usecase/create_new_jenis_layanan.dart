import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/nothing.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/bengkel/domain/repositories/jenis_layanan_repository.dart';

class CreateOrUpdateJenisLayananParams {
  final String? id;
  final String namaJenisLayanan;
  const CreateOrUpdateJenisLayananParams(
      {required this.id, required this.namaJenisLayanan});
}

@injectable
class CreateOrUpdateJenisLayanan
    extends Usecase<CreateOrUpdateJenisLayananParams, Nothing> {
  final JenisLayananRepository _jenisLayananRepository;

  CreateOrUpdateJenisLayanan(this._jenisLayananRepository);

  @override
  Future<Resource<Nothing>> execute(
      CreateOrUpdateJenisLayananParams params) async {
    await _jenisLayananRepository
        .put(JenisLayanan(id: params.id ?? "", name: params.namaJenisLayanan));
    return Resource.success(const Nothing());
  }
}
