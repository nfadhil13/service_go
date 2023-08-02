part of '../servis_status_data.dart';

class ServisStatusPengerjaanServis extends ServisStatusData {
  ServisStatusPengerjaanServis({DateTime? timestamp})
      : super(ServisStatus.pengerjaanService, timestamp: timestamp);

  DateTime get startTime => timestamp;
}
