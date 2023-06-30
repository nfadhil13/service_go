import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';

@injectable
class GetCurrentSession extends UsecaseNoParams<UserSession?> {
  final AuthenticationRepo _authenticationRepo;

  GetCurrentSession(this._authenticationRepo);

  @override
  Future<Resource<UserSession?>> execute() =>
      _authenticationRepo.getLastLoggedInUser().asResource;
}
