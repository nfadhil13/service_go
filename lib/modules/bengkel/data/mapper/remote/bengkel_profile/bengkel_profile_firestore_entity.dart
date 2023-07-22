import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/types/gis/placemark.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/bengkel_profile/bengkel_profile_dto.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';

class BengkelProfileFirestoreEntity extends FireStoreMapper<BengkelProfileDTO> {
  final FireStoreField<BengkelProfileDTO, String> image =
      FireStoreField("profileURL", (entity) => entity.imageURL);

  final AddressFirestoreField<BengkelProfileDTO> alamatLengkap =
      AddressFirestoreField("alamatLengkap", (entity) => entity.alamat);

  final FireStoreField<BengkelProfileDTO, String> nama =
      FireStoreField("nama", (entity) => entity.nama);

  final FireStoreField<BengkelProfileDTO, String> nomorTelepon =
      FireStoreField("nomorTelepon", (entity) => entity.nomorTelepon);

  final LatLgnFirestoreField<BengkelProfileDTO> lokasi =
      LatLgnFirestoreField("lokasi", (entity) => entity.lokasi);

  final FireStoreField<BengkelProfileDTO, bool> isOpen =
      FireStoreField("isOpen", (entity) => entity.isCurrentlyOpen);

  final JadwalBengkelFirestoreField jadwalBengkel =
      JadwalBengkelFirestoreField("waktuOperasional");

  final FirestoreReferenceField<BengkelProfileDTO> layananIds =
      FirestoreReferenceField("layananIds", (entity) => entity.layananIds);
  BengkelProfileFirestoreEntity();

  @override
  BengkelProfileDTO toResult(Map<String, dynamic> firestoreData, String id) {
    return BengkelProfileDTO(
        imageURL: image.parseJSON(firestoreData),
        alamat: alamatLengkap.parseJSON(firestoreData),
        nama: nama.parseJSON(firestoreData),
        id: id,
        layananIds: layananIds.parseJSON(firestoreData),
        isCurrentlyOpen: isOpen.parseJSON(firestoreData),
        jadwalBengkel: jadwalBengkel.parseJSON(firestoreData),
        nomorTelepon: nomorTelepon.parseJSON(firestoreData),
        lokasi: lokasi.parseJSON(firestoreData).let(
            (value) => SGLatLong(lat: value.latitude, long: value.longitude)));
  }

  @override
  List<FireStoreField<BengkelProfileDTO, dynamic>> get fields => [
        alamatLengkap,
        isOpen,
        nama,
        lokasi,
        nomorTelepon,
        jadwalBengkel,
        layananIds,
        image
      ];
}

class JadwalBengkelFirestoreField
    extends FireStoreField<BengkelProfileDTO, JadwalBengkel> {
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
