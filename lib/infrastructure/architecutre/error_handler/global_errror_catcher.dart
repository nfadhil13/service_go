import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/architecutre/error_handler/global_error_handler.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';

class GlobalErrorCatcher extends StatefulWidget {
  final Widget? child;
  final Function()? onSessionExpire;
  const GlobalErrorCatcher({
    super.key,
    required this.child,
    this.onSessionExpire,
  });

  @override
  State<GlobalErrorCatcher> createState() => _GlobalErrorCatcherState();
}

class _GlobalErrorCatcherState extends State<GlobalErrorCatcher> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    print("Current User : ${FirebaseAuth.instance.currentUser}");
    FirebaseFirestore.instance
        .collection("example")
        .snapshots()
        .map((event) => event.docs)
        .listen((event) {
      event.forEach((element) {
        print("Data : ${element.data()}");
      });
    });
    IsolateNameServer.registerPortWithName(
        _port.sendPort, ServiceGoGlobalErrorHandler.sessionTimeoutPortName);
    _port.listen((message) {
      if (message) widget.onSessionExpire?.call();
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping(
        ServiceGoGlobalErrorHandler.sessionTimeoutPortName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
