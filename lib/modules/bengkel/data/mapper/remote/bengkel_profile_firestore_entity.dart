import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/lat_lgn.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';

class BengkelProfileFirestoreEntity extends FireStoreMapper<BengkelProfile> {
  final FireStoreField<BengkelProfile, String> alamatLengkap =
      FireStoreField("alamatLengkap", (entity) => entity.alamant);

  final FireStoreField<BengkelProfile, String> nama =
      FireStoreField("nama", (entity) => entity.nama);

  final FireStoreField<BengkelProfile, String> nomorTelepon =
      FireStoreField("nomorTelepon", (entity) => entity.nomorTelepon);

  final LatLgnFirestoreField<BengkelProfile> lokasi =
      LatLgnFirestoreField("lokasi", (entity) => entity.lokasi);

  final FireStoreField<BengkelProfile, bool> isOpen =
      FireStoreField("isOpen", (entity) => entity.isCurrentlyOpen);

  final JadwalBengkelFirestoreField jadwalBengkel =
      JadwalBengkelFirestoreField("waktuOperasional");

  BengkelProfileFirestoreEntity();

  @override
  BengkelProfile toDomain(Map<String, dynamic> firestoreData, String id) {
    return BengkelProfile(
        alamant: alamatLengkap.parseJSON(firestoreData),
        nama: nama.parseJSON(firestoreData),
        id: id,
        isCurrentlyOpen: isOpen.parseJSON(firestoreData),
        jadwalBengkel: jadwalBengkel.parseJSON(firestoreData),
        nomorTelepon: nomorTelepon.parseJSON(firestoreData),
        lokasi: lokasi.parseJSON(firestoreData).let(
            (value) => LatLgn(lat: value.latitude, long: value.longitude)));
  }

  @override
  List<FireStoreField<BengkelProfile, dynamic>> get fields =>
      [alamatLengkap, isOpen, nama, lokasi, nomorTelepon, jadwalBengkel];
}

class JadwalBengkelFirestoreField
    extends FireStoreField<BengkelProfile, JadwalBengkel> {
  JadwalBengkelFirestoreField(String key)
      : super(key, (entity) => entity.jadwalBengkel);

  TimeOfDay parseTime(String time,
      {int defaultHour = 7, int defaultMinute = 0}) {
    final splittedTime = time.split(":");
    final hour =
        splittedTime.getAtOrNull(0)?.let((value) => int.tryParse(value)) ??
            defaultHour;
    final minute =
        splittedTime.getAtOrNull(1)?.let((value) => int.tryParse(value)) ??
            defaultMinute;
    return TimeOfDay(hour: hour, minute: minute);
  }

  (TimeOfDay, TimeOfDay) parseJadwal(Map<String, dynamic>? jadwal) {
    if (jadwal == null) {
      return const (
        TimeOfDay(hour: 7, minute: 0),
        TimeOfDay(hour: 15, minute: 0)
      );
    }
    return (parseTime(jadwal["start"] ?? ""), parseTime(jadwal["end"] ?? ""));
  }

  @override
  toField(JadwalBengkel data) {
    return [
      toJSON(data.monday),
      toJSON(data.teusday),
      toJSON(data.wednesday),
      toJSON(data.thursday),
      toJSON(data.friday),
      toJSON(data.saturday),
      toJSON(data.sunday)
    ];
  }

  Map<String, dynamic> toJSON((TimeOfDay start, TimeOfDay end) data) {
    final (start, end) = data;
    return {
      "start": "${start.hour}:${start.minute}",
      "end": "${end.hour}:${end.minute}"
    };
  }

  @override
  JadwalBengkel parseJSON(Map<String, dynamic> firestoreData) {
    final waktuOperasional = firestoreData["waktuOperasional"] as List<dynamic>;

    return JadwalBengkel(
        monday: parseJadwal(waktuOperasional.getAtOrNull(0)),
        teusday: parseJadwal(waktuOperasional.getAtOrNull(1)),
        wednesday: parseJadwal(waktuOperasional.getAtOrNull(2)),
        thursday: parseJadwal(waktuOperasional.getAtOrNull(3)),
        friday: parseJadwal(waktuOperasional.getAtOrNull(4)),
        saturday: parseJadwal(waktuOperasional.getAtOrNull(5)),
        sunday: parseJadwal(waktuOperasional.getAtOrNull(6)));
  }
}
