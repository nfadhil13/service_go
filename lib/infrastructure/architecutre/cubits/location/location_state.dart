part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final SGLocation location;

  const LocationSuccess(this.location);
}
