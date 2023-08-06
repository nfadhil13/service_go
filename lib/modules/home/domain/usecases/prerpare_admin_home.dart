import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';
import 'package:service_go/modules/bengkel/domain/repositories/jenis_layanan_repository.dart';
import 'package:service_go/modules/customer/domain/repositories/customer_profile_repo.dart';
import 'package:service_go/modules/service/domain/repositories/servis_repository.dart';

@injectable
class PrepareAdminHome extends UsecaseNoParams<
    ({int userCount, int bengkelCount, int servisCount, int jenisCount})> {
  final BengkelProfileRepository _bengkelProfileRepository;
  final CustomerProfileRepo _customerProfileRepo;
  final ServisRepo _servisRepo;
  final JenisLayananRepository _jenisLayananRepository;

  PrepareAdminHome(this._bengkelProfileRepository, this._customerProfileRepo,
      this._servisRepo, this._jenisLayananRepository);

  @override
  Future<
      Resource<
          ({
            int userCount,
            int bengkelCount,
            int servisCount,
            int jenisCount
          })>> execute() async {
    final countBengkel = _bengkelProfileRepository.count();
    final countCustomer = _customerProfileRepo.count();
    final countServis = _servisRepo.count();
    final jenisCount = _jenisLayananRepository.getAllJenisLayanan();
    return Resource.success((
      bengkelCount: await countBengkel,
      servisCount: await countServis,
      userCount: await countCustomer,
      jenisCount: (await jenisCount).length
    ));
  }
}
