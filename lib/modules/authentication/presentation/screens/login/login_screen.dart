import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:service_go/gen/assets.gen.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/architecutre/cubits/session/session_cubit.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/authentication/presentation/screens/login/cubit/login_cubit.dart';

part 'widgets/form.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        body: Center(
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                context.read<SessionCubit>().setCurrenetUser(state.session);
                context.router.push(const HomeRoute());
              }
            },
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Assets.images.landingpage.provider(),
                          fit: BoxFit.cover)),
                ),
                const Align(alignment: Alignment.center, child: _LoginForm()),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      context.messenger.showErrorSnackbar(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is! LoginLoading) {
                      return const SizedBox();
                    }
                    return const ServiceGoLoadingOverlay();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
