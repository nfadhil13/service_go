import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';

@injectable
class GetJadwalBengkel extends Usecase<(String bengkelId,), JadwalBengkel> {
  final BengkelProfileRepository _bengkelProfileRepository;

  GetJadwalBengkel(this._bengkelProfileRepository);

  @override
  Future<Resource<JadwalBengkel>> execute((String bengkelId,) params) async {
    final bengkelProfile =
        await _bengkelProfileRepository.getBengkelProfile(params.$1);
    if (bengkelProfile == null) {
      throw const BaseException("Bengkel tidak ditemukan");
    }
    return Resource.success(bengkelProfile.jadwalBengkel);
  }
}
