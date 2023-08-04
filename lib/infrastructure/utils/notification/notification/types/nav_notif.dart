part of '../sg_notification.dart';

enum SGNavigationNotifList {
  customerServis("/customer/servis", false),
  bengkelServis('/bengkel/servis', true);

  final String path;
  final bool isBengkel;
  const SGNavigationNotifList(this.path, this.isBengkel);

  static SGNavigationNotifList fromPath(String path) {
    const values = SGNavigationNotifList.values;
    for (var element in values) {
      if (element.path == path) return element;
    }
    throw const BaseException("Unknown Path");
  }
}

class SGNavigationNotif extends SGNotification {
  final SGNavigationNotifList path;

  final Map<String, dynamic>? data;
  SGNavigationNotif(
      {required super.title,
      required super.body,
      required this.path,
      this.data})
      : super(type: NotifType.navigation);

  factory SGNavigationNotif.fromPayload(Map<String, dynamic> payload) =>
      SGNavigationNotif(
          title: "",
          body: "",
          path: SGNavigationNotifList.fromPath(payload["path"]),
          data: jsonDecode(payload["data"]));

  @override
  Map<String, dynamic> _dataJSON() => {"path": path.path, "data": data};

  @override
  void handle() {
    final tobePushedRouter = getRouter();
    if (tobePushedRouter == null) return;
    final appRouter = getIt<AppRouter>();
    appRouter.push(tobePushedRouter);
  }

  void notifyListener() {
    final SendPort? send = IsolateNameServer.lookupPortByName(path.path);
    send?.send(data);
    print("Notifying listener");
  }

  PageRouteInfo? getRouter() {
    try {
      switch (path) {
        case SGNavigationNotifList.bengkelServis:
          return ServisBengkelDetailRoute(servisId: data?["id"]);
        case SGNavigationNotifList.customerServis:
          return ServisCustomerDetailRoute(servisId: data?["id"]);
      }
    } catch (e) {
      return null;
    }
  }
}
