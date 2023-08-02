import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_datasource.dart';
import 'package:service_go/modules/authentication/data/mapper/remote/user_data_firestore_entity.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';

abstract class UserDataRemoteDTS {
  Future<UserData?> fetchById(String userId);
  Future<bool> isUsernameExist(String username);
  Future<void> createUser(UserData userData);
  Future<void> updateToken(String userId, {required String? token});
}

@Injectable(as: UserDataRemoteDTS)
class UserDataRemoteDTSImpl
    extends FirestoreDatasource<UserData, UserDataFiresotreEntity>
    implements UserDataRemoteDTS {
  UserDataRemoteDTSImpl(FirebaseFirestore firebaseFirestore)
      : super(
            mapper: UserDataFiresotreEntity.build(),
            collection: FirestoreCollections.userData,
            firestore: firebaseFirestore);

  @override
  Future<UserData?> fetchById(String userId) async {
    final result = await collectionRef().doc(userId).get();
    return result.data();
  }

  @override
  Future<bool> isUsernameExist(String username) async {
    final searchUserByUsername = await collectionRef()
        .where(mapper.usernameField.key, isEqualTo: username)
        .limit(1)
        .get();
    return searchUserByUsername.size == 1;
  }

  @override
  Future<void> createUser(UserData userData) async {
    await collectionRef().doc(userData.id).set(userData);
  }

  @override
  Future<void> updateToken(String userId, {required String? token}) async {
    await collectionRef()
        .doc(userId)
        .update({mapper.notificationToken.key: token});
  }
}
