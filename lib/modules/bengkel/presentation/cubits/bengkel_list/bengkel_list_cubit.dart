import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/usecase/get_all_bengkel.dart';

part 'bengkel_list_state.dart';

@injectable
class BengkelListCubit extends Cubit<BengkelListState> {
  final GetAllBengkel _bengkelList;
  BengkelListCubit(this._bengkelList) : super(BengkelListLoading());

  void getBengkelList({SGDataQuery? query}) async {
    emit(BengkelListLoading());
    final usecase = await _bengkelList(query);
    switch (usecase) {
      case Success():
        emit(BengkelListSuccess(usecase.data));
      case Error():
        emit(BengkelListError(usecase.exception));
    }
  }
}
