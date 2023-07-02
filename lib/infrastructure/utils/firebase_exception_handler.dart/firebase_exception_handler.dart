import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/exceptions/form_exception.dart';

class FirebaseExceptionHandler {
  static BaseException handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return FormException("Invalid Input",
            errors: {"email": 'Email sudah terdaftar'});
      case 'invalid-email':
        return FormException("Invalid Input",
            errors: {"email": 'Format email invalid'});
      case 'user-not-found':
        return FormException("Invalid Input",
            errors: {"email": 'Email belum terdaftar'});
      case 'wrong-password':
        return FormException("Invalid Input",
            errors: {"password": 'Password dan Email tidak sesuai'});
    }
    return BaseException(e.message ?? BaseException.unknownError().message);
  }
}
