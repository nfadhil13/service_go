import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';

@injectable
class CheckIfBengkelHasProfile extends UsecaseNoParams<
    ({BengkelProfile? profile, bool isSessionExpired})> {
  final BengkelProfileRepository _bengkelProfileRepository;
  final AuthenticationRepo _authenticationRepo;

  CheckIfBengkelHasProfile(
      this._bengkelProfileRepository, this._authenticationRepo);

  @override
  Future<Resource<({BengkelProfile? profile, bool isSessionExpired})>>
      execute() async {
    final user = await _authenticationRepo.getLastLoggedInUser();
    if (user == null) {
      return Resource.success((profile: null, isSessionExpired: true));
    }
    final bengkelProfile =
        await _bengkelProfileRepository.getBengkelProfile(user.user.uid);
    return Resource.success((profile: bengkelProfile, isSessionExpired: false));
  }
}
