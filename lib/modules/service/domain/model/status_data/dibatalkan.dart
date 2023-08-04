part of '../servis_status_data.dart';

class ServisStatusDibatalkan extends ServisStatusData {
  final String alasan;
  final bool isDibatalkanBengkel;
  final DataPengambilanServis? dataPengambilanServis;
  ServisStatusDibatalkan(
      {required this.alasan,
      required this.dataPengambilanServis,
      required this.isDibatalkanBengkel})
      : super(ServisStatus.dibatalkan);

  ServisStatusDibatalkan copyWith(
          {String? alasan,
          bool? isDibatalkanBengkel,
          DataPengambilanServis? dataPengambilanServis}) =>
      ServisStatusDibatalkan(
          alasan: alasan ?? this.alasan,
          dataPengambilanServis:
              dataPengambilanServis ?? this.dataPengambilanServis,
          isDibatalkanBengkel: isDibatalkanBengkel ?? this.isDibatalkanBengkel);
}
