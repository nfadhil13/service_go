import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/sg_time_range_picker.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/layouts/expandable_container.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/presentation/screens/jadwal_bengkel/cubit/jadwal_bengkel_cubit.dart';
import 'package:sizer/sizer.dart';

part 'widgets/form.dart';

@RoutePage()
class JadwalBengkelFormScreen extends StatelessWidget {
  const JadwalBengkelFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<JadwalBengkelCubit>()
          ..getJadwalBengkel(context.userSession.userId),
        child: Scaffold(
          appBar: const SGAppBar(),
          body: BlocConsumer<JadwalBengkelCubit, JadwalBengkelState>(
            listener: (context, state) {
              if (state is JadwalBengkelIdle && state.isUpdated) {
                context.router.pop(true);
              }
            },
            builder: (context, state) => switch (state) {
              JadwalBengkelError() => SGError(message: state.message),
              JadwalBengkelIdle() => _Content(
                  jadwalBengkel: state.jadwalBengkel,
                  isLoading: state is JadwalBengkelPostLoading),
              JadwalBengkelLoading() => const SGLoadingOverlay()
            },
          ),
        ));
  }
}

class _Content extends StatelessWidget {
  final JadwalBengkel jadwalBengkel;
  final bool isLoading;
  const _Content(
      {super.key, required this.jadwalBengkel, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Form(jadwal: jadwalBengkel),
        if (isLoading) const SGLoadingOverlay()
      ],
    );
  }
}
