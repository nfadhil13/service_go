import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/profile/domain/usecase/bengkel/get_customer_profile.dart';

part 'bengkel_profile_state.dart';

@injectable
class BengkelProfileScreenCubit extends Cubit<BengkelProfileScreenState> {
  final GetBengkelProfile _getBengkelProfile;
  BengkelProfileScreenCubit(this._getBengkelProfile)
      : super(BengkelProfileScreenLoading());

  void setBengkel(BengkelProfile bengkelProfile) {
    emit(BengkelProfileScreenSuccess(bengkelProfile));
  }

  void getBengkelProfile(String userId) async {
    emit(BengkelProfileScreenLoading());
    final result = await _getBengkelProfile((userId,));
    switch (result) {
      case Success():
        final profile = result.data;
        if (profile == null) {
          emit(BengkelProfileScreenError(
              "Profile Not Found", () => getBengkelProfile(userId)));
          return;
        }
        emit(BengkelProfileScreenSuccess(profile));
      case Error():
        emit(BengkelProfileScreenError(
            result.exception.message, () => getBengkelProfile(userId)));
    }
  }
}
