import 'package:equatable/equatable.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';

class ServisDetail extends Equatable {
  final Servis servis;
  final BengkelProfile bengkelProfile;
  final List<ServisStatusData> logs;

  const ServisDetail(this.servis, this.bengkelProfile, this.logs);

  @override
  List<Object?> get props => [bengkelProfile, servis, logs];
}
