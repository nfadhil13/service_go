import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/usecases/create_or_update_servis.dart';
import 'package:service_go/modules/service/domain/usecases/get_servis_by_id.dart';

part 'servis_detail_state.dart';

@injectable
class ServisDetailCubit extends Cubit<ServisDetailState> {
  final GetServisById _getServisById;
  final CreateOrUpdateServis _createOrUpdateServis;
  final MessengerCubit _messengerCubit;
  ServisDetailCubit(
      this._getServisById, this._createOrUpdateServis, this._messengerCubit)
      : super(ServisDetailLoading());

  void getById(String id) async {
    print("Get by id");
    emit(ServisDetailLoading());
    final result = await _getServisById(id);
    switch (result) {
      case Success():
        emit(ServisDetailSuccessIdle(result.data));
      case Error():
        emit(ServisDetailError(result.exception.message));
    }
  }

  void updateServis(
      {required Servis Function(Servis currentServis) currentServisUpdater,
      String? onErrorText,
      String? onSuccessText}) async {
    final state = this.state;
    if (state is! ServisDetailSuccess) return;
    final newServis = currentServisUpdater(state.servis.servis);
    emit(ServisDetailSuccessUpdating(state.servis));
    final result = await _createOrUpdateServis(newServis);
    switch (result) {
      case Success():
        _messengerCubit
            .showSuccessSnackbar(onSuccessText ?? "Berhasil mengupdate servis");
        getById(result.data.id.id!);
      case Error():
        _messengerCubit
            .showErrorSnackbar(onErrorText ?? "Gagal mengupdate servis");
        emit(ServisDetailSuccessIdle(state.servis));
    }
  }
}
