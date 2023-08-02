part of '../servis_status_data.dart';

class ServisStatusSelesai extends ServisStatusData {
  final String picBengkel;
  final String namaPengambil;
  final SGImage bukti;
  final String catatan;
  ServisStatusSelesai(
      {required this.picBengkel,
      required this.namaPengambil,
      required this.bukti,
      required this.catatan})
      : super(ServisStatus.serviceSelesai);

  ServisStatusSelesai copyWith({
    String? picBengkel,
    String? namaPengambil,
    SGImage? bukti,
    String? catatan,
  }) =>
      ServisStatusSelesai(
          picBengkel: picBengkel ?? this.picBengkel,
          namaPengambil: namaPengambil ?? this.namaPengambil,
          bukti: bukti ?? this.bukti,
          catatan: catatan ?? this.catatan);
}
