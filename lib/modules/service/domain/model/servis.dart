import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/types/id.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';

class Servis extends Equatable {
  final SGId id;
  final String namaMotor;
  final String platNomor;
  final ServisStatusData statusData;
  final List<JenisLayanan> layanan;
  final DateTime tanggalService;
  final ServisCustomer customer;
  final ServisBengkel bengkel;
  final String catatan;
  final DateTime? waktuMulaiPengerjaan;
  final DateTime? waktuSelesaiPengerjaan;
  final KeteranganServis? keteranganServis;

  Servis(
      {String? id,
      required this.waktuMulaiPengerjaan,
      required this.namaMotor,
      required this.platNomor,
      required this.statusData,
      required this.layanan,
      required this.customer,
      required this.bengkel,
      required this.tanggalService,
      required this.keteranganServis,
      required this.waktuSelesaiPengerjaan,
      this.catatan = ""})
      : id = SGId(id);

  ServisStatus get status => statusData.status;

  Servis copyWith(
      {String? id,
      String? namaMotor,
      String? platNomor,
      ServisStatusData? statusData,
      List<JenisLayanan>? layanan,
      DateTime? tanggalService,
      ServisCustomer? customer,
      ServisBengkel? bengkel,
      String? catatan,
      DateTime? waktuMulaiPengerjaan,
      DateTime? waktuSelesaiPengerjaan,
      String? alasanPenolakan,
      KeteranganServis? keteranganServis}) {
    return Servis(
        waktuSelesaiPengerjaan:
            waktuSelesaiPengerjaan ?? this.waktuSelesaiPengerjaan,
        waktuMulaiPengerjaan: waktuMulaiPengerjaan ?? this.waktuMulaiPengerjaan,
        id: id ?? this.id.id,
        namaMotor: namaMotor ?? this.namaMotor,
        platNomor: platNomor ?? this.platNomor,
        statusData: statusData ?? this.statusData,
        layanan: layanan ?? this.layanan,
        tanggalService: tanggalService ?? this.tanggalService,
        customer: customer ?? this.customer,
        bengkel: bengkel ?? this.bengkel,
        catatan: catatan ?? this.catatan,
        keteranganServis: keteranganServis ?? this.keteranganServis);
  }

  @override
  List<Object?> get props => [
        id,
        namaMotor,
        platNomor,
        statusData,
        layanan,
        customer,
        bengkel,
        tanggalService,
        catatan
      ];
}

class KeteranganServis extends Equatable {
  final String deskripsiServis;
  final DateTime waktuMulai;
  final List<SGImage> attachments;

  const KeteranganServis(
      this.deskripsiServis, this.attachments, this.waktuMulai);

  @override
  List<Object?> get props => [deskripsiServis, attachments];
}

class ServisCustomer extends Equatable {
  final String id;
  final String name;

  const ServisCustomer(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

class ServisBengkel extends Equatable {
  final String id;
  final String name;

  const ServisBengkel(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}
