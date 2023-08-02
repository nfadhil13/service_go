part of '../servis_status_data.dart';

class ServisStatusDibatalkan extends ServisStatusData {
  final String alasan;
  final bool isDikembalikan;
  final bool isDibatalkanBengkel;
  ServisStatusDibatalkan(
      {required this.alasan,
      required this.isDikembalikan,
      required this.isDibatalkanBengkel})
      : super(ServisStatus.dibatalkan);
}
