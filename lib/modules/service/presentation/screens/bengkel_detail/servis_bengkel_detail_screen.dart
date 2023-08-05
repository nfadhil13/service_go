import 'dart:isolate';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/date_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/notification/notification/sg_notification.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/image/multi_image_field.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:service_go/infrastructure/widgets/layouts/expandable_container.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/infrastructure/widgets/time_counter.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/data_pengambilan.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';
import 'package:service_go/modules/service/presentation/cubits/detail/servis_detail_cubit.dart';
import 'package:service_go/modules/service/presentation/widgets/status/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/status_desc/servis_status_desc.dart';

//Information
part 'widgets/information.dart';
part 'widgets/information/servis_section.dart';
part 'widgets/information/layanan.dart';
part 'widgets/information/notes.dart';
part 'widgets/information/detail_servis.dart';
part 'widgets/information/data_pengambilan.dart';
part 'widgets/information/data_pembatalan.dart';

//Actions
part 'widgets/actions.dart';
part 'widgets/actions/diajukan.dart';
part 'widgets/actions/terima_unit.dart';
part 'widgets/actions/ditolak.dart';
part 'widgets/actions/pemeriksaan_unit.dart';
part 'widgets/actions/pengajuan_servis.dart';
part 'widgets/actions/mulai_pengerjaan.dart';
part 'widgets/actions/pengerjaan_selesai.dart';
part 'widgets/actions/selesaikan.dart';
part 'widgets/actions/dibatalkan.dart';

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

class _Content extends StatefulWidget {
  final ServisDetail servisDetail;
  const _Content({required this.servisDetail});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, SGNavigationNotifList.bengkelServis.path);
    _port.listen((message) {
      if (message is Map<String, dynamic>) {
        final id = message["id"];
        if (id != widget.servisDetail.servis.id) return;
        _refresh();
      }
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping(
        SGNavigationNotifList.bengkelServis.path);
    super.dispose();
  }

  Future<void> _refresh() async {
    context
        .read<ServisDetailCubit>()
        .getById(widget.servisDetail.servis.id.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () => _refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  _Information(servisDetail: widget.servisDetail),
                  18.verticalSpace,
                  SGHideWidget(
                      child: _Actions(servisDetail: widget.servisDetail))
                ],
              ),
            ),
          ),
        ),
        if (context.userSession.userId == widget.servisDetail.bengkelProfile.id)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _Actions(servisDetail: widget.servisDetail),
            ],
          )
      ],
    );
  }
}
