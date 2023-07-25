import 'package:flutter/material.dart';

typedef JadwalBengkelItem = (TimeOfDay open, TimeOfDay close);

const _default =
    (TimeOfDay(hour: 7, minute: 0), TimeOfDay(hour: 16, minute: 0));

class JadwalBengkel {
  final JadwalBengkelItem? monday;
  final JadwalBengkelItem? teusday;
  final JadwalBengkelItem? wednesday;
  final JadwalBengkelItem? thursday;
  final JadwalBengkelItem? friday;
  final JadwalBengkelItem? saturday;
  final JadwalBengkelItem? sunday;

  const JadwalBengkel({
    this.monday = _default,
    this.teusday = _default,
    this.wednesday = _default,
    this.thursday = _default,
    this.friday = _default,
    this.saturday = _default,
    this.sunday = _default,
  });

  Map<int, JadwalBengkelItem?> get asList => {
        DateTime.monday: monday,
        DateTime.tuesday: teusday,
        DateTime.wednesday: wednesday,
        DateTime.thursday: thursday,
        DateTime.friday: friday,
        DateTime.saturday: saturday,
        DateTime.sunday: sunday
      };
}
