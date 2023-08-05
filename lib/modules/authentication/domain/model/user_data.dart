import 'package:equatable/equatable.dart';
import 'package:service_go/modules/authentication/domain/model/user_type.dart';

class UserData extends Equatable {
  final String id;
  final String username;
  final String email;
  final UserType userType;
  final String? token;

  const UserData(
      {required this.id,
      required this.username,
      required this.email,
      required this.token,
      required this.userType});

  bool get isBengkel => userType == UserType.bengkel;

  bool get isAdmin => userType == UserType.admin;

  @override
  List<Object?> get props => [id, username, email, userType, token];
}
