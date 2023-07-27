part of 'servis_list_cubit.dart';

sealed class ServisListState extends Equatable {
  const ServisListState();

  @override
  List<Object> get props => [];
}

class ServisListLoading extends ServisListState {}

class ServisListSuccess extends ServisListState {
  final List<Servis> servisList;

  const ServisListSuccess(this.servisList);
}

class ServisListError extends ServisListState {
  final BaseException exception;

  const ServisListError(this.exception);
}
