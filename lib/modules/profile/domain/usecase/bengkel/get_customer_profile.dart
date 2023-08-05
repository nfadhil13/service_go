import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';
import 'package:service_go/modules/customer/domain/repositories/customer_profile_repo.dart';

@injectable
class GetBengkelProfile extends Usecase<(String userId,), BengkelProfile?> {
  final BengkelProfileRepository _bengkelProfileRepo;

  GetBengkelProfile(this._bengkelProfileRepo);

  @override
  Future<Resource<BengkelProfile?>> execute((String userId,) params) =>
      _bengkelProfileRepo.getBengkelProfile(params.$1).asResource;
}
