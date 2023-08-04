part of 'sg_notification.dart';

class SGNotificationParser {
  // When parsing we do not care about the title and body because the data is the important one
  static SGNotification? parse(Map<String, dynamic> data) {
    try {
      final typeIndex = data["type"];
      final type = _types.getAtOrNull(int.parse(typeIndex));

      if (type == null) return null;
      switch (type) {
        case NotifType.navigation:
          final result = SGNavigationNotif.fromPayload(data);

          return result;
        case NotifType.normal:
          return SGNormalNotif.fromPayload();
      }
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);

      return null;
    }
  }
}
