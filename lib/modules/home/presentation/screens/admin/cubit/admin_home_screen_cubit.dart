import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/home/domain/usecases/prerpare_admin_home.dart';

part 'admin_home_screen_state.dart';

@injectable
class AdminHomeScreenCubit extends Cubit<AdminHomeScreenState> {
  final PrepareAdminHome _prepareAdminHome;
  AdminHomeScreenCubit(this._prepareAdminHome)
      : super(AdminHomeScreenLoading());

  void prepare() async {
    emit(AdminHomeScreenLoading());
    final result = await _prepareAdminHome();
    switch (result) {
      case Success():
        final data = result.data;
        emit(AdminHomeScreenSuccess(
            servisCount: data.servisCount,
            customerCount: data.userCount,
            jenisLayananCout: data.jenisCount,
            bengkelCount: data.bengkelCount));
      case Error():
        emit(AdminHomeScreenError(result.exception.message));
    }
  }
}
