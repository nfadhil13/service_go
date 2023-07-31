part of 'servis_detail_cubit.dart';

sealed class ServisDetailState extends Equatable {
  const ServisDetailState();

  @override
  List<Object> get props => [];
}

class ServisDetailLoading extends ServisDetailState {}

class ServisDetailSuccess extends ServisDetailState {
  final ServisDetail servis;

  const ServisDetailSuccess(this.servis);
}

class ServisDetailError extends ServisDetailState {
  final String message;

  const ServisDetailError(this.message);
}
