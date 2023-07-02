import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/client/api_client.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/exceptions/form_exception.dart';
import 'package:service_go/modules/authentication/data/datasource/local/authentication_local_dts.dart';
import 'package:service_go/modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart';
import 'package:service_go/modules/authentication/data/datasource/remote/user_data_remote_dts.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';
import 'package:service_go/modules/authentication/domain/model/user_register_data.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';

@Injectable(as: AuthenticationRepo)
class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDTS _authenticationRemoteDTS;
  final AuthenticationLocalDTS _authLocalDTS;
  final UserDataRemoteDTS _userDataRemoteDTS;

  AuthenticationRepoImpl(this._authenticationRemoteDTS, this._authLocalDTS,
      this._userDataRemoteDTS);

  @override
  Future<UserSession> login(
      {required String email, required String password}) async {
    final authLoginResult =
        await _authenticationRemoteDTS.login(email: email, password: password);
    final user = await _userDataRemoteDTS.fetchById(authLoginResult.uid);
    if (user == null) throw const BaseException("User not found");
    await _authLocalDTS.putSession(user);
    return UserSession(user, authLoginResult);
  }

  @override
  Future<UserSession?> getLastLoggedInUser() => _authLocalDTS.getLastSession();

  @override
  Future<void> logout() => _authLocalDTS.clearSession();

  @override
  Future<void> registerUser(UserRegisterData user) async {
    final isUsernameExist =
        await _userDataRemoteDTS.isUsernameExist(user.username);
    if (isUsernameExist) {
      throw FormException("Invalid input",
          errors: {"username": "Username sudah digunakan"});
    }
    final registuerUserResult = await _authenticationRemoteDTS.register(
        email: user.email, password: user.password);
    await _userDataRemoteDTS.createUser(UserData(
        id: registuerUserResult.uid,
        username: user.username,
        email: user.email,
        isBengkel: user.isBengkel));
  }
}
