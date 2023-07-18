import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/profile/presentation/screens/customer_profile_form/cubit/customer_profile_form_cubit.dart';
import 'package:sizer/sizer.dart';

part 'widgets/form.dart';

@RoutePage()
class CustomProfileFormScreen extends StatelessWidget {
  final VoidCallback? onCustomerProfileCreated;
  const CustomProfileFormScreen({super.key, this.onCustomerProfileCreated});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CustomerProfileFormCubit>(param1: context.userSession.userId)
            ..prepareForm(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: context.color.background,
            appBar: const SGAppBar(
              pageTitle: "Profile",
            ),
            body: BlocConsumer<CustomerProfileFormCubit,
                CustomerProfileFormState>(
              listener: (context, state) {
                if (state is CustomerProfileFormSubmitSuccess) {
                  onCustomerProfileCreated?.call();
                }
              },
              builder: (context, state) {
                return switch (state) {
                  CustomerProfileFormPrepareLoading() =>
                    const SGLoadingOverlay(),
                  CustomerProfileFormPrepareError() =>
                    SGError(message: state.message, retry: state.retry),
                  CustomerProfileFormReady() => _Form(
                      profile: state.customerProfile,
                    )
                };
              },
            ),
          ),
          BlocBuilder<CustomerProfileFormCubit, CustomerProfileFormState>(
            builder: (context, state) {
              if (state is! CustomerProfileFormSubmitLoading) {
                return const SizedBox();
              }
              return const SGLoadingOverlay();
            },
          )
        ],
      ),
    );
  }
}
