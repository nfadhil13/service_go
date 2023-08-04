
// @Injectable(as: NotificationRepo)
// class NotificationRepoImpl implements NotificationRepo {
//   final UserDataRemoteDTS _userDataRemoteDTS;
//   final FirebaseMessaging _mesaging;

//   NotificationRepoImpl(this._userDataRemoteDTS, this._mesaging);

//   @override
//   Future<void> sendNotificationToUser(String userId) async {
//     final user = await _userDataRemoteDTS.fetchById(userId);
//     final token = user?.token;
//     if (token == null) return;
//     _mesaging.sendMessage()
//   }
// }
