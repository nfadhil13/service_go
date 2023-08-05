import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
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
  final FirebaseMessaging _firebaseMessaging;
  final UserDataRemoteDTS _userDataRemoteDTS;

  AuthenticationRepoImpl(this._authenticationRemoteDTS, this._authLocalDTS,
      this._userDataRemoteDTS, this._firebaseMessaging);

  @override
  Future<UserSession> login(
      {required String email, required String password}) async {
    final authLoginResult =
        await _authenticationRemoteDTS.login(email: email, password: password);
    final user = await _userDataRemoteDTS.fetchById(authLoginResult.uid);
    if (user == null) throw const BaseException("User not found");
    final notificationToken = await _firebaseMessaging.getToken();
    await _userDataRemoteDTS.updateToken(user.id, token: notificationToken);
    await _authLocalDTS.putSession(user);
    return UserSession(user, authLoginResult);
  }

  @override
  Future<UserSession?> getLastLoggedInUser() => _authLocalDTS.getLastSession();

  @override
  Future<void> logout() async {
    final user = await _authLocalDTS.getLastSession();
    if (user != null) {
      await _userDataRemoteDTS.updateToken(user.userId, token: null);
      await _authLocalDTS.clearSession();
    }
  }

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
        token: null,
        id: registuerUserResult.uid,
        username: user.username,
        email: user.email,
        userType: user.isBengkel));
  }
}
