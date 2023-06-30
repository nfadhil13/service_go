import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

@injectable
class Login extends Usecase<LoginParams, UserSession> {
  final AuthenticationRepo _authenticationRepo;

  Login(this._authenticationRepo);

  @override
  Future<Resource<UserSession>> execute(LoginParams params) =>
      _authenticationRepo
          .login(username: params.username, password: params.password)
          .asResource;
}
