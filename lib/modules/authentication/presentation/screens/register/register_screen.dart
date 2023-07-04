import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/form/dropdown.dart';
import 'package:service_go/infrastructure/widgets/form/password_field.dart';
import 'package:service_go/infrastructure/widgets/icons/service_geo.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:service_go/modules/authentication/presentation/screens/register/cubit/register_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/authentication/presentation/screens/login/cubit/login_cubit.dart';

part 'widgets/form.dart';
part 'widgets/verif_email_sent.dart';

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
                  InformationDialog.launch(context,
                      onConfirm: (closeDialogCallback) {
                    closeDialogCallback();

                    context.router.replaceAll([const LoginRoute()]);
                  },
                      title: "Berhasil daftar",
                      descWidget: const _VerificationEmailSent(
                          email: "bengkeldani@gmail.com"));
                }
              },
              child: Stack(
                children: [
                  const Align(alignment: Alignment.center, child: _LoginForm()),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state is! RegisterLoading) {
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
