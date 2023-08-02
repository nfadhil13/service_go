import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';

part 'status_data/diajukan.dart';
part 'status_data/ditolak.dart';
part 'status_data/pengajuan_diterima.dart';
part 'status_data/unit_diterima.dart';
part 'status_data/unit_diperiksa.dart';
part 'status_data/konfirmasi_servis.dart';
part 'status_data/menungu_pengerjaan.dart';
part 'status_data/pengerjaan_servis.dart';
part 'status_data/siap_diambil.dart';
part 'status_data/servis_selesai.dart';
part 'status_data/dibatalkan.dart';

sealed class ServisStatusData extends Equatable {
  final ServisStatus status;
  final DateTime timestamp;

  ServisStatusData(this.status, {DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [status];
}
