import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String id;
  final String username;
  final String email;
  final bool isBengkel;
  final String? token;

  const UserData(
      {required this.id,
      required this.username,
      required this.email,
      required this.token,
      required this.isBengkel});

  @override
  List<Object?> get props => [id, username, email, isBengkel, token];
}
