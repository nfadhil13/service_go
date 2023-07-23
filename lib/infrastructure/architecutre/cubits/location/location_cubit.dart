import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/utils/location/location_util.dart';

part 'location_state.dart';

@injectable
class InitialLocationCubit extends Cubit<LocationState> {
  final LocationUtil _locationUtil;
  InitialLocationCubit(this._locationUtil) : super(LocationLoading());

  void getLocation() async {
    emit(LocationLoading());
    final location = await _locationUtil.getCurrentLocation();
    emit(LocationSuccess(location));
  }
}

class LocationProvider extends StatefulWidget {
  final SGLocation location;
  final Widget child;
  const LocationProvider(
      {Key? key, required this.location, required this.child})
      : super(key: key);

  @override
  State<LocationProvider> createState() => _LocationProviderState();
}

class _LocationProviderState extends State<LocationProvider> {
  late SGLocation _location;

  @override
  void initState() {
    super.initState();
    _location = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    return LocationScope(
      changeLocation: (location) {
        setState(() {
          _location = location;
        });
      },
      location: _location,
      child: widget.child,
    );
  }
}

class LocationScope extends InheritedWidget {
  final SGLocation location;
  final void Function(SGLocation location) changeLocation;
  const LocationScope(
      {Key? key,
      required this.location,
      required super.child,
      required this.changeLocation})
      : super(key: key);

  static LocationScope of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<LocationScope>();
    if (widget == null) {
      throw Exception("Cant Found Location Provider in the tree");
    }
    return widget;
  }

  @override
  bool updateShouldNotify(LocationScope oldWidget) {
    return oldWidget.location.latLgn != location.latLgn;
  }
}
