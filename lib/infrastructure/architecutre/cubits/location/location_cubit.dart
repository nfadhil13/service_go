import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/utils/location/location_util.dart';

part 'location_state.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final LocationUtil _locationUtil;
  LocationCubit(this._locationUtil) : super(LocationLoading());

  void getLocation() async {
    emit(LocationLoading());
    final location = await _locationUtil.getCurrentLocation();
    emit(LocationSuccess(location));
  }
}

class LocationForceCubit extends Cubit<SGLocation> {
  LocationForceCubit(super.initialState);
}
