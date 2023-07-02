import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String id;
  final String username;
  final String email;
  final bool isBengkel;

  const UserData(
      {required this.id,
      required this.username,
      required this.email,
      required this.isBengkel});

  @override
  List<Object?> get props => [id, username, email, isBengkel];
}
