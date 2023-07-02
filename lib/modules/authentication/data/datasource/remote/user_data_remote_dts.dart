import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/modules/authentication/data/mapper/remote/user_data_firestore_entity.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';

abstract class UserDataRemoteDTS {
  Future<UserData?> fetchById(String userId);
  Future<bool> isUsernameExist(String username);
  Future<void> createUser(UserData userData);
}

@Injectable(as: UserDataRemoteDTS)
class UserDataRemoteDTSImpl implements UserDataRemoteDTS {
  final FirebaseFirestore _firestore;

  final UserDataFiresotreEntity _mapper = UserDataFiresotreEntity.build();

  UserDataRemoteDTSImpl(this._firestore);

  String get _collectionName =>
      ServiceGOFirestoreCollections.userData.collectionName;

  CollectionReference<UserData> get _colletion =>
      _firestore.collection(_collectionName).withConverter(
        fromFirestore: (model, _) {
          return _mapper.toDomain(model.data()!, model.id);
        },
        toFirestore: (value, options) {
          return _mapper.toFirestoreObject(value);
        },
      );

  @override
  Future<UserData?> fetchById(String userId) async {
    final result = await _colletion.doc(userId).get();
    return result.data();
  }

  @override
  Future<bool> isUsernameExist(String username) async {
    final searchUserByUsername = await _colletion
        .where(_mapper.usernameField.key, isEqualTo: username)
        .limit(1)
        .get();
    return searchUserByUsername.size == 1;
  }

  @override
  Future<void> createUser(UserData userData) async {
    await _colletion.doc(userData.id).set(userData);
  }
}
