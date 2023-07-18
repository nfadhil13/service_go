import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';
import 'package:service_go/modules/bengkel/domain/repositories/jenis_layanan_repository.dart';

typedef PrepareBengkelProfileFormResult = ({
  List<JenisLayanan> layananList,
  BengkelProfile? bengkelProfile
});

typedef PrepareBengkelProfileFormParams = (String userId,);

@injectable
class PrepareBengkelProfileForm extends Usecase<PrepareBengkelProfileFormParams,
    PrepareBengkelProfileFormResult> {
  final JenisLayananRepository _jenisLayananRepo;
  final BengkelProfileRepository _bengkelProfileRepo;

  PrepareBengkelProfileForm(this._jenisLayananRepo, this._bengkelProfileRepo);

  @override
  Future<Resource<PrepareBengkelProfileFormResult>> execute(
      PrepareBengkelProfileFormParams params) async {
    final jenisLayananFuture = _jenisLayananRepo.getAllJenisLayanan();
    final bengkelFuture = _bengkelProfileRepo.getBengkelProfile(params.$1);
    final jenisLayanan = await jenisLayananFuture;
    final bengkelProfile = await bengkelFuture;
    return Resource.success(
        (layananList: jenisLayanan, bengkelProfile: bengkelProfile));
  }
}
