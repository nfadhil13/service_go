import 'package:service_go/modules/authentication/domain/model/user_register_data.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';

abstract class AuthenticationRepo {
  Future<UserSession> login({required String email, required String password});
  Future<UserSession?> getLastLoggedInUser();
  Future<void> registerUser(UserRegisterData user);
  Future<void> logout();
}
