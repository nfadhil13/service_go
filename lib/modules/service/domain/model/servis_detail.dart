import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/service/domain/model/data_pengambilan.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';

class ServisDetail extends Equatable {
  final Servis servis;
  final BengkelProfile bengkelProfile;
  final List<ServisStatusData> logs;
  final DataPengambilanServis? dataPengambilanServis;

  const ServisDetail(this.servis, this.bengkelProfile, this.logs,
      {required this.dataPengambilanServis});

  @override
  List<Object?> get props =>
      [bengkelProfile, servis, logs, dataPengambilanServis];

  ServisDetail copyWith({
    Servis? servis,
    BengkelProfile? bengkelProfile,
    List<ServisStatusData>? logs,
    DataPengambilanServis? dataPengambilanServis,
  }) {
    return ServisDetail(
      servis ?? this.servis,
      bengkelProfile ?? this.bengkelProfile,
      logs ?? this.logs,
      dataPengambilanServis:
          dataPengambilanServis ?? this.dataPengambilanServis,
    );
  }
}
