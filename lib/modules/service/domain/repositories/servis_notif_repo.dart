import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_notif.dart';

abstract class ServisNotifRepo {
  Future<void> addNotif(Servis servis);
}
