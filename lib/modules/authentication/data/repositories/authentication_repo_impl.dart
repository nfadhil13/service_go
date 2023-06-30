import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/client/api_client.dart';
import 'package:service_go/modules/authentication/data/datasource/local/authentication_local_dts.dart';
import 'package:service_go/modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';

@Injectable(as: AuthenticationRepo)
class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDTS _authenticationRemoteDTS;
  final AuthenticationLocalDTS _authLocalDTS;

  AuthenticationRepoImpl(this._authenticationRemoteDTS, this._authLocalDTS);

  @override
  Future<UserSession> login(
      {required String username, required String password}) async {
    final loginResult = await _authenticationRemoteDTS.login(
        username: username, password: password);
    await _authLocalDTS.putSession(loginResult.data);
    return loginResult.data;
  }

  @override
  Future<UserSession?> getLastLoggedInUser() => _authLocalDTS.getLastSession();

  @override
  Future<void> logout() => _authLocalDTS.clearSession();
}
