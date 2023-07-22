import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/architecutre/cubits/location/location_cubit.dart';
import 'package:service_go/infrastructure/architecutre/cubits/session/session_cubit.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';

extension CtxExt on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  UserSession get userSession => read<SessionCubit>().state.session!;
  SGLocation get currentLocation => read<LocationForceCubit>().state;
  void logout() => read<SessionCubit>().logOut();
}
