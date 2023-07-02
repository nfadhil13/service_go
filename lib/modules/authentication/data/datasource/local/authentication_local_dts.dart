import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/local_storage/secure_storage/secure_storage.dart';
import 'package:service_go/modules/authentication/data/mapper/local/user_data_local_mapper.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';

abstract class AuthenticationLocalDTS {
  Future<void> putSession(UserData session);
  Future<void> clearSession();
  Future<UserSession?> getLastSession();
}

@Injectable(as: AuthenticationLocalDTS)
class AuthLocalDTSImpl implements AuthenticationLocalDTS {
  final SecureStorage _secureStorage;
  final FirebaseAuth _firebaseAuth;
  final SessionLocalMapper _sessionLocalMapper = SessionLocalMapper();

  final _userSessionKey =
      "ServiceGo.profielder.mobile.lib.modules.authentication.data.datasource.local.authentication_local_dts.dart";

  AuthLocalDTSImpl(this._secureStorage, this._firebaseAuth);

  @override
  Future<void> putSession(UserData session) => _secureStorage.writeJSON(
      key: _userSessionKey, json: _sessionLocalMapper.toEntity(session));

  @override
  Future<void> clearSession() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _secureStorage.remove(_userSessionKey),
    ]);
  }

  @override
  Future<UserSession?> getLastSession() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    final userData = await _secureStorage.readData(_sessionLocalMapper.toDomain,
        key: _userSessionKey);
    if (userData == null) return null;
    return UserSession(userData, firebaseUser);
  }
}
