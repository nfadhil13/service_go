import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/infrastructure/utils/firebase_messanger_util.dart';
import 'package:service_go/infrastructure/utils/notification/notification/sg_notification.dart';
import 'package:service_go/modules/authentication/domain/model/user_session.dart';
import 'package:service_go/modules/authentication/domain/usecases/get_current_session.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetCurrentSession _getCurrentSession;
  SplashCubit(this._getCurrentSession) : super(SplashInitial());

  void getLastSession() async {
    emit(SplashInitial());
    final result = await _getCurrentSession.execute();
    await Future.delayed(const Duration(seconds: 1));
    switch (result) {
      case Success():
        final (session, navNotif) = result.data;
        emit(SplashSuccess(session, navNotif));
      case Error():
        emit(const SplashSuccess(null, null));
    }
  }

  Future<RemoteMessage?> _getInitialMessage() async {
    return await FirebaseHelper.getInitialMessage();
  }
}
