part of 'servis_detail_cubit.dart';

sealed class ServisDetailState extends Equatable {
  const ServisDetailState();

  @override
  List<Object> get props => [];
}

class ServisDetailLoading extends ServisDetailState {}

sealed class ServisDetailSuccess extends ServisDetailState {
  final ServisDetail servis;

  const ServisDetailSuccess(this.servis);

  @override
  List<Object> get props => [servis];
}

class ServisDetailError extends ServisDetailState {
  final String message;

  const ServisDetailError(this.message);
}

class ServisDetailSuccessIdle extends ServisDetailSuccess {
  const ServisDetailSuccessIdle(super.servis);
}

class ServisDetailSuccessUpdating extends ServisDetailSuccess {
  const ServisDetailSuccessUpdating(super.servis);
}
