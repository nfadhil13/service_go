import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/utils/notification/notification/sg_notification.dart';
import 'package:service_go/infrastructure/utils/notification/push_notification_util.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';
import 'package:service_go/modules/service/domain/repositories/servis_notif_repo.dart';

@Injectable(as: ServisNotifRepo)
class ServisNotifRepoImpl implements ServisNotifRepo {
  final PushNotificationUtil _pushNotificationUtil;

  ServisNotifRepoImpl(this._pushNotificationUtil);

  List<(String userId, SGNavigationNotif notif)> getNotifDetail(
      Servis servis, String servisId) {
    final statusData = servis.statusData;
    final data = {"id": servisId};
    switch (statusData) {
      case ServisStatusDiajukan():
        return [
          (
            servis.bengkel.id,
            SGNavigationNotif(
                title: "Pengajuan Servis Baru!",
                data: data,
                body:
                    "Anda mendapatkan pengajuan servis baru (${servis.namaMotor})",
                path: SGNavigationNotifList.bengkelServis)
          )
        ];
      case ServisStatusPengajuanDiterima():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Pengajuan Servis Diterima!",
                data: data,
                body:
                    "Pengajuan servis ${servis.namaMotor} anda diterima. Hubungi bengkel untuk proses penyerahan unit",
                path: SGNavigationNotifList.customerServis)
          )
        ];
      case ServisStatusUnitDiterima():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Unit Servis Diterima Bengkel!",
                data: data,
                body:
                    "Unit motor ${servis.namaMotor} anda telah diterima oleh bengkel.",
                path: SGNavigationNotifList.customerServis)
          )
        ];
      case ServisStatusUnitDiPeriksa():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Unit Servis Diperiksa Bengkel!",
                data: data,
                body:
                    "Unit motor ${servis.namaMotor} anda sedang dalam proses pemeriksaan.",
                path: SGNavigationNotifList.customerServis)
          )
        ];
      case ServisStatusUnitKonfirmasiServis():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Unit Selesai Diperiksa!",
                data: data,
                body:
                    "Unit motor ${servis.namaMotor} anda telah diperiksa. Silahkan konfirmasi apakah anda menerima pengajuan servis dari bengkel.",
                path: SGNavigationNotifList.customerServis)
          )
        ];
      case ServisStatusMenungguPengerjaan():
        return [
          (
            servis.bengkel.id,
            SGNavigationNotif(
                title: "Pengajuan Servis Diterima!",
                data: data,
                body:
                    "Pengajuan servis untuk pesanan $servisId (${servis.namaMotor}) sudah diterima oleh pengguna. Bengkel dapat memulai pengerjaan!",
                path: SGNavigationNotifList.bengkelServis)
          )
        ];
      case ServisStatusPengerjaanServis():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Unit Sedang diperbaiki!",
                data: data,
                body:
                    "Unit motor ${servis.namaMotor} anda sedang diperbaiki oleh bengkel",
                path: SGNavigationNotifList.customerServis)
          )
        ];
      case ServisStatusSiapDiambil():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Unit Siap Diambil!",
                data: data,
                body:
                    "Unit motor ${servis.namaMotor} anda selesai diperbaiki bengkel dan siap diambil!",
                path: SGNavigationNotifList.customerServis)
          )
        ];
      case ServisStatusSelesai():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Servis Selesai !",
                data: data,
                body:
                    "Unit motor ${servis.namaMotor} anda sudah diambil oleh ${statusData.namaPengambil}. Terimakasih sudah menggunakan layanan Servis GO",
                path: SGNavigationNotifList.customerServis)
          ),
          (
            servis.bengkel.id,
            SGNavigationNotif(
                title: "Servis Selesai!",
                data: data,
                body:
                    "Pesanan $servisId (${servis.namaMotor}) sudah selesai. Motor diserahkan oleh ${statusData.picBengkel} kepada ${statusData.namaPengambil}",
                path: SGNavigationNotifList.bengkelServis)
          )
        ];
      case ServisStatusDitolak():
        return [
          (
            servis.customer.id,
            SGNavigationNotif(
                title: "Servis Ditolak !",
                data: data,
                body:
                    "Permintaan Servis untuk unit ${servis.namaMotor} anda ditolak. Silahkan lihat detail untuk melihat alasan penolakan",
                path: SGNavigationNotifList.customerServis)
          ),
        ];
      case ServisStatusDibatalkan():
        return [
          if (statusData.isDibatalkanBengkel)
            (
              servis.customer.id,
              SGNavigationNotif(
                  title: "Servis Dibatalkan!",
                  data: data,
                  body:
                      "Setelah proses pemeriksaan ,permintaan Servis untuk unit ${servis.namaMotor} anda dibatalkan. Silahkan lihat detail untuk melihat alasan pembatalan",
                  path: SGNavigationNotifList.customerServis)
            ),
          if (!statusData.isDibatalkanBengkel)
            (
              servis.bengkel.id,
              SGNavigationNotif(
                  title: "Servis Dibatalkan!",
                  data: data,
                  body:
                      "Konfirmasi Servis Unit ${servis.namaMotor} Nopol ${servis.platNomor} ditolak pengguna. Silahkan lihat detail servis untuk melihat alasan penolakan",
                  path: SGNavigationNotifList.bengkelServis)
            ),
        ];
      default:
        return [];
    }
  }

  @override
  Future<void> addNotif(Servis servis) async {
    final id = servis.id.id;
    if (id == null) return;
    final generatedNotif = getNotifDetail(servis, id);
    for (var element in generatedNotif) {
      final (userId, notif) = element;
      _pushNotificationUtil.sendNotificationToUser(userId, notification: notif);
    }
  }
}
