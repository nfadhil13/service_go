import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/usecases/get_servis_by_id.dart';

part 'servis_detail_state.dart';

@injectable
class ServisDetailCubit extends Cubit<ServisDetailState> {
  final GetServisById _getServisById;
  ServisDetailCubit(this._getServisById) : super(ServisDetailLoading());

  void getById(String id) async {
    emit(ServisDetailLoading());
    final result = await _getServisById(id);
    switch (result) {
      case Success():
        emit(ServisDetailSuccess(result.data));
      case Error():
        emit(ServisDetailError(result.exception.message));
    }
  }
}
