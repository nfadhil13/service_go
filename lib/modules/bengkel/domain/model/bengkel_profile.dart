import 'package:service_go/infrastructure/types/gis/distance.dart';
import 'package:service_go/infrastructure/types/gis/placemark.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

import 'package:equatable/equatable.dart';

class BengkelProfile extends Equatable {
  final String id;
  final SGImage profile;
  final SGAddress alamat;
  final String nama;
  final String nomorTelepon;
  final SGLatLong lokasi;
  final List<JenisLayanan> jenisLayanan;
  final JadwalBengkel jadwalBengkel;
  final bool isCurrentlyOpen;

  const BengkelProfile({
    required this.alamat,
    required this.nama,
    required this.profile,
    required this.id,
    required this.jenisLayanan,
    required this.isCurrentlyOpen,
    required this.jadwalBengkel,
    required this.nomorTelepon,
    required this.lokasi,
  });

  BengkelProfile copyWith({
    SGImage? profile,
    SGAddress? alamat,
    String? nama,
    String? nomorTelepon,
    SGLatLong? lokasi,
    List<JenisLayanan>? jenisLayanan,
    JadwalBengkel? jadwalBengkel,
    bool? isCurrentlyOpen,
  }) {
    return BengkelProfile(
      id: this.id,
      profile: profile ?? this.profile,
      alamat: alamat ?? this.alamat,
      nama: nama ?? this.nama,
      nomorTelepon: nomorTelepon ?? this.nomorTelepon,
      lokasi: lokasi ?? this.lokasi,
      jenisLayanan: jenisLayanan ?? this.jenisLayanan,
      jadwalBengkel: jadwalBengkel ?? this.jadwalBengkel,
      isCurrentlyOpen: isCurrentlyOpen ?? this.isCurrentlyOpen,
    );
  }

  @override
  List<Object?> get props => [
        id,
        profile,
        alamat,
        nama,
        nomorTelepon,
        lokasi,
        jenisLayanan,
        jadwalBengkel,
        isCurrentlyOpen,
      ];
}

typedef BengkelProfileWithDistance = SGDistance<BengkelProfile>;
