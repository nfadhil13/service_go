import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/image/image_picker.dart';
import 'package:service_go/infrastructure/widgets/form/map_field.dart';
import 'package:service_go/infrastructure/widgets/form/multi_select.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/infrastructure/widgets/map/map_picker.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile_form/cubit/form/bengkel_profile_form_cubit.dart';
import 'package:sizer/sizer.dart';

part 'widgets/form.dart';

@RoutePage()
class BengkelProfileFormScreen extends StatelessWidget {
  final void Function(BengkelProfile profile)? onBengkelProfileCreated;
  const BengkelProfileFormScreen({super.key, this.onBengkelProfileCreated});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BengkelProfileFormCubit>(param1: context.userSession.userId)
            ..prepareForm(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: context.color.background,
            appBar: SGAppBar(
              pageTitle: "Profile",
              actions: [
                SGAppBarItemAction.icon(
                    icon: Icons.logout,
                    onTap: () {
                      context.logout();
                    }),
              ],
            ),
            body: BlocBuilder<BengkelProfileFormCubit, BengkelProfileFormState>(
              builder: (context, state) {
                return switch (state) {
                  BengkelProfileFormPrepareLoading() =>
                    const SGLoadingOverlay(),
                  BengkelProfileFormPrepareError() =>
                    SGError(message: state.message, retry: state.retry),
                  BengkelProfileFormReady() => _Form(
                      bengkelProfile: state.bengkelProfile,
                      jenisLayananList: state.jenisLayanan,
                    )
                };
              },
            ),
          ),
          BlocConsumer<BengkelProfileFormCubit, BengkelProfileFormState>(
            listener: (context, state) {
              if (state is BengkelProfileFormSubmitSuccess) {
                onBengkelProfileCreated?.call(state.profile);
              }
            },
            builder: (context, state) {
              if (state is! BengkelProfileFormSubmitLoading) {
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
