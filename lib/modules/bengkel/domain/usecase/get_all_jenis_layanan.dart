import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/bengkel/domain/repositories/jenis_layanan_repository.dart';

@injectable
class GetAllJenisLayanan extends UsecaseNoParams<List<JenisLayanan>> {
  final JenisLayananRepository _repo;

  GetAllJenisLayanan(this._repo);

  @override
  Future<Resource<List<JenisLayanan>>> execute() =>
      _repo.getAllJenisLayanan().asResource;
}
