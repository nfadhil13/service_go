part of 'admin_home_screen_cubit.dart';

sealed class AdminHomeScreenState extends Equatable {
  const AdminHomeScreenState();

  @override
  List<Object> get props => [];
}

class AdminHomeScreenLoading extends AdminHomeScreenState {}

class AdminHomeScreenSuccess extends AdminHomeScreenState {
  final int servisCount;
  final int customerCount;
  final int bengkelCount;
  final int jenisLayananCout;

  const AdminHomeScreenSuccess(
      {required this.servisCount,
      required this.customerCount,
      required this.jenisLayananCout,
      required this.bengkelCount});
}

class AdminHomeScreenError extends AdminHomeScreenState {
  final String message;

  const AdminHomeScreenError(this.message);
}
