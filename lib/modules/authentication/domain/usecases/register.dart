import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/nothing.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/authentication/domain/model/user_register_data.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';

@injectable
class RegisterUserAccount extends Usecase<UserRegisterData, Nothing> {
  final AuthenticationRepo _authenticationRepo;

  RegisterUserAccount(this._authenticationRepo);

  @override
  Future<Resource<Nothing>> execute(UserRegisterData params) =>
      _authenticationRepo.registerUser(params).asResourceOfNothing;
}
