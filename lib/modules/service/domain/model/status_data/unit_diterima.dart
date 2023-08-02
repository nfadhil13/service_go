part of '../servis_status_data.dart';

class ServisStatusUnitDiterima extends ServisStatusData {
  final String namaPenerima;
  ServisStatusUnitDiterima({required this.namaPenerima, DateTime? timestamp})
      : super(ServisStatus.unitDiterima, timestamp: timestamp);
}
