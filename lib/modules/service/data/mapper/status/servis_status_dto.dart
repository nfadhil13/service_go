import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/types/mapper/dto.dart';
import 'package:service_go/modules/service/domain/model/data_pengambilan.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';

class ServisStatusDataDTO implements DTONoParams<ServisStatusData> {
  final String id;
  final Timestamp timestamp;
  final Map<String, dynamic> detailData;

  ServisStatusDataDTO(this.id, this.timestamp, this.detailData);

  static Map<String, dynamic> getDetailData(ServisStatusData data) {
    switch (data) {
      case ServisStatusSiapDiambil():
      case ServisStatusPengerjaanServis():
      case ServisStatusMenungguPengerjaan():
      case ServisStatusPengajuanDiterima():
      case ServisStatusUnitDiPeriksa():
      case ServisStatusDiajukan():
        return {};
      case ServisStatusDitolak():
        return {"alasan": data.alasanPenolakan};
      case ServisStatusUnitDiterima():
        return {"namaPenerima": data.namaPenerima};

      case ServisStatusUnitKonfirmasiServis():
        return {
          "deskripsiServis": data.deskripsiServis,
          "attachments": data.attachments
              .whereType<SGNetworkImage>()
              .map((e) => e.data)
              .toList()
        };
      case ServisStatusSelesai():
        return {
          "picBengkel": data.picBengkel,
          "namaPengambil": data.namaPengambil,
          "bukti": data.bukti
              .whereType<SGNetworkImage>()
              .map((e) => e.data)
              .toList(),
          "catatan": data.catatan
        };
      case ServisStatusDibatalkan():
        return {
          "alasan": data.alasan,
          "dataPengembalian": data.dataPengambilanServis?.let((value) => {
                "picBengkel": value.picBengkel,
                "namaPengambil": value.namaPengambil,
                "bukti": value.bukti
                    .whereType<SGNetworkImage>()
                    .map((e) => e.data)
                    .toList(),
                "catatan": value.catatan,
                "tanggalPengambilan": FieldValue.serverTimestamp()
              }),
          "isDibatalkanBengkel": data.isDibatalkanBengkel
        };
    }
  }

  factory ServisStatusDataDTO.fromParent(ServisStatusData data,
      {bool useServerTimestamp = false}) {
    final detailData = getDetailData(data);
    return ServisStatusDataDTO(data.status.id.toString(),
        Timestamp.fromDate(data.timestamp), detailData);
  }

  @override
  ServisStatusData toDomain() {
    final status = ServisStatus.fromID(int.parse(id));
    final date = timestamp.toDate();
    switch (status) {
      case ServisStatus.diajukan:
        return ServisStatusDiajukan(timestamp: date);
      case ServisStatus.ditolak:
        return ServisStatusDitolak(
            alasanPenolakan: detailData["alasan"], timestamp: date);
      case ServisStatus.pengajuanDiterima:
        return ServisStatusPengajuanDiterima(timestamp: date);
      case ServisStatus.unitDiterima:
        return ServisStatusUnitDiterima(
            namaPenerima: detailData["namaPenerima"], timestamp: date);
      case ServisStatus.unitDiperiksa:
        return ServisStatusUnitDiPeriksa(timestamp: date);
      case ServisStatus.konfirmasiServis:
        return ServisStatusUnitKonfirmasiServis(
            timestamp: date,
            deskripsiServis: detailData["deskripsiServis"],
            attachments: (detailData["attachments"] as List)
                .map((e) => SGNetworkImage(e.toString()))
                .toList());
      case ServisStatus.menungguPengerjaan:
        return ServisStatusMenungguPengerjaan(timestamp: date);
      case ServisStatus.pengerjaanService:
        return ServisStatusPengerjaanServis(timestamp: date);
      case ServisStatus.siapDiambil:
        return ServisStatusSiapDiambil(timestamp: date);
      case ServisStatus.serviceSelesai:
        return ServisStatusSelesai(
            picBengkel: detailData["picBengkel"],
            namaPengambil: detailData["namaPengambil"],
            bukti: (detailData["bukti"] as List)
                .map((e) => SGNetworkImage(e.toString()))
                .toList(),
            catatan: detailData["catatan"]);
      case ServisStatus.dibatalkan:
        return ServisStatusDibatalkan(
            isDibatalkanBengkel: detailData["isDibatalkanBengkel"],
            alasan: detailData["alasan"],
            dataPengambilanServis:
                (detailData["dataPengembalian"] as Map<String, dynamic>?)?.let(
                    (value) => DataPengambilanServis(
                        isDibatalkan: true,
                        tanggalPengambilan:
                            (value["tanggalPengambilan"] as Timestamp).toDate(),
                        picBengkel: value["picBengkel"],
                        namaPengambil: value["namaPengambil"],
                        bukti: (value["bukti"] as List)
                            .map((e) => SGNetworkImage(e.toString()))
                            .toList(),
                        catatan: value["catatan"])));
    }
  }
}
