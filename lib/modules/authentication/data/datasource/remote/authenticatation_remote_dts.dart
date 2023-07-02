import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/exceptions/form_exception.dart';
import 'package:service_go/infrastructure/utils/firebase_exception_handler.dart/firebase_exception_handler.dart';

abstract class AuthenticationRemoteDTS {
  Future<User> login({required String email, required String password});
  Future<User> register({required String email, required String password});
}

@Injectable(as: AuthenticationRemoteDTS)
class AuthenticationRemoteDTSImpl implements AuthenticationRemoteDTS {
  final FirebaseAuth _auth;

  AuthenticationRemoteDTSImpl(this._auth);

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = firebaseUser.user;
      if (user == null) {
        throw FormException("Invalid Input",
            errors: {"email": 'Email belum terdaftar'});
      }
      final isVerified = user.emailVerified;
      if (!isVerified) {
        await user.sendEmailVerification();
        await _auth.signOut();
        throw FormException("Invalid Input", errors: {
          "email":
              'Email belum terverifikasi, silahkan cek email anda untuk verifikasi email'
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleAuthException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> register(
      {required String email, required String password}) async {
    try {
      final registerResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = registerResult.user;
      if (user == null) throw const BaseException("Gagal mendapatkan user");
      await user.sendEmailVerification();
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleAuthException(e);
    } catch (e) {
      rethrow;
    }
  }
}
