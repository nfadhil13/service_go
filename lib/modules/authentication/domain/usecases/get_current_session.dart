import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/utils/firebase_messanger_util.dart';
import 'package:service_go/infrastructure/utils/notification/notification/sg_notification.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';
import 'package:service_go/modules/authentication/domain/repositories/authentication_repo.dart';

@injectable
class GetCurrentSession
    extends UsecaseNoParams<(UserSession?, SGNavigationNotif?)> {
  final AuthenticationRepo _authenticationRepo;

  GetCurrentSession(this._authenticationRepo);

  @override
  Future<Resource<(UserSession?, SGNavigationNotif?)>> execute() async {
    final session = await _authenticationRepo.getLastLoggedInUser();
    if (session == null) return Resource.success((null, null));
    final lastMessage = await FirebaseHelper.getInitialMessage();
    if (lastMessage == null) return Resource.success((session, null));
    final parsedLastMesssage = SGNotificationParser.parse(lastMessage.data);
    if (parsedLastMesssage is! SGNavigationNotif) {
      return Resource.success((session, null));
    }
    return Resource.success((session, parsedLastMesssage));
  }
}
