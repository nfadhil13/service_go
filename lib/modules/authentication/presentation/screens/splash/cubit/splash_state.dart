part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState {
  final UserSession? userSession;
  final SGNavigationNotif? navNotif;

  const SplashSuccess(this.userSession, this.navNotif);
}
