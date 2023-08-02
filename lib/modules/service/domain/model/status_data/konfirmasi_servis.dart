part of '../servis_status_data.dart';

class ServisStatusUnitKonfirmasiServis extends ServisStatusData {
  final String deskripsiServis;
  final List<SGImage> attachments;

  ServisStatusUnitKonfirmasiServis(
      {required this.deskripsiServis,
      this.attachments = const [],
      DateTime? timestamp})
      : super(ServisStatus.konfirmasiServis, timestamp: timestamp);

  ServisStatusUnitKonfirmasiServis copyWith(
          {String? deskripsiServis, List<SGImage>? attachments}) =>
      ServisStatusUnitKonfirmasiServis(
          deskripsiServis: deskripsiServis ?? this.deskripsiServis,
          attachments: attachments ?? this.attachments);
}
