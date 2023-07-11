import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';

class UserDataFiresotreEntity extends FireStoreMapper<UserData> {
  final FireStoreField<UserData, String> emailField;

  final FireStoreField<UserData, String> usernameField;

  final FireStoreField<UserData, bool> isBengkelField;

  UserDataFiresotreEntity._(
      this.usernameField, this.isBengkelField, this.emailField);

  factory UserDataFiresotreEntity.build() {
    // Build username field
    final FireStoreField<UserData, String> usernameField =
        FireStoreField("username", (entity) => entity.username);

    // Build Is Bengkel field
    final FireStoreField<UserData, bool> isBengkelField =
        FireStoreField("isBengkel", (entity) => entity.isBengkel);

    // Build Email field
    final FireStoreField<UserData, String> emailField =
        FireStoreField("email", (entity) => entity.email);

    return UserDataFiresotreEntity._(usernameField, isBengkelField, emailField);
  }

  @override
  UserData toDomain(firestoreData, String id) {
    return UserData(
        id: id,
        username: usernameField.parseJSON(firestoreData),
        email: emailField.parseJSON(firestoreData),
        isBengkel: isBengkelField.parseJSON(firestoreData));
  }

  @override
  List<FireStoreField<UserData, dynamic>> get fields =>
      [usernameField, emailField, isBengkelField];
}
