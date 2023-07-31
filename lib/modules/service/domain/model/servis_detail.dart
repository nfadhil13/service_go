import 'package:equatable/equatable.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';

class ServisDetail extends Equatable {
  final Servis servis;
  final BengkelProfile bengkelProfile;

  const ServisDetail(this.servis, this.bengkelProfile);

  @override
  List<Object?> get props => [bengkelProfile, servis];
}
