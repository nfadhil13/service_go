import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/indonesia_plat_nomor.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/buttons/button_icon_type.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/buttons/outlined_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/date_time_picker.dart';
import 'package:service_go/infrastructure/widgets/form/multi_select.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/presentation/screens/customer_form/cubit/customer_servis_form_cubit.dart';
import 'package:sizer/sizer.dart';

part 'widgets/selected_bengkel.dart';
part 'widgets/form.dart';
part 'widgets/button.dart';

sealed class CustomerServisFormScreenMode {}

class CustomerServisFormCreate extends CustomerServisFormScreenMode {
  final String bengkelId;
  final BengkelProfile? bengkelProfile;

  CustomerServisFormCreate.byId({required this.bengkelId})
      : bengkelProfile = null;

  CustomerServisFormCreate.byBengkel(
      {required BengkelProfile this.bengkelProfile})
      : bengkelId = bengkelProfile.id;
}

class CustomerServisFormEdit extends CustomerServisFormScreenMode {
  final String servisId;

  CustomerServisFormEdit(this.servisId);
}

@RoutePage()
class CustomerServisFormScreen extends StatelessWidget {
  final CustomerServisFormScreenMode mode;
  const CustomerServisFormScreen({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomerServisFormCubit>()..init(mode),
      child: Scaffold(
        appBar: const SGAppBar(
          pageTitle: "Pesan Servis Motor",
        ),
        body: BlocConsumer<CustomerServisFormCubit, CustomerServisFormState>(
          listener: (context, state) {
            if (state is CustomerServisReadySuccess) {
              context.messenger.showSuccessSnackbar("Berhasi membuat pesanan");
              context.router.pop();
            }
          },
          builder: (context, state) => switch (state) {
            CustomerServisFormPrepareLoading() => const SGLoadingOverlay(),
            CustomerServisFormPrepareError() => SGError(
                message: state.message,
                retry: () {
                  context.read<CustomerServisFormCubit>().init(mode);
                }),
            CustomerServisFormPrepareSuccess() => _Ready(
                bengkel: state.bengkelProfile, initialServis: state.servis),
          },
        ),
      ),
    );
  }
}

class _Ready extends StatelessWidget {
  const _Ready({
    super.key,
    required this.bengkel,
    this.initialServis,
  });

  final BengkelProfile bengkel;
  final Servis? initialServis;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 2.5.h),
            child: Column(
              children: [
                _SelectedBengkel(profile: bengkel),
                3.h.verticalSpace,
                _Form(
                  profile: bengkel,
                ),
                3.h.verticalSpace
              ],
            ),
          ),
        ),
        SizedBox.expand(
            child: Container(
          alignment: Alignment.bottomCenter,
          child: const _Button(),
        ))
      ],
    );
  }
}
