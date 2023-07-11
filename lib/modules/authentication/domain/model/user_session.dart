import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';

class UserSession extends Equatable {
  final UserData userData;
  final User user;

  const UserSession(this.userData, this.user);

  String get username => userData.username;

  String get email => userData.email;

  bool get isBengkel => userData.isBengkel;

  String get userId => user.uid;

  @override
  List<Object?> get props => [userData, user];
}
