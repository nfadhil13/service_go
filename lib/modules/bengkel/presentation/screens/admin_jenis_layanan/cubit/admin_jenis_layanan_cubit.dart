import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/bengkel/domain/usecase/create_new_jenis_layanan.dart';
import 'package:service_go/modules/bengkel/domain/usecase/get_all_jenis_layanan.dart';

part 'admin_jenis_layanan_state.dart';

@injectable
class AdminJenisLayananCubit extends Cubit<AdminJenisLayananState> {
  final GetAllJenisLayanan _getAllJenisLayanan;
  final CreateOrUpdateJenisLayanan _createOrUpdateJenisLayanan;
  final MessengerCubit messengerCubit;
  AdminJenisLayananCubit(this._getAllJenisLayanan,
      this._createOrUpdateJenisLayanan, this.messengerCubit)
      : super(AdminJenisLayananLoading());

  void loadAllJenisLayanan() async {
    emit(AdminJenisLayananLoading());
    final result = await _getAllJenisLayanan();
    switch (result) {
      case Success():
        emit(AdminJenisLayananLoaddedIdle(result.data));
      case Error():
        emit(AdminJenisLayananError(result.exception.message));
    }
  }

  void createOrUpdateJenisLayanan(
      {String? id, required String namaLayanan}) async {
    final state = this.state;
    print(state);
    if (state is! AdminJenisLayananLoaddedIdle) return;
    final result = await _createOrUpdateJenisLayanan(
        CreateOrUpdateJenisLayananParams(
            id: id, namaJenisLayanan: namaLayanan));
    switch (result) {
      case Success():
        loadAllJenisLayanan();
      case Error():
        messengerCubit.showErrorSnackbar(id == null
            ? "Gagal membuat jenis layanan"
            : "Gagal memperbarui jenis layanan");
        emit(state);
    }
  }
}
