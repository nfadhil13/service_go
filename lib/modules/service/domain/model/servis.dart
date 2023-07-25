import 'package:service_go/infrastructure/types/id.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';

class Servis {
  final SGId id;
  final String namaMotor;
  final String platNomor;
  final ServisStatus status;
  final List<JenisLayanan> layanan;
  final DateTime tanggalService;
  final ServisCustomer customer;
  final ServisBengkel bengkel;
  final String catatan;

  Servis(
      {String? id,
      required this.namaMotor,
      required this.platNomor,
      required this.status,
      required this.layanan,
      required this.customer,
      required this.bengkel,
      required this.tanggalService,
      this.catatan = ""})
      : id = SGId(id);
}

class ServisCustomer {
  final String id;
  final String name;

  ServisCustomer(this.id, this.name);
}

class ServisBengkel {
  final String id;
  final String bengkel;

  ServisBengkel(this.id, this.bengkel);
}
