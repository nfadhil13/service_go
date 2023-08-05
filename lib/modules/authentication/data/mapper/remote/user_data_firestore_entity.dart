import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';
import 'package:service_go/modules/authentication/domain/model/user_type.dart';

class UserDataFiresotreEntity extends FireStoreMapper<UserData> {
  final FireStoreField<UserData, String> emailField;

  final FireStoreField<UserData, String> usernameField;

  final FireStoreField<UserData, int> userType;

  final FireStoreField<UserData, String?> notificationToken =
      FireStoreField("notificationToken", (entity) => entity.token);

  UserDataFiresotreEntity._(this.usernameField, this.userType, this.emailField);

  factory UserDataFiresotreEntity.build() {
    // Build username field
    final FireStoreField<UserData, String> usernameField =
        FireStoreField("username", (entity) => entity.username);

    // Build Is Bengkel field
    final FireStoreField<UserData, int> userType =
        FireStoreField("tipeAkun", (entity) => entity.userType.id);

    // Build Email field
    final FireStoreField<UserData, String> emailField =
        FireStoreField("email", (entity) => entity.email);

    return UserDataFiresotreEntity._(usernameField, userType, emailField);
  }

  @override
  UserData toResult(firestoreData, String id) {
    return UserData(
        id: id,
        token: notificationToken.parseJSON(firestoreData),
        username: usernameField.parseJSON(firestoreData),
        email: emailField.parseJSON(firestoreData),
        userType: UserType.fromId(userType.parseJSON(firestoreData)));
  }

  @override
  List<FireStoreField<UserData, dynamic>> get fields =>
      [usernameField, emailField, userType, notificationToken];
}
