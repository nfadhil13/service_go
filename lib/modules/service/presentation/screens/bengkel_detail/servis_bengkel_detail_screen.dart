import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/date_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/image/multi_image_field.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';
import 'package:service_go/modules/service/presentation/cubits/detail/servis_detail_cubit.dart';
import 'package:service_go/modules/service/presentation/widgets/status/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/status_desc/servis_status_desc.dart';
import 'package:sizer/sizer.dart';

//Information
part 'widgets/information.dart';
part 'widgets/information/servis_section.dart';
part 'widgets/information/layanan.dart';
part 'widgets/information/notes.dart';

//Actions
part 'widgets/actions.dart';
part 'widgets/actions/diajukan.dart';
part 'widgets/actions/terima_unit.dart';
part 'widgets/actions/ditolak.dart';
part 'widgets/actions/pemeriksaan_unit.dart';
part 'widgets/actions/pengajuan_servis.dart';

@RoutePage()
class ServisBengkelDetailScreen extends StatelessWidget {
  final String servisId;
  const ServisBengkelDetailScreen(
      {super.key, @PathParam('id') required this.servisId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ServisDetailCubit>()..getById(servisId),
      child: Stack(
        children: [
          Scaffold(
            appBar: const SGAppBar(
              pageTitle: "Detail Servis",
            ),
            body: BlocBuilder<ServisDetailCubit, ServisDetailState>(
              builder: (context, state) => switch (state) {
                ServisDetailSuccess() => _Content(servisDetail: state.servis),
                ServisDetailError() => SGError(message: state.message),
                ServisDetailLoading() => const SizedBox()
              },
            ),
          ),
          BlocBuilder<ServisDetailCubit, ServisDetailState>(
            builder: (context, state) {
              if (state is ServisDetailLoading ||
                  state is ServisDetailSuccessUpdating) {
                return const SGLoadingOverlay();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final ServisDetail servisDetail;
  const _Content({required this.servisDetail});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                _Information(servisDetail: servisDetail),
                18.verticalSpace,
                SGHideWidget(child: _Actions(servisDetail: servisDetail))
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _Actions(servisDetail: servisDetail),
          ],
        )
      ],
    );
  }
}
