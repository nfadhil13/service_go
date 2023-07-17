import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/types/lat_lgn.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

class BengkelProfile {
  final String id;
  final SGImage profile;
  final String alamant;
  final String nama;
  final String nomorTelepon;
  final SGLocation lokasi;
  final List<JenisLayanan> jenisLayanan;
  final JadwalBengkel jadwalBengkel;
  final bool isCurrentlyOpen;

  const BengkelProfile(
      {required this.alamant,
      required this.nama,
      required this.profile,
      required this.id,
      required this.jenisLayanan,
      required this.isCurrentlyOpen,
      required this.jadwalBengkel,
      required this.nomorTelepon,
      required this.lokasi});
}
