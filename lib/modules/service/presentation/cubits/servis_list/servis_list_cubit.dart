import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/usecases/get_servis_list.dart';

part 'servis_list_state.dart';

@injectable
class ServisListCubit extends Cubit<ServisListState> {
  final GetServisList _getServisList;
  ServisListCubit(this._getServisList) : super(ServisListLoading());

  void getServisList({SGDataQuery? query}) async {
    emit(ServisListLoading());
    final usecase = await _getServisList(query);
    switch (usecase) {
      case Success():
        emit(ServisListSuccess(usecase.data));
      case Error():
        emit(ServisListError(usecase.exception));
    }
  }
}
