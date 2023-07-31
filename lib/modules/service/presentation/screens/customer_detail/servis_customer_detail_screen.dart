import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/date_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/sg_intents.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/infrastructure/widgets/qr/qr_dialog.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_detail.dart';
import 'package:service_go/modules/service/presentation/cubits/detail/servis_detail_cubit.dart';
import 'package:service_go/modules/service/presentation/widgets/list/servis_list_widget.dart';
import 'package:service_go/modules/service/presentation/widgets/status/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/status_desc/servis_status_desc.dart';
import 'package:sizer/sizer.dart';

part 'widgets/servis_section.dart';
part 'widgets/layanan.dart';
part 'widgets/notes.dart';
part 'widgets/bengkel.dart';

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

class _Content extends StatelessWidget {
  final ServisDetail servisDetail;
  const _Content({required this.servisDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ServisDetail(servis: servisDetail.servis),
            18.verticalSpace,
            _Layanan(layananList: servisDetail.servis.layanan),
            18.verticalSpace,
            _Notes(note: servisDetail.servis.catatan),
            18.verticalSpace,
            _QRButton(servisDetail: servisDetail),
            12.verticalSpace,
            Divider(
              color: context.color.outline,
            ),
            12.verticalSpace,
            _Bengkel(bengkelProfile: servisDetail.bengkelProfile)
          ],
        ),
      ),
    );
  }
}

class _QRButton extends StatelessWidget {
  const _QRButton({
    super.key,
    required this.servisDetail,
  });

  final ServisDetail servisDetail;

  @override
  Widget build(BuildContext context) {
    return SGElevatedButton(
      label: "Lihat QR",
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      onPressed: () {
        SGQRDialog.showAsDialog(context, qrData: servisDetail.servis.id.id!);
      },
    );
  }
}
