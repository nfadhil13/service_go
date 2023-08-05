import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';

class UpdateJadwalBengkelParams {
  final String userId;
  final JadwalBengkel jadwalBengkel;
  const UpdateJadwalBengkelParams(
      {required this.userId, required this.jadwalBengkel});
}

@injectable
class UpdateJadwalBengkel
    extends Usecase<UpdateJadwalBengkelParams, JadwalBengkel> {
  final BengkelProfileRepository _bengkelProfileRepository;

  UpdateJadwalBengkel(this._bengkelProfileRepository);

  @override
  Future<Resource<JadwalBengkel>> execute(
      UpdateJadwalBengkelParams params) async {
    final bengkelProfile =
        await _bengkelProfileRepository.getBengkelProfile(params.userId);
    if (bengkelProfile == null) {
      throw const BaseException("Bengkel tidak ditemukan");
    }
    await _bengkelProfileRepository.createOrUpdateProfile(
        bengkelProfile.copyWith(jadwalBengkel: params.jadwalBengkel));
    return Resource.success(params.jadwalBengkel);
  }
}
