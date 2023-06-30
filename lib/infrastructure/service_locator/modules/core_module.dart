import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/local_storage/secure_storage/secure_storage.dart';

@module
abstract class CoreModules {
  FlutterSecureStorage getFlutterSecureStorage() =>
      FlutterSecureStorage(aOptions: SecureStorageImpl.androidOptions());
}
