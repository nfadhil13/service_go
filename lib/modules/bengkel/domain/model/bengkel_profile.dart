import 'package:service_go/infrastructure/types/gis/distance.dart';
import 'package:service_go/infrastructure/types/gis/placemark.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

class BengkelProfile {
  final String id;
  final SGImage profile;
  final SGAddress alamat;
  final String nama;
  final String nomorTelepon;
  final SGLatLong lokasi;
  final List<JenisLayanan> jenisLayanan;
  final JadwalBengkel jadwalBengkel;
  final bool isCurrentlyOpen;

  const BengkelProfile(
      {required this.alamat,
      required this.nama,
      required this.profile,
      required this.id,
      required this.jenisLayanan,
      required this.isCurrentlyOpen,
      required this.jadwalBengkel,
      required this.nomorTelepon,
      required this.lokasi});
}

typedef BengkelProfileWithDistance = SGDistance<BengkelProfile>;
