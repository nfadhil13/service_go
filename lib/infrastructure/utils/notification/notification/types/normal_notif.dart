part of '../sg_notification.dart';

class SGNormalNotif extends SGNotification {
  SGNormalNotif({required super.title, required super.body})
      : super(type: NotifType.normal);

  factory SGNormalNotif.fromPayload() => SGNormalNotif(title: "", body: "");
}
