import 'package:service_go/infrastructure/architecutre/local_mapper.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';
import 'package:service_go/modules/authentication/domain/model/user_type.dart';

class SessionLocalMapper extends LocalMapper<UserData, dynamic> {
  SessionLocalMapper();

  @override
  UserData toDomain(entity) {
    return UserData(
        token: entity["firebaseToken"],
        id: entity["id"],
        username: entity["username"],
        email: entity["email"],
        userType: UserType.fromId(entity["userType"]));
  }

  @override
  toEntity(UserData domain) {
    return {
      "id": domain.id,
      "email": domain.email,
      "username": domain.username,
      "userType": domain.userType.id,
      "firebaseToken": domain.token
    };
  }
}
