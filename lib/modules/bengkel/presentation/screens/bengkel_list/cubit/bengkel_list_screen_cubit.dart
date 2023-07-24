import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';

class BengkelListScreenCubit extends Cubit<BengkelListScreenCubitState> {
  final List<BengkelProfileWithDistance> bengkelList;
  BengkelListScreenCubit(super.initialState)
      : bengkelList = initialState.bengkelList;

  void selectBengkel(BengkelProfileWithDistance selectedBengkel) {
    final newBengkelList = [...bengkelList]
      ..removeWhere((element) => element.data.id == selectedBengkel.data.id);
    emit(BengkelListScreenCubitState(selectedBengkel, newBengkelList));
  }

  void clear() {
    emit(BengkelListScreenCubitState(null, bengkelList));
  }
}

class BengkelListScreenCubitState extends Equatable {
  final BengkelProfileWithDistance? selectedBengkel;
  final List<BengkelProfileWithDistance> bengkelList;

  const BengkelListScreenCubitState(this.selectedBengkel, this.bengkelList);

  @override
  List<Object?> get props => [selectedBengkel, bengkelList];
}
