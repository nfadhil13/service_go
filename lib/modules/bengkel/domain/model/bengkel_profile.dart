import 'package:service_go/infrastructure/types/lat_lgn.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';

class BengkelProfile {
  final String id;
  final String alamant;
  final String nama;
  final String nomorTelepon;
  final LatLgn lokasi;
  final JadwalBengkel jadwalBengkel;
  final bool isCurrentlyOpen;

  const BengkelProfile(
      {required this.alamant,
      required this.nama,
      required this.id,
      required this.isCurrentlyOpen,
      required this.jadwalBengkel,
      required this.nomorTelepon,
      required this.lokasi});
}
