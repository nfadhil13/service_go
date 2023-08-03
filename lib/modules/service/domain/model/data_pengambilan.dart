import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/types/image.dart';

class DataPengambilanServis extends Equatable {
  final String picBengkel;
  final String namaPengambil;
  final List<SGImage> bukti;
  final String catatan;
  final bool isDibatalkan;
  final DateTime tanggalPengambilan;

  const DataPengambilanServis(
      {required this.picBengkel,
      required this.namaPengambil,
      required this.bukti,
      required this.tanggalPengambilan,
      required this.isDibatalkan,
      required this.catatan});
  @override
  List<Object?> get props => [picBengkel, namaPengambil, bukti, catatan];
}
