part of '../servis_bengkel_detail_screen.dart';

class _Information extends StatelessWidget {
  final ServisDetail servisDetail;
  const _Information({required this.servisDetail});

  @override
  Widget build(BuildContext context) {
    final servis = servisDetail.servis;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ServisDetail(servis: servisDetail.servis),
        24.verticalSpace,
        if (servis.keteranganServis != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _DetailServis(
                keteranganServis: servis.keteranganServis!,
                status: servis.status),
          ),
        _Layanan(layananList: servisDetail.servis.layanan),
        12.verticalSpace,
        _Notes(note: servisDetail.servis.catatan),
      ],
    );
  }
}