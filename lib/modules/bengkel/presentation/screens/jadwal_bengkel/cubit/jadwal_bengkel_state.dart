part of 'jadwal_bengkel_cubit.dart';

sealed class JadwalBengkelState extends Equatable {
  const JadwalBengkelState();

  @override
  List<Object> get props => [];
}

class JadwalBengkelLoading extends JadwalBengkelState {}

class JadwalBengkelIdle extends JadwalBengkelState {
  final JadwalBengkel jadwalBengkel;
  final String bengkelId;
  final bool isUpdated;

  const JadwalBengkelIdle(this.jadwalBengkel, this.bengkelId,
      {this.isUpdated = false});

  JadwalBengkelPostLoading loading() =>
      JadwalBengkelPostLoading(jadwalBengkel, bengkelId, isUpdated: isUpdated);
}

class JadwalBengkelError extends JadwalBengkelState {
  final String message;

  const JadwalBengkelError(this.message);
}

class JadwalBengkelPostLoading extends JadwalBengkelIdle {
  const JadwalBengkelPostLoading(super.jadwalBengkel, super.bengkelId,
      {super.isUpdated = false});
}
