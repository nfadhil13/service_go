import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';
import 'package:service_go/modules/authentication/domain/model/user_type.dart';

class UserSession extends Equatable {
  final UserData userData;
  final User user;

  const UserSession(this.userData, this.user);

  String get username => userData.username;

  String get email => userData.email;

  bool get isBengkel => userData.userType == UserType.bengkel;

  bool get isCustomer => userData.userType == UserType.customer;

  String get userId => user.uid;

  @override
  List<Object?> get props => [userData, user];
}
