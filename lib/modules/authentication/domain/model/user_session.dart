import 'package:equatable/equatable.dart';
import 'package:service_go/modules/user/domain/models/user.dart';

class UserSession extends Equatable {
  final String token;
  final DateTime expiredTime;
  final User user;

  const UserSession(
      {required this.token, required this.expiredTime, required this.user});

  @override
  List<Object?> get props => [token, expiredTime, user];
}
