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
import 'package:service_go/infrastructure/utils/color_utils.dart';
import 'package:service_go/infrastructure/utils/notification/notification/sg_notification.dart';
import 'package:service_go/infrastructure/utils/sg_intents.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/image/multi_image_field.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:service_go/infrastructure/widgets/layouts/expandable_container.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/infrastructure/widgets/qr/qr_dialog.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/domain/model/servis_status_data.dart';
import 'package:service_go/modules/service/presentation/cubits/detail/servis_detail_cubit.dart';
import 'package:service_go/modules/service/presentation/widgets/status/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/status_desc/servis_status_desc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../infrastructure/utils/value_validator/form_validator.dart';

//Information
part 'widgets/information.dart';
part 'widgets/information/servis_section.dart';
part 'widgets/information/layanan.dart';
part 'widgets/information/notes.dart';
part 'widgets/information/bengkel.dart';
part 'widgets/information/detail_servis.dart';
part 'widgets/information/alasan_penolakan.dart';

//Action
part 'widgets/actions.dart';
part 'widgets/actions/konfirmasi.dart';

@RoutePage()
class ServisCustomerDetailScreen extends StatelessWidget {
  final String servisId;
  const ServisCustomerDetailScreen(
      {super.key, @PathParam('id') required this.servisId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ServisDetailCubit>()..getById(servisId),
      child: Scaffold(
        appBar: const SGAppBar(
          pageTitle: "Detail Servis",
        ),
        body: BlocBuilder<ServisDetailCubit, ServisDetailState>(
          builder: (context, state) => switch (state) {
            ServisDetailSuccess() => _Content(servisDetail: state.servis),
            ServisDetailError() => SGError(message: state.message),
            ServisDetailLoading() => const SGLoadingOverlay()
          },
        ),
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
        _port.sendPort, SGNavigationNotifList.customerServis.path);
    _port.listen((message) {
      if (message is Map<String, dynamic>) {
        final id = message["id"];
        if (id != widget.servisDetail.servis.id.id) return;
        _refresh();
      }
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping(
        SGNavigationNotifList.customerServis.path);
    super.dispose();
  }

  void _refresh() {
    context
        .read<ServisDetailCubit>()
        .getById(widget.servisDetail.servis.id.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async => _refresh(),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: _Information(servisDetail: widget.servisDetail)),
        ),
        _Actions(servisStatusData: widget.servisDetail.servis.statusData),
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
    );
  }
}
