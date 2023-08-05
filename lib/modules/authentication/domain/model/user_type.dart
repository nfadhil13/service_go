import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';

const _values = UserType.values;

enum UserType {
  // Id ; 0
  admin,
  // Id : 1
  customer,
  // Id : 2
  bengkel;

  int get id => index;

  static UserType fromId(int id) {
    final userType = _values.getAtOrNull(id);
    if (userType == null) throw const BaseException("Unknown Id");
    return userType;
  }
}
