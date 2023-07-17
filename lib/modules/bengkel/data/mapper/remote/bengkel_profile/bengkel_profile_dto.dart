import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/types/lat_lgn.dart';
import 'package:service_go/infrastructure/types/mapper/dto.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';

class BengkelProfileDTO implements DTO<BengkelProfile, List<JenisLayanan>> {
  final String id;
  final String alamat;
  final String nama;
  final String nomorTelepon;
  final SGLocation lokasi;
  final List<String> layananIds;
  final JadwalBengkel jadwalBengkel;
  final bool isCurrentlyOpen;
  final String imageURL;

  factory BengkelProfileDTO.fromDomain(
      BengkelProfile profile, String imageURL) {
    return BengkelProfileDTO(
        imageURL: imageURL,
        id: profile.id,
        alamat: profile.alamant,
        nama: profile.nama,
        nomorTelepon: profile.nomorTelepon,
        lokasi: profile.lokasi,
        layananIds: profile.jenisLayanan.map((e) => e.id).toList(),
        jadwalBengkel: profile.jadwalBengkel,
        isCurrentlyOpen: profile.isCurrentlyOpen);
  }

  BengkelProfileDTO(
      {required this.id,
      required this.alamat,
      required this.imageURL,
      required this.nama,
      required this.nomorTelepon,
      required this.lokasi,
      required this.layananIds,
      required this.jadwalBengkel,
      required this.isCurrentlyOpen});

  @override
  BengkelProfile toDomain(List<JenisLayanan> params) {
    return BengkelProfile(
        profile: SGNetworkImage(imageURL),
        alamant: alamat,
        nama: nama,
        id: id,
        jenisLayanan: params,
        isCurrentlyOpen: isCurrentlyOpen,
        jadwalBengkel: jadwalBengkel,
        nomorTelepon: nomorTelepon,
        lokasi: lokasi);
  }
}
