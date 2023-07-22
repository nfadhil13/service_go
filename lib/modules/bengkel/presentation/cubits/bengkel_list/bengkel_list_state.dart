part of 'bengkel_list_cubit.dart';

sealed class BengkelListState extends Equatable {
  const BengkelListState();

  @override
  List<Object> get props => [];
}

class BengkelListLoading extends BengkelListState {}

class BengkelListSuccess extends BengkelListState {
  final List<BengkelProfileWithDistance> bengkelList;

  const BengkelListSuccess(this.bengkelList);
}

class BengkelListError extends BengkelListState {
  final BaseException exception;

  const BengkelListError(this.exception);
}
