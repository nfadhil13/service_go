import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/utils/notification/notification/sg_notification.dart';
import 'package:service_go/modules/authentication/data/datasource/remote/user_data_remote_dts.dart';

abstract class PushNotificationUtil {
  Future<void> sendNotificationToUser(String userId,
      {required SGNotification notification});
}

@Injectable(as: PushNotificationUtil)
class PushNotificationUtilImpl implements PushNotificationUtil {
  final UserDataRemoteDTS _userDataRemoteDTS;

  PushNotificationUtilImpl(this._userDataRemoteDTS);

  @override
  Future<void> sendNotificationToUser(String userId,
      {required SGNotification notification}) async {
    final userToken =
        await _userDataRemoteDTS.fetchById(userId).map((value) => value?.token);
    if (userToken == null) return;
    try {
      await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            "Authorization":
                "key=AAAAUz4eMq8:APA91bHI4HPgMJ7yeTqnb61hPYYvl6_kiBnGbxIzeV8aK2pTEmG_sk6lgtnogIB8mlJ7MgQcgJbJ_l1H5Jb6a0ER-8fxLDgYlCofdfMP-qsKaRJcT56wnQvTntAMVWbPIxdxdeObnktR",
            "Content-Type": "application/json"
          },
          body: jsonEncode(notification.buildBody(userToken)));
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);
    }
  }
}
