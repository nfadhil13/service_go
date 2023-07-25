import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bengkel_detail_screen_state.dart';

class BengkelDetailScreenCubit extends Cubit<BengkelDetailScreenState> {
  BengkelDetailScreenCubit() : super(BengkelDetailScreenInitial());
}
