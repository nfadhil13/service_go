import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/utils/distance_helper.dart';

class SGDistance<Data> extends Equatable {
  final Data data;
  final double distanceInKm;

  const SGDistance({required this.data, required this.distanceInKm});

  String get distranceString => KM(distanceInKm).format();

  @override
  List<Object?> get props => [data, distanceInKm];
}
