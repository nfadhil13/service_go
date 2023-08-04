import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/routing/router.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';

part 'types/normal_notif.dart';
part 'types/nav_notif.dart';
part 'parser.dart';

enum NotifType {
  normal,
  navigation;
}

const _types = NotifType.values;

sealed class SGNotification {
  final String title;
  final String body;

  final NotifType type;

  SGNotification({
    required this.title,
    required this.body,
    required this.type,
  });

  void handle() {}

  Map<String, String> _notification() => {"title": title, "body": body};

  Map<String, dynamic> _dataJSON() => {};

  Map<String, dynamic> buildBody(String token) => {
        "to": token,
        "notification": _notification(),
        "data": {"type": type.index, ..._dataJSON()}
      };
}
