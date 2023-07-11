import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/types/exceptions/session_exception.dart';

class SGGlobalErrorHandler {
  static const sessionTimeoutPortName = "session_port";

  static void _handleSessionTimeOut() {
    final SendPort? send =
        IsolateNameServer.lookupPortByName(sessionTimeoutPortName);
    send?.send(true);
  }

  static void setUpErrorHandler() {
    final defaultErrorHandler = FlutterError.onError;
    final platformError = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (error, stack) {
      final exception = error;
      if (exception is SessionException) _handleSessionTimeOut();
      return platformError?.call(error, stack) ?? true;
    };
    FlutterError.onError = (details) {
      final exception = details.exception;
      if (exception is SessionException) _handleSessionTimeOut();
      defaultErrorHandler?.call(details);
    };
  }
}
