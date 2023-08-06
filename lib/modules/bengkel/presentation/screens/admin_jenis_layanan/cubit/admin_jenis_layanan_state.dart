part of 'admin_jenis_layanan_cubit.dart';

sealed class AdminJenisLayananState extends Equatable {
  const AdminJenisLayananState();

  @override
  List<Object> get props => [];
}

class AdminJenisLayananLoading extends AdminJenisLayananState {}

class AdminJenisLayananError extends AdminJenisLayananState {
  final String message;

  const AdminJenisLayananError(this.message);
}

sealed class AdminJenisLayananLoadded extends AdminJenisLayananState {
  final List<JenisLayanan> jenisLayananList;

  const AdminJenisLayananLoadded(this.jenisLayananList);

  @override
  List<Object> get props => [jenisLayananList];
}

class AdminJenisLayananLoaddedIdle extends AdminJenisLayananLoadded {
  const AdminJenisLayananLoaddedIdle(super.jenisLayananList);
}

class AdminJenisLayananLoaddedUploading extends AdminJenisLayananLoadded {
  const AdminJenisLayananLoaddedUploading(super.jenisLayananList);
}
