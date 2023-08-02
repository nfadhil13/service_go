import 'package:service_go/infrastructure/architecutre/local_mapper.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';

class SessionLocalMapper extends LocalMapper<UserData, dynamic> {
  SessionLocalMapper();

  @override
  UserData toDomain(entity) {
    return UserData(
        token: entity["firebaseToken"],
        id: entity["id"],
        username: entity["username"],
        email: entity["email"],
        isBengkel: entity["isBengkel"]);
  }

  @override
  toEntity(UserData domain) {
    return {
      "id": domain.id,
      "email": domain.email,
      "username": domain.username,
      "isBengkel": domain.isBengkel,
      "firebaseToken": domain.token
    };
  }
}
