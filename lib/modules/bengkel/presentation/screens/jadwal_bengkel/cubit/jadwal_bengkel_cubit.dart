import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/usecase/get_jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/domain/usecase/update_jadwal_bengkel.dart';

part 'jadwal_bengkel_state.dart';

@injectable
class JadwalBengkelCubit extends Cubit<JadwalBengkelState> {
  final UpdateJadwalBengkel _updateJadwalBengkel;
  final GetJadwalBengkel _getJadwalBengkel;
  final MessengerCubit messengerCubit;
  JadwalBengkelCubit(
      this.messengerCubit, this._getJadwalBengkel, this._updateJadwalBengkel)
      : super(JadwalBengkelLoading());

  void getJadwalBengkel(String userId) async {
    emit(JadwalBengkelLoading());
    final result = await _getJadwalBengkel((userId,));
    switch (result) {
      case Success():
        emit(JadwalBengkelIdle(result.data, userId));
      case Error():
        emit(JadwalBengkelError(result.exception.message));
    }
  }

  void updateJadwalBengkel(JadwalBengkel jadwalBengkel) async {
    final state = this.state;
    if (state is! JadwalBengkelIdle) return;
    emit(state.loading());
    final result = await _updateJadwalBengkel(UpdateJadwalBengkelParams(
        userId: state.bengkelId, jadwalBengkel: jadwalBengkel));
    switch (result) {
      case Success():
        emit(JadwalBengkelIdle(result.data, state.bengkelId, isUpdated: true));
      case Error():
        messengerCubit.showErrorSnackbar("Gagal memperbarui Jadwal");
        emit(JadwalBengkelIdle(jadwalBengkel, state.bengkelId,
            isUpdated: false));
    }
  }
}
