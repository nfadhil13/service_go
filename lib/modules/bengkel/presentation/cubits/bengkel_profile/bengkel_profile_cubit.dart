import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';

@injectable
class BengkelProfileCubit extends Cubit<BengkelProfile> {
  BengkelProfileCubit(super.initialState);
}
