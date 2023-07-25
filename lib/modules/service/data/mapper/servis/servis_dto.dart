import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/types/mapper/dto.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';

class ServisDTOParams {
  final ServisCustomer customer;
  final ServisBengkel bengkel;
  final List<JenisLayanan> jenisLayanan;

  ServisDTOParams(
      {required this.customer,
      required this.bengkel,
      required this.jenisLayanan});
}

class ServisDTO implements DTO<Servis, ServisDTOParams> {
  final String id;
  final String namaMotor;
  final String platNomor;
  final List<String> layananIds;
  final Timestamp tanggalService;
  final String customerId;
  final String bengkelId;
  final String catatan;
  final int status;

  ServisDTO(
      {required this.id,
      required this.namaMotor,
      required this.platNomor,
      required this.status,
      required this.layananIds,
      required this.tanggalService,
      required this.customerId,
      required this.bengkelId,
      required this.catatan});

  factory ServisDTO.fromDomain(Servis servis) {
    return ServisDTO(
        id: servis.id.id ?? "",
        namaMotor: servis.namaMotor,
        platNomor: servis.platNomor,
        layananIds: servis.layanan.map((e) => e.id).toList(),
        tanggalService: Timestamp.fromDate(servis.tanggalService),
        customerId: servis.customer.id,
        bengkelId: servis.bengkel.id,
        catatan: servis.catatan,
        status: servis.status.id);
  }

  @override
  Servis toDomain(ServisDTOParams params) {
    return Servis(
        namaMotor: namaMotor,
        platNomor: platNomor,
        layanan: params.jenisLayanan,
        customer: params.customer,
        bengkel: params.bengkel,
        catatan: catatan,
        id: id,
        status: ServisStatus.fromID(status),
        tanggalService: tanggalService.toDate());
  }
}
