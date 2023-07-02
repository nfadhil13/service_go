import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/buttons/outlined_button.dart';
import 'package:service_go/infrastructure/widgets/icons/service_geo.dart';
import 'package:service_go/modules/authentication/presentation/screens/register/cubit/register_cubit.dart';
import 'package:sizer/sizer.dart';
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
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: BlocListener<RegisterCubit, RegisterState>(
              listener: (context, state) async {
                if (state is RegisterSuccess) {
                  // context.router.replaceAll([const HomeRoute()]);
                }
              },
              child: Stack(
                children: [
                  const Align(alignment: Alignment.center, child: _LoginForm()),
                  BlocBuilder<RegisterCubit, RegisterState>(
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
      ),
    );
  }
}
