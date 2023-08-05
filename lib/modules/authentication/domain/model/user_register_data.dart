import 'package:equatable/equatable.dart';
import 'package:service_go/modules/authentication/domain/model/user_type.dart';

class UserRegisterData extends Equatable {
  final String username;
  final String email;
  final String password;
  final UserType isBengkel;
  const UserRegisterData(
      {required this.username,
      required this.email,
      required this.password,
      required this.isBengkel});

  @override
  List<Object?> get props => throw UnimplementedError();
}
