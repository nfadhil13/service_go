part of '../servis_status_data.dart';

class ServisStatusDitolak extends ServisStatusData {
  final String alasanPenolakan;
  ServisStatusDitolak({required this.alasanPenolakan, DateTime? timestamp})
      : super(ServisStatus.ditolak, timestamp: timestamp);

  @override
  List<Object?> get props => [alasanPenolakan];
}
